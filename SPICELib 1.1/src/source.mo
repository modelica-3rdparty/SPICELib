

package SOURCE

  partial model Stimulus
    extends INTERFACE.OnePort;
    replaceable model TransientSpecification = WAVEFORMS.NULL extends INIT.Part;
    extends TransientSpecification;
    // DC and AC analyses parameters
    parameter SignalType DC_VALUE=0 "DC value";
    parameter SignalType AC_MAG=0 "AC magnitude value";
    parameter nonSI.Angle_deg AC_PHASE=0 "AC phase value";

  protected
    SignalType DCvalue "DC analysis signal";
    SignalType signalTran "Tran analysis signal";
    // Time-related auxiliary variables
    SI.Time timeStartRampDC;
    SI.Time timeStartRampT;
  equation
    // DC-model signal
    when ctrl_DC then
      timeStartRampDC = time;
    end when;
    DCvalue = if (ctrl_DC or ctrl_AC) and ctrl_OP_mode == 0 and ctrl_OP_value
       == 0 then DC_VALUE else if ctrl_DC and ctrl_OP_mode == 0 and
      ctrl_OP_value == 1 then TRANS_INITIAL else if ctrl_DC and ctrl_OP_mode
       == 1 and ctrl_OP_value == 0 then DC_VALUE*(time - timeStartRampDC)/
      TIME_SCALE else if ctrl_DC and ctrl_OP_mode == 1 and ctrl_OP_value == 1
       then TRANS_INITIAL*(time - timeStartRampDC)/TIME_SCALE else 0;
    // Transient-model signal
    when ctrl_Tran then
      timeStartRampT = time;
    end when;

    signalTran = if ctrl_Tran then signal else if ctrl_IS_TranOP and
      ctrl_OP_mode == 0 and ctrl_OP_value == 0 then DC_VALUE else if
      ctrl_IS_TranOP and ctrl_OP_mode == 0 and ctrl_OP_value == 1 then
      TRANS_INITIAL else if ctrl_IS_TranOP and ctrl_OP_mode == 1 and
      ctrl_OP_value == 0 then DC_VALUE*(time - timeStartRampT)/TIME_SCALE else
      if ctrl_IS_TranOP and ctrl_OP_mode == 1 and ctrl_OP_value == 1 then
      TRANS_INITIAL*(time - timeStartRampT)/TIME_SCALE else 0;
  end Stimulus;

  model VSource
    extends Stimulus(redeclare type SignalType = SI.Voltage);
    // Contribution to the total power dissipation
    outer INTERFACE.PowerDissipation TotalPowerDissipation;
    INTERFACE.PowerDissipation powerDissipation annotation (extent=[0, 0; 0, 0]);
    parameter Boolean HIDDEN_COMPONENT=false "Enable or disable log";
  protected
    SI.Current iAC_mag(start=0) "Magnitude of AC small-signal current";
    SI.Current iAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal current";

    nonSI.Angle_deg iAC_phase(start=0) "Phase (deg) of AC small-signal current";
  equation

    // DC contitutive relation
    0 = if ctrl_IS_inhibit then iDC else vDC - DCvalue;
    // Transient constitutive relation
    vTran = signalTran;
    // AC small-signal constitutive relation
    {vAC_Re,vAC_Im} = if ctrl_AC then {AC_MAG*cos(Deg2Rad(AC_PHASE)),AC_MAG*sin(
      Deg2Rad(AC_PHASE))} else zeros(2);
    (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
    iAC_mag_dB = Decibels(iAC_mag);
    // Contribution to the total power disipation
    when ctrl_log_DC then
      powerDissipation.dissipatedPower = vDC*(-iDC);
    end when;
    connect(powerDissipation, TotalPowerDissipation);
    // Log static analysis results
    when ctrl_log_DC and (HIDDEN_COMPONENT == false or LOG_RESULTS == 2 and
        HIDDEN_COMPONENT == true) then
      LogVariable(iDC);
    end when;
    when ctrl_log_DC and (HIDDEN_COMPONENT == false and LOG_RESULTS > 0 or
        HIDDEN_COMPONENT == true and LOG_RESULTS == 2) then
      LogVariable(powerDissipation.dissipatedPower);
    end when;
    // AC small-signal results
    when ctrl_log_AC and (HIDDEN_COMPONENT == false or LOG_RESULTS == 2 and
        HIDDEN_COMPONENT == true) then
      LogVariable(iAC_mag);
      LogVariable(iAC_mag_dB);
      LogVariable(iAC_phase);
    end when;
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[-140, 165; 140, 220],
          string="DC=%DC_VALUE",
          style(color=0)),
        Text(
          extent=[-140, 110; 140, 165],
          string="ACM=%AC_MAG",
          style(color=0)),
        Text(
          extent=[-140, 55; 140, 110],
          string="ACP=%AC_PHASE",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Ellipse(extent=[-60, -60; 60, 60], style(thickness=1, color=3)),
        Line(points=[-100, 0; -60, 0], style(thickness=1, color=3)),
        Line(points=[60, 0; 100, 0], style(thickness=1, color=3))));
  end VSource;

  model ISource
    extends Stimulus(redeclare type SignalType = SI.Current);
  equation
    // DC constitutive relation
    0 = if ctrl_IS_inhibit then vDC else iDC - DCvalue;
    // Transient constitutive relation
    iTran = signalTran;
    // AC small-signal constitutive relation
    {iAC_Re,iAC_Im} = if ctrl_AC then {AC_MAG*cos(Deg2Rad(AC_PHASE)),AC_MAG*sin(
      Deg2Rad(AC_PHASE))} else zeros(2);
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[-140, 165; 140, 220],
          string="DC=%DC_VALUE",
          style(color=0)),
        Text(
          extent=[-140, 110; 140, 165],
          string="ACM=%AC_MAG",
          style(color=0)),
        Text(
          extent=[-140, 55; 140, 110],
          string="ACP=%AC_PHASE",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Ellipse(extent=[-60, -60; 60, 60], style(thickness=1, color=3)),
        Line(points=[-50, 0; 50, 0], style(thickness=1, color=3)),
        Line(points=[20, 20; 50, 0], style(thickness=1, color=3)),
        Line(points=[20, -20; 50, 0], style(thickness=1, color=3)),
        Line(points=[-100, 0; -60, 0], style(thickness=1, color=3)),
        Line(points=[60, 0; 100, 0], style(thickness=1, color=3))));
  end ISource;

  model E
    extends INTERFACE.TwoPort;
    parameter Real Gain=1;
  equation
    // Static Model
    iDC1 = 0;
    vDC2 = Gain*vDC1;

    //Transient Model
    iTran1 = 0;
    vTran2 = Gain*vTran1;

    //AC Model
    iAC_Re1 = 0;
    iAC_Im1 = 0;
    vAC_Re2 = Gain*vAC_Re1;
    vAC_Im2 = Gain*vAC_Im1;
    annotation (Icon(
        Text(
          extent=[-100, 55; 100, 110],
          string="%=Gain",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Rectangle(extent=[-60, 80; 80, -60]),
        Line(points=[-80, 60; -60, 60]),
        Line(points=[-80, -40; -60, -40]),
        Line(points=[80, 60; 100, 60]),
        Line(points=[80, -40; 100, -40]),
        Line(points=[-40, 68; -40, 52; -40, 60; -50, 60; -30, 60]),
        Line(points=[-50, -40; -30, -40]),
        Ellipse(extent=[0, 40; 58, -20]),
        Line(points=[30, 40; 30, 60; 80, 60]),
        Line(points=[30, -20; 30, -40; 80, -40]),
        Line(points=[30, 28; 30, 12; 30, 20; 20, 20; 40, 20]),
        Line(points=[20, 0; 40, 0; 38, 0])), Icon(
        Rectangle(extent=[-60, 80; 80, -60]),
        Line(points=[-80, 60; -60, 60]),
        Line(points=[-80, -40; -60, -40]),
        Line(points=[80, 60; 100, 60]),
        Line(points=[80, -40; 100, -40]),
        Line(points=[-40, 68; -40, 52; -40, 60; -50, 60; -30, 60]),
        Line(points=[-50, -20; -30, -20]),
        Ellipse(extent=[0, 40; 58, -20]),
        Line(points=[30, 40; 30, 60; 80, 60]),
        Line(points=[30, -20; 30, -40; 80, -40]),
        Line(points=[30, 28; 30, 12; 30, 20; 20, 20; 40, 20]),
        Line(points=[20, 0; 40, 0])));

  end E;

  model F
    extends INTERFACE.TwoPort;
    parameter Real Gain=1;
  equation
    // Static Model
    vDC1 = 0;
    iDC2 = Gain*iDC1;

    //Transient Model
    vTran1 = 0;
    iTran2 = Gain*iTran1;

    //AC Model
    vAC_Re1 = 0;
    vAC_Im1 = 0;
    iAC_Re2 = Gain*iAC_Re1;
    iAC_Im2 = Gain*iAC_Im1;
    annotation (Icon(
        Text(
          extent=[-100, 55; 100, 110],
          string="%=Gain",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Rectangle(extent=[-60, 80; 80, -60]),
        Line(points=[-78, 60; -58, 60]),
        Line(points=[-80, -40; -60, -40]),
        Line(points=[80, 60; 100, 60]),
        Line(points=[80, -40; 100, -40]),
        Ellipse(extent=[0, 40; 58, -20]),
        Line(points=[30, 34; 30, -12; 20, 0]),
        Line(points=[30, -12; 40, 0]),
        Line(points=[30, 40; 30, 60; 80, 60]),
        Line(points=[30, -20; 30, -40; 80, -40]),
        Line(points=[-58, 60; -20, 60; -20, -40; -60, -40]),
        Line(points=[-30, 20; -20, 8; -10, 20])));
  end F;

  model G
    extends INTERFACE.TwoPort;
    parameter SI.Conductance Gain=1;
  equation
    // Static Model
    iDC1 = 0;
    iDC2 = Gain*vDC1;

    //Transient Model
    iTran1 = 0;
    iTran2 = Gain*vTran1;

    //AC Model
    iAC_Re1 = 0;
    iAC_Im1 = 0;
    iAC_Re2 = Gain*vAC_Re1;
    iAC_Im2 = Gain*vAC_Im1;

    annotation (Icon(
        Text(
          extent=[-100, 55; 100, 110],
          string="%=Gain",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Rectangle(extent=[-60, 80; 80, -60]),
        Line(points=[-80, 60; -60, 60]),
        Line(points=[-80, -40; -60, -40]),
        Line(points=[80, 60; 100, 60]),
        Line(points=[80, -40; 100, -40]),
        Line(points=[-40, 68; -40, 52; -40, 60; -50, 60; -30, 60]),
        Line(points=[-48, -40; -28, -40]),
        Ellipse(extent=[0, 40; 58, -20]),
        Line(points=[30, 34; 30, -12; 20, 0]),
        Line(points=[30, -12; 40, 0]),
        Line(points=[30, 40; 30, 60; 80, 60]),
        Line(points=[30, -20; 30, -40; 80, -40])));
  end G;

  model H
    extends INTERFACE.TwoPort;
    parameter SI.Resistance Gain=1;
  equation
    // Static Model
    vDC1 = 0;
    vDC2 = Gain*iDC1;

    //Transient Model
    vTran1 = 0;
    vTran2 = Gain*iTran1;

    //AC Model
    vAC_Re1 = 0;
    vAC_Im1 = 0;
    vAC_Re2 = Gain*iAC_Re1;
    vAC_Im2 = Gain*iAC_Im1;
    annotation (Icon(
        Text(
          extent=[-100, 55; 100, 110],
          string="%=Gain",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Rectangle(extent=[-60, 80; 80, -60]),
        Line(points=[-80, 60; -60, 60]),
        Line(points=[-80, -40; -60, -40]),
        Line(points=[80, 60; 100, 60]),
        Line(points=[80, -40; 100, -40]),
        Ellipse(extent=[0, 40; 58, -20]),
        Line(points=[30, 40; 30, 60; 80, 60]),
        Line(points=[30, -20; 30, -40; 80, -40]),
        Line(points=[-60, 60; -20, 60; -20, -40; -58, -40; -60, -40]),
        Line(points=[-30, 20; -20, 8; -10, 20]),
        Line(points=[30, 28; 30, 12; 30, 20; 20, 20; 40, 20]),
        Line(points=[20, 0; 40, 0; 38, 0])));
  end H;
  annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71,
            thickness=2)), Text(
        extent=[-72, 20; 66, -22],
        style(thickness=2),
        string="SOURCE")));
end SOURCE;

