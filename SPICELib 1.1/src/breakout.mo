

package BREAKOUT

  model Ground
    extends INTERFACE.OnePin;
  equation
    {p.vDC,p.vTran,p.vAC_Re,p.vAC_Im} = zeros(4);
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[0, -100; 100, 0],
          string="0",
          style(color=0)),
        Line(points=[-10, -20; 10, -20], style(thickness=1, color=3)),
        Line(points=[-40, 20; 40, 20], style(color=3, thickness=1)),
        Line(points=[-70, 60; 70, 60], style(color=3, thickness=1)),
        Line(points=[-100, 100; 100, 100], style(color=3, thickness=1))));
  end Ground;

  model Rbreak
    extends INTERFACE.TwoPin;
    extends INIT.Part;
    parameter Boolean HIDDEN_COMPONENT=false "Enable or disable log";
    parameter SI.Resistance R=1000 "Resistance";
    constant SI.Resistance R_EPS=2e-4 "IC resistor";
    SI.Voltage vDC "DC voltage across the component";
    SI.Voltage vTran "Transient voltage across the component";
    SI.Voltage vAC_Re
      "Real part of AC small-signal voltage across the component";
    SI.Voltage vAC_Im
      "Imaginary part of AC small-signal voltage across the component";

    SI.Current iDC "DC current";
    SI.Current iTran "Transient/Small-signal current";
    SI.Current iAC_Re "Small-signal current. Real part";
    SI.Current iAC_Im "Small-signal current. Imaginary part";

    SI.Voltage vAC_mag(start=0)
      "Magnitude of AC small-signal voltage across the component";
    SI.Voltage vAC_mag_dB(start=0)
      "Magnitude (dB) of AC small-signal voltage across the component";
    nonSI.Angle_deg vAC_phase(start=0)
      "Phase (deg) of AC small-signal voltage across the component";

    SI.Current iAC_mag(start=0) "Magnitude of AC small-signal current";
    SI.Current iAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal current";

    nonSI.Angle_deg iAC_phase(start=0) "Phase (deg) of AC small-signal current";
    SI.Voltage pinP_vAC_mag(start=0);
    SI.Voltage pinP_vAC_phase(start=0);
    SI.Voltage pinP_vAC_mag_dB(start=0);

    SI.Voltage pinN_vAC_mag(start=0);
    SI.Voltage pinN_vAC_phase(start=0);
    SI.Voltage pinN_vAC_mag_dB(start=0);
  protected
    SI.Current iDCclampP;
    SI.Current iDCclampN;
    SI.Voltage vDCclampP(start=0);
    SI.Voltage vDCclampN(start=0);
  equation
    // ------------------------------------------------
    // i, v sign criterion: Positive current flows from
    // the (+) node through the part to the (-) node
    // ------------------------------------------------
    {iDC,iTran,iAC_Re,iAC_Im} = {p.iDC + iDCclampP,p.iTran,p.iAC_Re,p.iAC_Im};
    {iDC,iTran,iAC_Re,iAC_Im} = -{n.iDC + iDCclampN,n.iTran,n.iAC_Re,n.iAC_Im};
    {vDC,vTran,vAC_Re,vAC_Im} = {p.vDC,p.vTran,p.vAC_Re,p.vAC_Im} - {n.vDC,n.
      vTran,n.vAC_Re,n.vAC_Im};
    // ------------
    // Static model
    // ------------
    vDC = R*iDC;
    when ctrl_RBREAK_Tran2DC then
      vDCclampP = p.vTran;
      vDCclampN = n.vTran;
    end when;
    {iDCclampP,iDCclampN} = if ctrl_RBREAK_Tran2DC then {vDCclampP - p.vDC,
      vDCclampN - n.vDC}/R_EPS else zeros(2);
    // ---------------
    // Transient model
    // ---------------
    vTran = R*iTran;
    // ---------------------
    // AC small-signal model
    // ---------------------

    {vAC_Re,vAC_Im} = R*{iAC_Re,iAC_Im};

    (pinP_vAC_mag,pinP_vAC_phase) = Rect2Polar({p.vAC_Re,p.vAC_Im});
    pinP_vAC_mag_dB = Decibels(pinP_vAC_mag);

    (pinN_vAC_mag,pinN_vAC_phase) = Rect2Polar({n.vAC_Re,n.vAC_Im});
    pinN_vAC_mag_dB = Decibels(pinN_vAC_mag);

    (vAC_mag,vAC_phase) = Rect2Polar({vAC_Re,vAC_Im});
    vAC_mag_dB = Decibels(vAC_mag);

    (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
    iAC_mag_dB = Decibels(iAC_mag);
    // ---------------------------
    // Log static analysis results
    // ---------------------------
    when ctrl_log_DC and ((HIDDEN_COMPONENT == false) or (LOG_RESULTS == 2 and
        HIDDEN_COMPONENT == true)) then
      LogVariable(p.vDC);
      LogVariable(n.vDC);
    end when;
    when ctrl_log_DC and ((HIDDEN_COMPONENT == false and LOG_RESULTS > 0) or (
        HIDDEN_COMPONENT == true and LOG_RESULTS == 2)) then
      LogVariable(vDC);
      LogVariable(iDC);
    end when;
    // ---------------------------
    // Log AC small-signal results
    // ---------------------------
    when ctrl_log_AC and (HIDDEN_COMPONENT == false or LOG_RESULTS == 2 and
        HIDDEN_COMPONENT == true) then
      LogVariable(pinP_vAC_mag);
      LogVariable(pinP_vAC_phase);
      LogVariable(pinP_vAC_mag_dB);
      LogVariable(pinN_vAC_mag);
      LogVariable(pinN_vAC_phase);
      LogVariable(pinN_vAC_mag_dB);
    end when;
    when ctrl_log_AC and (HIDDEN_COMPONENT == false and LOG_RESULTS > 0 or
        HIDDEN_COMPONENT == true and LOG_RESULTS == 2) then
      LogVariable(vAC_mag);
      LogVariable(vAC_mag_dB);
      LogVariable(vAC_phase);
      LogVariable(iAC_mag);
      LogVariable(iAC_mag_dB);
      LogVariable(iAC_phase);
    end when;
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[-100, 55; 100, 110],
          string="%=R",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Line(points=[-65, 0; -50, 30; -30, -30; -10, 30; 10, -30; 30, 30; 50, -30;
               65, 0], style(thickness=1, color=3)),
        Line(points=[-100, 0; -65, 0], style(color=3, thickness=1)),
        Line(points=[65, 0; 100, 0], style(color=3, thickness=1))));
  end Rbreak;

  partial model Capacitor
    /*
--- Cvar and CvarAC have to be defined ---
*/

    extends INTERFACE.TwoPin;
    extends INIT.Part;
    constant SI.Resistance R_EPS=2e-4 "IC resistor";
    parameter SI.Voltage IC=0 "Initial voltage";
    parameter Boolean IC_ENABLED=false "IC enabled";
    constant Real pi=3.14159265358979;

    SI.Capacitance Cvar(start=1e-12) "Transient analysis capacitance";
    SI.Capacitance CvarAC(start=1E-12) "AC small-signal capacitance";

    SI.Voltage vDC "DC voltage across the capacitor";
    SI.Voltage vTran "Transient voltage across the capacitor";
    SI.Voltage vAC_Re
      "Real part of AC small-signal voltage across the capacitor";
    SI.Voltage vAC_Im
      "Imaginary part of AC small-signal voltage across the capacitor";
    SI.Current iDC "DC current";
    SI.Current iTran "Transient/Small-signal current";
    SI.Current iAC_Re "Small-signal current. Real part";
    SI.Current iAC_Im "Small-signal current. Imaginary part";

  protected
    SI.Current iClampTran;
    SI.Voltage vClampTran;
    SI.Voltage vClampDC;

    SI.Time timeClampTran;
    SI.Time timeClampDC;
  equation

    // ------------------------------------------------
    // i, v sign criterion: Positive current flows from
    // the (+) node through the part to the (-) node
    // ------------------------------------------------
    {iDC,iTran,iAC_Re,iAC_Im} = {p.iDC,p.iTran + iClampTran,p.iAC_Re,p.iAC_Im};
    {iDC,iTran,iAC_Re,iAC_Im} = -{n.iDC,n.iTran - iClampTran,n.iAC_Re,n.iAC_Im};

    {vDC,vTran,vAC_Re,vAC_Im} = {p.vDC,p.vTran,p.vAC_Re,p.vAC_Im} - {n.vDC,n.
      vTran,n.vAC_Re,n.vAC_Im};

    // ---------------
    // Transient model
    // ---------------
    //Cvar*der(vTran) = iTran;
    iClampTran = if ctrl_IC_clampTran and IC_ENABLED then (vClampTran - vTran)/
      R_EPS else 0;
    when ctrl_IC_clampTran and IC_ENABLED then
      timeClampTran = time;
    end when;
    vClampTran = if ctrl_IC_clampTran and IC_ENABLED and ctrl_IC_mode == 0
       then IC else if ctrl_IC_clampTran and IC_ENABLED and ctrl_IC_mode == 1
       then IC*(time - timeClampTran)/TIME_SCALE else 0;
    // Voltage initialization conditions
    when ctrl_CBREAK_Tran2IC and IC_ENABLED then
      reinit(vTran, IC);
    end when;
    when ctrl_CBREAK_Tran2DC then
      reinit(vTran, vDC);
    end when;
    when ctrl_CBREAK_resetTran then
      reinit(vTran, 0);
    end when;
    // ------------
    // Static model
    // ------------
    iDC = if ctrl_IC_clampDC and IC_ENABLED then (vDC - vClampDC)/R_EPS else 0;
    when ctrl_IC_clampDC and IC_ENABLED then
      timeClampDC = time;
    end when;
    vClampDC = if ctrl_IC_clampDC and IC_ENABLED and ctrl_IC_mode == 0 then IC
       else if ctrl_IC_clampDC and IC_ENABLED and ctrl_IC_mode == 1 then IC*(
      time - timeClampDC)/TIME_SCALE else 0;
    // ---------------------
    // AC small-signal model
    // ---------------------
    {vAC_Re,vAC_Im}*(2*pi*freq*CvarAC) = {iAC_Im,-iAC_Re};

    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Line(points=[-100, 0; -55, 0], style(color=3, thickness=1)),
        Line(points=[-55, 0; -20, 0], style(thickness=1, color=3)),
        Line(points=[-20, -40; -20, 40], style(thickness=1, color=3)),
        Line(points=[20, -40; 20, 40], style(thickness=1, color=3)),
        Line(points=[20, 0; 55, 0], style(thickness=1, color=3)),
        Line(points=[55, 0; 100, 0], style(color=3, thickness=1))));
  end Capacitor;

  model Capacitor1
    extends Capacitor;
    parameter SI.Capacitance C=1E-9 "Capacitance";
  equation
    // ---------------
    // Transient model
    // ---------------
    Cvar*der(vTran) = iTran;
    Cvar = C;
    CvarAC = C;

    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(Text(
          extent=[-100, 55; 100, 110],
          string="%=C",
          style(color=0))));
  end Capacitor1;

  model Cbreak

    extends INTERFACE.TwoPin;
    parameter SI.Capacitance C=1E-9 "Capacitance";
    parameter Boolean IC_ENABLED=false "IC enabled";
    parameter SI.Voltage IC=0 "Initial voltage";
    constant SI.Resistance R_eps2=2e-4
      "Resistance to avoid high index problems";
    SI.Voltage vDC "DC voltage across the capacitor";
    SI.Voltage vTran "Transient voltage across the capacitor";
    SI.Voltage vAC_Re
      "Real part of AC small-signal voltage across the capacitor";
    SI.Voltage vAC_Im
      "Imaginary part of AC small-signal voltage across the capacitor";
    SI.Current iDC "DC current";
    SI.Current iTran "Transient/Small-signal current";
    SI.Current iAC_Re "Small-signal current. Real part";
    SI.Current iAC_Im "Small-signal current. Imaginary part";
    SI.Voltage vAC_mag(start=0)
      "Magnitude of AC small-signal voltage across the component";
    SI.Voltage vAC_mag_dB(start=0)
      "Magnitude (dB) of AC small-signal voltage across the component";
    nonSI.Angle_deg vAC_phase(start=0)
      "Phase (deg) of AC small-signal voltage across the component";

    SI.Current iAC_mag(start=0) "Magnitude of AC small-signal current";
    SI.Current iAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal current";

    nonSI.Angle_deg iAC_phase(start=0) "Phase (deg) of AC small-signal current";
    SI.Voltage pinP_vAC_mag(start=0);
    SI.Voltage pinP_vAC_phase(start=0);
    SI.Voltage pinP_vAC_mag_dB(start=0);

    SI.Voltage pinN_vAC_mag(start=0);
    SI.Voltage pinN_vAC_phase(start=0);
    SI.Voltage pinN_vAC_mag_dB(start=0);

    Capacitor1 Capacitor(
      C=C,
      IC=IC,
      IC_ENABLED=IC_ENABLED) annotation (extent=[-50, -8; -30, 12]);
    Rbreak R_EPS2(HIDDEN_COMPONENT=true, R=R_eps2)
      "Resistor to avoid high index problems"
      annotation (extent=[4, -8; 24, 12]);
    annotation (Diagram);
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[-100, 55; 100, 110],
          string="%=C",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Line(points=[-100, 0; -55, 0], style(color=3, thickness=1)),
        Line(points=[-55, 0; -20, 0], style(thickness=1, color=3)),
        Line(points=[-20, -40; -20, 40], style(thickness=1, color=3)),
        Line(points=[20, -40; 20, 40], style(thickness=1, color=3)),
        Line(points=[20, 0; 55, 0], style(thickness=1, color=3)),
        Line(points=[55, 0; 100, 0], style(color=3, thickness=1))));
  equation
    {iDC,iTran,iAC_Re,iAC_Im} = {p.iDC,p.iTran,p.iAC_Re,p.iAC_Im};
    {vDC,vTran,vAC_Re,vAC_Im} = {p.vDC,p.vTran,p.vAC_Re,p.vAC_Im} - {n.vDC,n.
      vTran,n.vAC_Re,n.vAC_Im};
    (pinP_vAC_mag,pinP_vAC_phase) = Rect2Polar({p.vAC_Re,p.vAC_Im});
    pinP_vAC_mag_dB = Decibels(pinP_vAC_mag);

    (pinN_vAC_mag,pinN_vAC_phase) = Rect2Polar({n.vAC_Re,n.vAC_Im});
    pinN_vAC_mag_dB = Decibels(pinN_vAC_mag);

    (vAC_mag,vAC_phase) = Rect2Polar({vAC_Re,vAC_Im});
    vAC_mag_dB = Decibels(vAC_mag);

    (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
    iAC_mag_dB = Decibels(iAC_mag);
    connect(R_EPS2.n, n)
      annotation (points=[25, 2; 67.5, 2; 67.5, 0; 110, 0], style(color=1));
    connect(p, Capacitor.p)
      annotation (points=[-110, 0; -81, 0; -81, 2; -51, 2], style(color=1));
    connect(Capacitor.n, R_EPS2.p)
      annotation (points=[-29, 2; 3, 2], style(color=1));
  end Cbreak;

  partial model Inductor

    extends INTERFACE.TwoPin;
    extends INIT.Part;
    constant SI.Resistance R_BIG=1e9 "IC resistor";
    constant SI.Resistance R_BIG2=1e9 "Resistance to avoid high index problems";
    parameter SI.Voltage IC=0 "Initial current";
    parameter Boolean IC_ENABLED=false "IC enabled";

    constant Real pi=3.14159265358979;

    SI.Inductance Lvar "Transient analysis inductance";
    SI.Inductance LvarAC(start=1E-9) "AC small-signal inductance";

    SI.Voltage vDC "DC voltage across the inductor";
    SI.Voltage vTran "Transient voltage across the inductor";
    SI.Voltage vAC_Re
      "Real part of AC small-signal voltage across the inductor";
    SI.Voltage vAC_Im
      "Imaginary part of AC small-signal voltage across the inductor";
    SI.Current iDC "DC current";
    SI.Current iTran "Transient/Small-signal current";
    SI.Current iAC_Re "Small-signal current. Real part";
    SI.Current iAC_Im "Small-signal current. Imaginary part";
    SI.Voltage vAC_mag(start=0)
      "Magnitude of AC small-signal voltage across the component";
    SI.Voltage vAC_mag_dB(start=0)
      "Magnitude (dB) of AC small-signal voltage across the component";
    nonSI.Angle_deg vAC_phase(start=0)
      "Phase (deg) of AC small-signal voltage across the component";

    SI.Current iAC_mag(start=0) "Magnitude of AC small-signal current";
    SI.Current iAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal current";

    nonSI.Angle_deg iAC_phase(start=0) "Phase (deg) of AC small-signal current";
    SI.Voltage pinP_vAC_mag(start=0);
    SI.Voltage pinP_vAC_phase(start=0);
    SI.Voltage pinP_vAC_mag_dB(start=0);

    SI.Voltage pinN_vAC_mag(start=0);
    SI.Voltage pinN_vAC_phase(start=0);
    SI.Voltage pinN_vAC_mag_dB(start=0);
  protected
    SI.Current iClampTran;
    SI.Voltage iClampDC;
    SI.Voltage vClampDC;
    SI.Voltage vClampTran;

    SI.Time timeClampTran;
    SI.Time timeClampDC;
  equation
    // ------------------------------------------------
    // i, v sign criterion: Positive current flows from
    // the (+) node through the part to the (-) node
    // ------------------------------------------------
    {iDC,iTran,iAC_Re,iAC_Im} = {p.iDC,p.iTran - vTran/R_BIG2,p.iAC_Re - vAC_Re
      /R_BIG2,p.iAC_Im - vAC_Im/R_BIG2};
    {iDC,iTran,iAC_Re,iAC_Im} = -{n.iDC,n.iTran + vTran/R_BIG2,n.iAC_Re +
      vAC_Re/R_BIG2,n.iAC_Im + vAC_Im/R_BIG2};
    {vDC,vTran,vAC_Re,vAC_Im} = {p.vDC - vClampDC,p.vTran - vClampTran,p.vAC_Re,
      p.vAC_Im} - {n.vDC,n.vTran,n.vAC_Re,n.vAC_Im};
    // ---------------
    // Transient model
    // ---------------

    vClampTran = if ctrl_IC_clampTran and IC_ENABLED then (-iClampTran + iTran
       + vTran/R_BIG2)*R_BIG else 0;
    when ctrl_IC_clampTran and IC_ENABLED then
      timeClampTran = time;
    end when;
    iClampTran = if ctrl_IC_clampTran and IC_ENABLED and ctrl_IC_mode == 0
       then IC else if ctrl_IC_clampTran and IC_ENABLED and ctrl_IC_mode == 1
       then IC*(time - timeClampTran)/TIME_SCALE else 0;
    // Voltage initialization conditions
    when ctrl_CBREAK_Tran2IC and IC_ENABLED then
      reinit(iTran, IC);
    end when;
    when ctrl_CBREAK_Tran2DC then
      reinit(iTran, iDC);
    end when;
    when ctrl_CBREAK_resetTran then
      reinit(iTran, 0);
    end when;
    // ------------
    // Static model
    // ------------
    vDC = 0;
    vClampDC = if ctrl_IC_clampDC and IC_ENABLED then (iDC - iClampDC)*R_BIG
       else 0;
    when ctrl_IC_clampDC and IC_ENABLED then
      timeClampDC = time;
    end when;
    iClampDC = if ctrl_IC_clampDC and IC_ENABLED and ctrl_IC_mode == 0 then IC
       else if ctrl_IC_clampDC and IC_ENABLED and ctrl_IC_mode == 1 then IC*(
      time - timeClampDC)/TIME_SCALE else 0;
    // ---------------------
    // AC small-signal model
    // ---------------------
    {vAC_Re,vAC_Im} = {iAC_Im,-iAC_Re}*(2*pi*freq*LvarAC);
    (pinP_vAC_mag,pinP_vAC_phase) = Rect2Polar({p.vAC_Re,p.vAC_Im});
    pinP_vAC_mag_dB = Decibels(pinP_vAC_mag);

    (pinN_vAC_mag,pinN_vAC_phase) = Rect2Polar({n.vAC_Re,n.vAC_Im});
    pinN_vAC_mag_dB = Decibels(pinN_vAC_mag);

    (vAC_mag,vAC_phase) = Rect2Polar({vAC_Re,vAC_Im});
    vAC_mag_dB = Decibels(vAC_mag);

    (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
    iAC_mag_dB = Decibels(iAC_mag);

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.02,
        y=0.21,
        width=0.6,
        height=0.6),
      Icon(
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Line(points=[-99, 0; -70.384, 0; -69.116, 9.503; -65.233, 18.288; -57.964,
               25.671; -53.161, 27.909; -47.915, 28.702; -42.669, 27.909; -37.866,
               25.671; -30.598, 18.288; -27, 9.5]),
        Line(points=[-27, 9.5; -25.447, -1; -25.758, -5.757; -26.695, -10.432;
              -28.329, -15.064; -29.589, -17.457; -30.774, -18.371; -32.235, -18.696;
               -33.695, -18.371; -34.88, -17.457; -36.14, -15.064; -37.774, -10.432;
               -38.7, -4.5]),
        Line(points=[-38.711, -4.757; -39.022, 0.0; -37.755, 9.503; -33.871,
              18.288; -26.603, 25.671; -21.8, 27.909; -16.554, 28.702; -11.308,
               27.909; -6.505, 25.671; 0.764, 18.288; 4.647, 9.503; 5.915, 0.0;
               5.604, -4.757]),
        Line(points=[5.604, -4.757; 4.667, -9.432; 3.033, -14.064; 1.773, -16.457;
               0.588, -17.371; 0., 873, -17.696; -2.333, -17.371; -3.518, -16.457;
               -4.778, -14.064; -6.412, -9.432; -7.349, -4.757; -7.66, 0.0],
            style(color=0)),
        Line(points=[-7.411, -5.107; -7.722, -0.35; -6.455, 9.153; -2.571,
              17.938; 4.697, 25.321; 9.5, 27.559; 14.746, 28.352; 19.992,
              27.559; 24.795, 25.321; 32.064, 17.938; 35.947, 9.153; 37.215, -0.35;
               37.05, -1.95]),
        Line(points=[5.55, -4.2; 5.55, -5.25; 5.542, -5.957; 4.605, -10.632;
              2.971, -15.264; 1.711, -17.657; 0.526, -18.571; -0.935, -18.896;
              -2.395, -18.571; -3.58, -17.657; -4.84, -15.264; -6.474, -10.632;
               -7.4, -4.7]),
        Line(points=[23.939, -4.957; 23.628, -0.2; 24.895, 9.303; 28.779,
              18.088; 36.047, 25.471; 40.85, 27.709; 46.096, 28.502; 51.342,
              27.709; 56.145, 25.471; 63.414, 18.088; 67.297, 9.303; 68.55, 1.5;
               68.5, 0]),
        Line(points=[37.15, -1.85; 37.153, -1.55; 36.842, -6.307; 35.905, -10.982;
               34.271, -15.614; 33.011, -18.007; 31.826, -18.921; 30.365, -19.246;
               28.905, -18.921; 27.72, -18.007; 26.46, -15.614; 24.826, -10.982;
               23.9, -5.05]),
        Line(points=[68.55, 0; 100.05, 0])),
      Diagram);

  end Inductor;

  model Lbreak
    extends Inductor;
    parameter SI.Inductance L=1E-5 "Inductance";
    Real der_iTran "Voltage derivative [V/s]";
  equation
    // ---------------
    // Transient model
    // ---------------
    der_iTran = der(iTran);
    Lvar*der_iTran = vTran;
    Lvar = L;
    LvarAC = L;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.02,
        y=0.21,
        width=0.6,
        height=0.6),
      Icon(Text(
          extent=[-100, 55; 100, 110],
          string="%=L",
          style(color=0))));
  end Lbreak;

  package DIODE_PSPICE
    model I_DIODE
      extends INTERFACE.OnePort;
      extends INIT.Part;
      parameter SI.Current IS "Reverse saturation current at 300K";


        //  parameter SI.Conductance GMIN "Conductance in parallel with the pn-junction";
      parameter SI.Voltage BV "Reverse breakdown voltage (positive number)";
      parameter Real N "Emission coefficient";
      parameter SI.Current IKF "High injection knee current";
      parameter SI.Current ISR "Recombination current";
      parameter Real NR "Emission coefficient for ISR";
      parameter SI.Current IBV "Reverse breakdown current (positive number)";
      //  SI.Current IBV "Reverse breakdown current (positive number)";
      parameter Real M "Grading coefficient";
      parameter SI.Voltage VJ "Junction potencial";

      SI.Voltage vDiodeTran "Voltage drop across the current source";

    protected
      SI.Conductance gAC(start=1) "AC small-signal conductance";
      SI.Voltage thermalVolt "Thermal voltage";
      Real KhliDC;
      Real KgenDC;
      Real KhliDCs(start=1);
      Real KgenDCs(start=1);
      SI.Current IFDC;
      SI.Current IRDC;
      SI.Current IFDCs(start=1);
      SI.Current IRDCs(start=1);
      SI.Current IREVDC;
      Real KhliTran;
      Real KgenTran;
      SI.Current IFTran;
      SI.Current IRTran;
      SI.Current IREVTran;
      Real derKhli;
      Real derKgen;
      SI.Conductance derIF;
      SI.Conductance derIR;
      SI.Conductance derIREV;
    equation
      // Thermal voltage: kT/q
      thermalVolt = temp/11600;

      // ------------
      // Static Model
      // ------------

      KhliDC = if (IKF > IS and ctrl_DC) then sqrt(IKF/(IKF + IFDC)) else 1;

      KgenDC = if (ctrl_DC) then sqrt(((1 - vDC/VJ)^2 + 0.005)^M) else 1;

      IFDC = if (ctrl_DC) then IS*(exp(vDC/thermalVolt/N) - 1) else 0;

      IRDC = if (ctrl_DC) then ISR*(exp(vDC/thermalVolt/NR) - 1) else 0;

      IREVDC = if (ctrl_DC) then IBV*exp(-(BV + vDC)/thermalVolt) else 0;
      0 = if (ctrl_DC) then -iDC + KhliDC*IFDC + KgenDC*IRDC - IREVDC + vDC*
        GMIN*scaleGMIN else vDC;

      // ------------------
      // Large-signal Model
      // ------------------

      KhliTran = if (IKF > IS) then sqrt(IKF/(IKF + IFTran)) else 1;

      KgenTran = sqrt(((1 - vDiodeTran/VJ)^2 + 0.005)^M);

      IFTran = IS*(exp(vDiodeTran/thermalVolt/N) - 1);

      IRTran = ISR*(exp(vDiodeTran/thermalVolt/NR) - 1);

      IREVTran = IBV*exp(-(BV + vDiodeTran)/thermalVolt);

      iTran = KhliTran*IFTran + KgenTran*IRTran - IREVTran + vTran*GMIN;

      // ---------------------
      // AC Small Signal Model
      // ---------------------

      when ctrl_AC then

        derIF = IS/thermalVolt/N*exp(vDC/thermalVolt/N);

        derIR = ISR/thermalVolt/NR*exp(vDC/thermalVolt/NR);

        derIREV = -IBV/thermalVolt*exp(-(BV + vDC)/thermalVolt);

        IFDCs = IS*(exp(vDC/thermalVolt/N) - 1);

        IRDCs = ISR*(exp(vDC/thermalVolt/NR) - 1);

        derKhli = if (IKF > IS) then -0.5/sqrt(IKF/(IKF + IFDCs))*derIF*IKF/(
          IKF + IFDCs)^2 else 0;

        derKgen = -M/VJ*(1 - vDC/VJ)*((1 - vDC/VJ)^2 + 0.005)^(M/2 - 1);

        KhliDCs = if (IKF > IS) then sqrt(IKF/(IKF + IFDCs)) else 1;

        KgenDCs = sqrt(((1 - vDC/VJ)^2 + 0.005)^M);

        gAC = derKhli*IFDCs + derIF*KhliDCs + derKgen*IRDCs + KgenDCs*derIR +
          derIREV + GMIN;

      end when;

      {iAC_Re,iAC_Im} = gAC*{vAC_Re,vAC_Im};

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(
          Text(
            extent=[-100, -110; 100, -55],
            string="%name",
            style(color=0)),
          Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1)),
          Ellipse(extent=[-60, -60; 60, 60], style(thickness=1, color=3)),
          Line(points=[-50, 0; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, 20; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, -20; 50, 0], style(thickness=1, color=3)),
          Line(points=[-100, 0; -60, 0], style(thickness=1, color=3)),
          Line(points=[60, 0; 100, 0], style(thickness=1, color=3))));
    end I_DIODE;

    model C_DIODE
      extends src.BREAKOUT.Capacitor;
      extends INIT.Part;
      parameter Real CJ0 "Zero-bias junction capacitance [F]";
      parameter Real TT "Transit time [s]";
      parameter Real M "Grading coefficient";
      parameter Real FC
        "Coefficient for forward-bias depletion capacitance formula";
      parameter SI.Voltage VJ "Junction potencial";
      parameter SI.Current IS "Reverse saturation current at 300K";
      parameter SI.Voltage BV "Reverse breakdown voltage (positive number)";
      parameter Real N "Emission coefficient";
      parameter SI.Current IKF "High injection knee current";
      parameter SI.Current ISR "Recombination current";
      parameter Real NR "Emission coefficient for ISR";
      parameter SI.Current IBV "Reverse breakdown current (positive number)";

    protected
      parameter Real F2=(1 - FC)^(1 + M);
      parameter Real F3=1 - FC*(1 + M);
      SI.Conductance gAC(start=1);
      SI.Conductance gTran(start=1);
      SI.Voltage thermalVolt "Thermal voltage";
      Real KhliDC;
      Real KgenDC;
      SI.Current IFDC;
      SI.Current IRDC;
      Real KhliTran;
      Real KgenTran;
      SI.Current IFTran;
      SI.Current IRTran;
      Real derKhliDC;
      Real derKgenDC;
      Real derKhliTran;
      Real derKgenTran;
      SI.Conductance derIFDC;
      SI.Conductance derIRDC;
      SI.Conductance derIREVDC;
      SI.Conductance derIFTran;
      SI.Conductance derIRTran;
      SI.Conductance derIREVTran;
    equation
      // Thermal voltage: kT/q
      thermalVolt = temp/11600;

      // ------------------------
      // Large-signal capacitance
      // ------------------------

      Cvar*der(vTran) = iTran;

      derIFTran = IS/thermalVolt/N*exp(vTran/thermalVolt/N);

      derIRTran = ISR/thermalVolt/NR*exp(vTran/thermalVolt/NR);

      derIREVTran = -IBV/thermalVolt*exp(-(BV + vTran)/thermalVolt);

      IFTran = IS*(exp(vTran/thermalVolt/N) - 1);

      IRTran = ISR*(exp(vTran/thermalVolt/NR) - 1);

      derKhliTran = if (IKF > IS) then -0.5/sqrt(IKF/(IKF + IFTran))*derIFTran*
        IKF/(IKF + IFTran)^2 else 0;

      derKgenTran = -M/VJ*(1 - vTran/VJ)*((1 - vTran/VJ)^2 + 0.005)^(M/2 - 1);

      KhliTran = if (IKF > IS) then sqrt(IKF/(IKF + IFTran)) else 1;

      KgenTran = sqrt(((1 - vTran/VJ)^2 + 0.005)^M);

      gTran = derKhliTran*IFTran + derIFTran*KhliTran + derKgenTran*IRTran +
        KgenTran*derIRTran - derIREVTran + GMIN;

      Cvar = if noEvent(vTran < FC*VJ) then TT*gTran + CJ0*(1 - vTran/VJ)^(-M)
         else TT*gTran + CJ0/F2*(F3 + M*vTran/VJ);

      // ---------------------------
      // AC small-signal capacitance
      // ---------------------------

      when ctrl_AC then

        derIFDC = IS/thermalVolt/N*exp(vDC/thermalVolt/N);

        derIRDC = ISR/thermalVolt/NR*exp(vDC/thermalVolt/NR);

        derIREVDC = -IBV/thermalVolt*exp(-(BV + vDC)/thermalVolt);

        IFDC = IS*(exp(vDC/thermalVolt/N) - 1);

        IRDC = ISR*(exp(vDC/thermalVolt/NR) - 1);

        derKhliDC = if (IKF > IS) then -0.5/sqrt(IKF/(IKF + IFDC))*derIFDC*IKF/
          (IKF + IFDC)^2 else 0;

        derKgenDC = -M/VJ*(1 - vDC/VJ)*((1 - vDC/VJ)^2 + 0.005)^(M/2 - 1);

        KhliDC = if (IKF > IS) then sqrt(IKF/(IKF + IFDC)) else 1;

        KgenDC = sqrt(((1 - vDC/VJ)^2 + 0.005)^M);

        gAC = derKhliDC*IFDC + derIFDC*KhliDC + derKgenDC*IRDC + KgenDC*derIRDC
           + derIREVDC + GMIN;

        CvarAC = if (vDC < FC*VJ) then TT*gAC + CJ0*(1 - vDC/VJ)^(-M) else TT*
          gAC + CJ0/F2*(F3 + M*vDC/VJ);

      end when;
      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1))));
    end C_DIODE;
    annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=0,
              thickness=2)), Text(
          extent=[-80, 34; 80, -34],
          style(thickness=2),
          string="DIODE_PSPICE")));
  end DIODE_PSPICE;

  model PSPICE_diode
    extends INTERFACE.TwoPin;
    extends INIT.Part;
    parameter Boolean HIDDEN_COMPONENT=false "Enable or disable log";
    parameter SI.Current IS=1e-14 "Saturation current";
    parameter SI.Resistance RS=10 "Ohmic Resistance";
    parameter Real N=1 "Emission coefficient";
    parameter SI.Time TT=0 "Transit time";
    parameter SI.Capacitance CJ0=1e-6 "zero-bias junction capacitance";
    parameter SI.Voltage VJ=1 "Junction potential";
    parameter Real M=0.5 "grading coefficient";
    parameter Real FC=0.5
      "Coefficient for forward-bias depletion capacitance formula";
    parameter SI.Voltage BV=1e40 "reverse breakdown voltage (positive number)";
    parameter SI.Current IKF=-1 "High injection knee current";
    parameter SI.Current ISR=1e-14 "Recombination current";
    parameter Real NR=1 "Emission coefficient for ISR";
    parameter SI.Current IBV=1e-3 "Reverse breakdown current (positive number)";

    SI.Voltage vDC "DC voltage between pines";
    SI.Voltage vTran "Transient voltage between pines";
    SI.Voltage vAC_Re "Real part of AC small-signal voltage between pines";
    SI.Voltage vAC_Im "Imaginary part of AC small-signal voltage between pines";
    SI.Current iDC "DC current";
    SI.Current iTran "Transient/Small-signal current";
    SI.Current iAC_Re "Small-signal current. Real part";
    SI.Current iAC_Im "Small-signal current. Imaginary part";
    SI.Voltage vAC_mag(start=0)
      "Magnitude of AC small-signal voltage across the component";
    SI.Voltage vAC_mag_dB(start=0)
      "Magnitude (dB) of AC small-signal voltage across the component";
    nonSI.Angle_deg vAC_phase(start=0)
      "Phase (deg) of AC small-signal voltage across the component";

    SI.Current iAC_mag(start=0) "Magnitude of AC small-signal current";
    SI.Current iAC_mag_dB(start=0) "Magnitude (dB) of AC small-signal current";

    nonSI.Angle_deg iAC_phase(start=0) "Phase (deg) of AC small-signal current";
    SI.Voltage pinP_vAC_mag(start=0);
    SI.Voltage pinP_vAC_phase(start=0);
    SI.Voltage pinP_vAC_mag_dB(start=0);

    SI.Voltage pinN_vAC_mag(start=0);
    SI.Voltage pinN_vAC_phase(start=0);
    SI.Voltage pinN_vAC_mag_dB(start=0);
    DIODE_PSPICE.I_DIODE I_diode(
      IS=IS,
      BV=BV,
      N=N,
      IKF=IKF,
      ISR=ISR,
      NR=NR,
      IBV=IBV,
      M=M,
      VJ=VJ) annotation (extent=[-6, -50; 14, -30], rotation=0);
    DIODE_PSPICE.C_DIODE Cdiode(
      IS=IS,
      BV=BV,
      N=N,
      TT=TT,
      CJ0=CJ0,
      M=M,
      VJ=VJ,
      FC=FC,
      IKF=IKF,
      ISR=ISR,
      NR=NR,
      IBV=IBV) annotation (extent=[0, 34; 20, 54], rotation=0);
    Rbreak Rs(R=RS, HIDDEN_COMPONENT=true)
      annotation (extent=[-90, -8; -70, 12]);
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Line(points=[-100, 0; -75, 0], style(color=1, thickness=3)),
        Line(points=[-75, 0; -40, 0], style(thickness=1, color=3)),
        Line(points=[-40, -40; -40, 40; 40, 0; -40, -40], style(thickness=1,
              color=3)),
        Line(points=[40, -40; 40, 40], style(thickness=1, color=3)),
        Line(points=[40, 0; 75, 0], style(thickness=1, color=3)),
        Line(points=[75, 0; 100, 0], style(color=1, thickness=3))),
      Diagram);
  equation

    // For numerical efficiency
    Cdiode.vTran = I_diode.vDiodeTran;

    {iDC,iTran,iAC_Re,iAC_Im} = {p.iDC,p.iTran,p.iAC_Re,p.iAC_Im};
    {vDC,vTran,vAC_Re,vAC_Im} = {p.vDC,p.vTran,p.vAC_Re,p.vAC_Im} - {n.vDC,n.
      vTran,n.vAC_Re,n.vAC_Im};
    (pinP_vAC_mag,pinP_vAC_phase) = Rect2Polar({p.vAC_Re,p.vAC_Im});
    pinP_vAC_mag_dB = Decibels(pinP_vAC_mag);

    (pinN_vAC_mag,pinN_vAC_phase) = Rect2Polar({n.vAC_Re,n.vAC_Im});
    pinN_vAC_mag_dB = Decibels(pinN_vAC_mag);

    (vAC_mag,vAC_phase) = Rect2Polar({vAC_Re,vAC_Im});
    vAC_mag_dB = Decibels(vAC_mag);

    (iAC_mag,iAC_phase) = Rect2Polar({iAC_Re,iAC_Im});
    iAC_mag_dB = Decibels(iAC_mag);
    // ---------------------------
    // Log static analysis results
    // ---------------------------
    when ctrl_log_DC and ((HIDDEN_COMPONENT == false) or (LOG_RESULTS == 2 and
        HIDDEN_COMPONENT == true)) then
      LogVariable(p.vDC);
      LogVariable(n.vDC);
    end when;
    when ctrl_log_DC and ((HIDDEN_COMPONENT == false and LOG_RESULTS > 0) or (
        HIDDEN_COMPONENT == true and LOG_RESULTS == 2)) then
      LogVariable(vDC);
      LogVariable(iDC);
    end when;
    // ---------------------------
    // Log AC small-signal results
    // ---------------------------
    when ctrl_log_AC and (HIDDEN_COMPONENT == false or LOG_RESULTS == 2 and
        HIDDEN_COMPONENT == true) then
      LogVariable(pinP_vAC_mag);
      LogVariable(pinP_vAC_phase);
      LogVariable(pinP_vAC_mag_dB);
      LogVariable(pinN_vAC_mag);
      LogVariable(pinN_vAC_phase);
      LogVariable(pinN_vAC_mag_dB);
    end when;
    when ctrl_log_AC and (HIDDEN_COMPONENT == false and LOG_RESULTS > 0 or
        HIDDEN_COMPONENT == true and LOG_RESULTS == 2) then
      LogVariable(vAC_mag);
      LogVariable(vAC_mag_dB);
      LogVariable(vAC_phase);
      LogVariable(iAC_mag);
      LogVariable(iAC_mag_dB);
      LogVariable(iAC_phase);
    end when;
    connect(Cdiode.n, I_diode.n)
      annotation (points=[21, 44; 34, 44; 34, -40; 15, -40], style(color=1));
    connect(Rs.n, I_diode.p)
      annotation (points=[-69, 2; -42, 2; -42, -40; -7, -40], style(color=1));
    connect(Rs.p, p) annotation (points=[-91, 2; -100.5, 2; -100.5, 0; -110, 0],
         style(color=1));
    connect(I_diode.n, n)
      annotation (points=[15, -40; 34, -40; 34, 0; 110, 0], style(color=1));
    connect(Rs.n, Cdiode.p)
      annotation (points=[-69, 2; -42, 2; -42, 44; -1, 44], style(color=1));
  end PSPICE_diode;

  package SPICE2_MOS1
    // -----------------------------------------------------------
    // SPICE2 Level1 MOS
    // Reference:
    // Semiconductor Device Modeling with SPICE. 2nd Edition, 1993
    // G. Massobrio and P. Antognetti.
    // McGraw-Hill, Inc
    // -----------------------------------------------------------

    model Idiode
      extends INTERFACE.OnePort;
      extends INIT.Part;
      parameter SI.Current IS "Reverse saturation current at 300K";
      // Boolean forwardDC "Operation region";
      // Boolean forwardTran;
      SI.Voltage vDiodeTran "Voltage drop across the diode";
    protected
      SI.Conductance gAC(start=1) "AC small-signal conductance";
      SI.Voltage thermalVolt "Thermal voltage";
    equation
      // Thermal voltage: kT/q
      thermalVolt = temp/11600;

      iDC = IS*(exp(vDC/thermalVolt) - 1) + vDC*scaleGMIN*GMIN;

      // -------------
      // Dynamic model
      // -------------

      iTran = if noEvent(vDiodeTran > 0) then IS*(exp(vDiodeTran/thermalVolt)
         - 1) + vDiodeTran*GMIN else (IS/thermalVolt + GMIN)*vDiodeTran;

      // ------------------
      // Small-signal model
      // ------------------
      when ctrl_AC then
        gAC = if (vDC > 0) then IS/thermalVolt*exp(vDC/thermalVolt) + GMIN
           else IS/thermalVolt + GMIN;

      end when;

      {iAC_Re,iAC_Im} = gAC*{vAC_Re,vAC_Im};

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(
          Text(
            extent=[-100, -110; 100, -55],
            string="%name",
            style(color=0)),
          Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1)),
          Ellipse(extent=[-60, -60; 60, 60], style(thickness=1, color=3)),
          Line(points=[-50, 0; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, 20; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, -20; 50, 0], style(thickness=1, color=3)),
          Line(points=[-100, 0; -60, 0], style(thickness=1, color=3)),
          Line(points=[60, 0; 100, 0], style(thickness=1, color=3))));
    end Idiode;

    model Ids
      extends INTERFACE.OnePort;
      extends INIT.Part;

      outer SI.Voltage vthDC "Threshold voltage";
      outer SI.Voltage vgsDC "Gate to source voltage";
      outer SI.Voltage vbsDC "Bulk to source voltage";
      outer SI.Voltage vdsDC "Drain to source voltage";

      outer SI.Voltage vthTran "Threshold voltage";
      outer SI.Voltage vgsTran "Gate to source voltage";
      outer SI.Voltage vbsTran "Bulk to source voltage";
      outer SI.Voltage vdsTran "Drain to source voltage";
      outer SI.Voltage vdsTranSgn "Drain-pin to source-pin voltage";

      outer SI.Voltage gate_vAC_Re;
      outer SI.Voltage gate_vAC_Im;
      outer SI.Voltage bulk_vAC_Re;
      outer SI.Voltage bulk_vAC_Im;

      parameter SI.Voltage VTO "Zero-bias threshold voltage";
      parameter Real GAMMA "Body-effect parameter [V0.5]";
      parameter SI.Voltage PHI "Surface inversion potencial";
      parameter Real KP "Transconductance parameter [A/V2]";
      parameter SI.Length W "Gate width";
      parameter SI.Length L "Gate length";
      parameter SI.Length LD "Lateral diffusion";
      parameter Real LAMBDA "Channel-length modulation [V-1]";

    protected
      parameter Real beta=KP*W/(L - 2*LD);

      Boolean pinNisSourceAC(start=true);

      SI.Current idsDC "Drain to source current";

      SI.Current idsTran "Drain to source current";

      Real ARG(start=0);

      SI.Conductance gdsAC "dIds/dVds";
      SI.Conductance gmbsAC "dIds/dVbs";
      SI.Conductance gmAC "dIds/dVgs";

      SI.Voltage vdsAC_Re;
      SI.Voltage vdsAC_Im;
      SI.Voltage vgsAC_Re;
      SI.Voltage vgsAC_Im;
      SI.Voltage vbsAC_Re;
      SI.Voltage vbsAC_Im;

      SI.Current idsAC_Re;
      SI.Current idsAC_Im;
    equation

      // ------------
      // Static model
      // ------------

      iDC = noEvent(if vDC > 0 then idsDC else -idsDC);

      idsDC = if vgsDC <= vthDC then 0 else noEvent(if vdsDC < vgsDC - vthDC
         then beta*(vgsDC - vthDC - 0.5*vdsDC)*vdsDC*(1 + LAMBDA*vdsDC) else
        0.5*beta*(vgsDC - vthDC)^2*(1 + LAMBDA*vdsDC));

      // ------------------
      // Large-signal model
      // ------------------

      iTran = if noEvent(vdsTranSgn >= 0) then idsTran else -idsTran;

      idsTran = if vgsTran <= vthTran then 0 else if noEvent(vdsTran < vgsTran
         - vthTran) then beta*(vgsTran - vthTran - 0.5*vdsTran)*vdsTran*(1 +
        LAMBDA*vdsTran) else 0.5*beta*(vgsTran - vthTran)^2*(1 + LAMBDA*vdsTran);

      // ---------------------
      // AC small-signal model
      // ---------------------

      {vdsAC_Re,vdsAC_Im} = if pinNisSourceAC then {vAC_Re,vAC_Im} else -{
        vAC_Re,vAC_Im};
      {vgsAC_Re,vgsAC_Im} = if pinNisSourceAC then {gate_vAC_Re - n.vAC_Re,
        gate_vAC_Im - n.vAC_Im} else {gate_vAC_Re - p.vAC_Re,gate_vAC_Im - p.
        vAC_Im};
      {vbsAC_Re,vbsAC_Im} = if pinNisSourceAC then {bulk_vAC_Re - n.vAC_Re,
        bulk_vAC_Im - n.vAC_Im} else {bulk_vAC_Re - p.vAC_Re,bulk_vAC_Im - p.
        vAC_Im};
      {idsAC_Re,idsAC_Im} = gdsAC*{vdsAC_Re,vdsAC_Im} + gmbsAC*{vbsAC_Re,
        vbsAC_Im} + gmAC*{vgsAC_Re,vgsAC_Im};
      {iAC_Re,iAC_Im} = if pinNisSourceAC then {idsAC_Re,idsAC_Im} else -{
        idsAC_Re,idsAC_Im};

      when ctrl_AC then
        pinNisSourceAC = (vDC >= 0);

        gdsAC = if (vgsDC <= vthDC) then 0 else if (vdsDC < vgsDC - vthDC)
           then beta*(vgsDC - vthDC - vdsDC)*(1 + LAMBDA*vdsDC) + beta*(vgsDC
           - vthDC - 0.5*vdsDC)*LAMBDA*vdsDC else 0.5*beta*(vgsDC - vthDC)^2*
          LAMBDA;

        gmbsAC = gmAC*ARG;

        ARG = if vbsDC > 0 then 0.5*GAMMA/(sqrt(PHI) - 0.5*vbsDC/sqrt(PHI))
           else 0.5*GAMMA/sqrt(PHI - vbsDC);

        gmAC = if (vgsDC <= vthDC) then 0 else if (vdsDC < vgsDC - vthDC) then
          beta*vdsDC*(1 + LAMBDA*vdsDC) else beta*(vgsDC - vthDC)*(1 + LAMBDA*
          vdsDC);

      end when;

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(
          Text(
            extent=[-100, -110; 100, -55],
            string="%name",
            style(color=0)),
          Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1)),
          Ellipse(extent=[-60, -60; 60, 60], style(thickness=1, color=3)),
          Line(points=[-50, 0; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, 20; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, -20; 50, 0], style(thickness=1, color=3)),
          Line(points=[-100, 0; -60, 0], style(thickness=1, color=3)),
          Line(points=[60, 0; 100, 0], style(thickness=1, color=3))));
    end Ids;

    model Cdiode
      extends BREAKOUT.Capacitor;
      parameter Real CJ
        "Capacitance at zero-bias voltage per squere meter of area [F/m2]";
      parameter Real CJSW
        "Capacitance at zero-bias voltage per meter of perimeter [F/m]";
      parameter Real MJ "Bulk junction capacitnce grading coefficient";
      parameter Real MJSW "Perimeter capacitance grading coefficient";
      parameter Real FC "Substrate-junction forward-bias coefficient";
      parameter SI.Voltage PB "Junction potencial";
      parameter SI.Length P "Junction perimeter";
      parameter SI.Area A "Junction area";

    protected
      parameter Real F2=(1 - FC)^(1 + MJ);
      parameter Real F3=1 - FC*(1 + MJ);
      parameter Real FCtimesPB=FC*PB;
      parameter Real CJtimesA=CJ*A;
      parameter Real CJSWtimesP=CJSW*P;
      parameter Real coef1=F3*(CJtimesA/F2 + CJSW*P/F2);
      parameter Real coef2=(CJtimesA*MJ/F2 + CJSW*P*MJSW/F2)/PB;
      parameter Real invPB=1/PB;
    equation
      // ------------------------
      // Large-signal capacitance
      // ------------------------

      Cvar*der(vTran) = iTran;

      Cvar = if noEvent(vTran < FCtimesPB) then CJtimesA/(1 - invPB*vTran)^MJ
         + CJSWtimesP/(1 - invPB*vTran)^MJSW else coef1 + coef2*vTran;

      // ---------------------------
      // AC small-signal capacitance
      // ---------------------------
      when ctrl_AC then

        CvarAC = if (vDC < FCtimesPB) then CJtimesA/(1 - invPB*vDC)^MJ +
          CJSWtimesP/(1 - invPB*vDC)^MJSW else coef1 + coef2*vDC;

      end when;
      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1))));
    end Cdiode;

    model Cgb
      extends BREAKOUT.Capacitor;

      outer SI.Voltage vthDC "Threshold voltage";
      outer SI.Voltage vdsDC "Drain to source voltage";
      outer SI.Voltage vgsDC "Gate to source voltage";

      outer SI.Voltage vthTran "Threshold voltage";
      outer SI.Voltage vdsTran "Drain to source voltage";
      outer SI.Voltage vgsTran "Gate to source voltage";

      parameter SI.Voltage PHI "Surface inversion potencial";
      parameter SI.Length LD "Lateral diffusion";
      parameter SI.Length W "Gate width";
      parameter SI.Length L "Gate length";
      parameter SI.Length TOX "Gate oxide thickness";
      parameter Real EPSR "Dielectric constant of the oxide";
      parameter Real CGBO "Gate-bulk overlap capacitance per meter [F/m]";

    protected
      parameter SI.Length LEFF=L + 2*LD "Effective length";
      parameter SI.Capacitance COX=EPS0*EPSR*W*LEFF/TOX
        "Gate oxide capacitance";
      parameter Real CGBOtimesLEFF=CGBO*LEFF;
      parameter Real COXtimesinvPHI=COX/PHI;

      constant Real EPS0=8.85e-12 "Permittivity of free space [F/m]";
    equation
      // ------------------------
      // Large-signal capacitance
      // ------------------------

      Cvar*der(vTran) = iTran;

      Cvar - CGBOtimesLEFF = if noEvent(vgsTran < vthTran - PHI) then COX else
        if noEvent(vgsTran < vthTran) then COXtimesinvPHI*(vthTran - vgsTran)
         else 0;

      // ------------------------------------------------
      // AC small-signal capacitance and operation region
      // ------------------------------------------------
      when ctrl_AC then

        CvarAC = if (vgsDC < vthDC - PHI) then COX + CGBOtimesLEFF else if (
          vgsDC < vthDC) then COXtimesinvPHI*(vthDC - vgsDC) + CGBOtimesLEFF
           else CGBOtimesLEFF;

      end when;

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1))));
    end Cgb;

    model Cgd
      extends BREAKOUT.Capacitor;

      outer SI.Voltage vthDC "Threshold voltage";
      outer SI.Voltage vdsDC "Drain to source voltage";
      outer SI.Voltage vdsDCSgn "Drain-pin to source-pin voltage";
      outer SI.Voltage vgsDC "Gate to source voltage";

      outer SI.Voltage vthTran "Threshold voltage";
      outer SI.Voltage vdsTran "Drain to source voltage";
      outer SI.Voltage vdsTranSgn "Drain-pin to source-pin voltage";
      outer SI.Voltage vgsTran "Gate to source voltage";

      parameter SI.Voltage PHI "Surface inversion potencial";
      parameter SI.Length LD "Lateral diffusion";
      parameter SI.Length W "Gate width";
      parameter SI.Length L "Gate length";
      parameter SI.Length TOX "Gate oxide thickness";
      parameter Real EPSR "Dielectric constant of the oxide";
      parameter Real CGDO "Gate-drain overlap capacitance per meter [F/m]";
      parameter Real CGSO "Gate-source overlap capacitance per meter [F/m]";

      parameter Boolean gateSourcePinsC;

    protected
      parameter SI.Length LEFF=L + 2*LD "Effective length";
      parameter SI.Capacitance COX=EPS0*EPSR*W*LEFF/TOX
        "Gate oxide capacitance";
      constant Real EPS0=8.85e-12 "Permittivity of free space [F/m]";
      parameter Real CGSOtimesW=CGSO*W;
      parameter Real CGDOtimesW=CGDO*W;
      parameter Real twoThirdsCOX=2/3*COX;
      parameter Real threeFourthsCOX=3*COX/4;
      parameter Real halfCOX=0.5*COX;

      parameter SI.Voltage vdsTranEPS=1e-4;
      parameter SI.Voltage vdsDCEPS=1e-4;

      Real Cgs;
      Real Cgd;
      Real CgsAC;
      Real CgdAC;
      Real CpinsGS;
      Real CpinsGD;
      Real CpinsGSAC;
      Real CpinsGDAC;
    equation

      // ------------------------
      // Large-signal capacitance
      // ------------------------

      Cvar*der(vTran) = iTran;

      Cvar = if gateSourcePinsC then CpinsGS else CpinsGD;

      //Gate-pin to Source-pin capacity

      CpinsGS = if noEvent(vdsTranSgn < -vdsTranEPS) then Cgd else if noEvent(
        vdsTranSgn < vdsTranEPS) then 0.5*(Cgs - Cgd)*vdsTranSgn/vdsTranEPS +
        0.5*(Cgs + Cgd) else Cgs;

      // Gate-pin to Drain-pin capacity

      CpinsGD = if noEvent(vdsTranSgn < -vdsTranEPS) then Cgs else if noEvent(
        vdsTranSgn < vdsTranEPS) then 0.5*(Cgd - Cgs)*vdsTranSgn/vdsTranEPS +
        0.5*(Cgs + Cgd) else Cgd;

      Cgs - CGSOtimesW = if noEvent(vgsTran <= vthTran - PHI) then 0 else if
        noEvent(vgsTran <= vthTran) then twoThirdsCOX*((-vthTran + vgsTran)/PHI
         + 1) else if noEvent(vgsTran <= vthTran + vdsTran) then twoThirdsCOX
         else if noEvent(vdsTran <= 2*vdsTranEPS) then halfCOX else
        twoThirdsCOX*(1 - ((vgsTran - vdsTran - vthTran)/(2*(vgsTran - vthTran)
         - vdsTran))^2);

      Cgd - CGDOtimesW = if noEvent(vgsTran <= vthTran + vdsTran) then 0 else
        if noEvent(vdsTran <= 2*vdsTranEPS) then threeFourthsCOX else COX*(1 -
        ((vgsTran - vthTran)/(2*(vgsTran - vthTran) - vdsTran))^2);

      // ------------------------------------------------
      // AC small-signal capacitance and operation region
      // ------------------------------------------------
      when ctrl_AC then

        CvarAC = if gateSourcePinsC then CpinsGSAC else CpinsGDAC;

        // Gate-pin to Source-pin capacity

        CpinsGSAC = if noEvent(vdsDCSgn < -vdsDCEPS) then CgdAC else if noEvent(
          vdsDCSgn < vdsDCEPS) then 0.5*(CgsAC - CgdAC)*vdsDCSgn/vdsDCEPS + 0.5
          *(CgsAC + CgdAC) else CgsAC;

        // Gate-pin to Drain-pin capacity

        CpinsGDAC = if noEvent(vdsDCSgn < -vdsDCEPS) then CgsAC else if noEvent(
          vdsDCSgn < vdsDCEPS) then 0.5*(CgdAC - CgsAC)*vdsDCSgn/vdsDCEPS + 0.5
          *(CgsAC + CgdAC) else CgdAC;

        // ********

        CgsAC = if (vgsDC <= vthDC - PHI) then CGSOtimesW else if (vgsDC <=
          vthDC) then twoThirdsCOX*((-vthDC + vgsDC)/PHI + 1) + CGSOtimesW
           else if (vgsDC <= vthDC + vdsDC) then twoThirdsCOX + CGSOtimesW
           else if (vdsDC <= 2*vdsDCEPS) then halfCOX + CGSOtimesW else
          twoThirdsCOX*(1 - ((vgsDC - vdsDC - vthDC)/(2*(vgsDC - vthDC) - vdsDC))
          ^2) + CGSOtimesW;

        CgdAC = if (vgsDC <= vthDC + vdsDC) then CGDOtimesW else if (vdsDC <= 2
          *vdsDCEPS) then threeFourthsCOX + CGDOtimesW else COX*(1 - ((vgsDC -
          vthDC)/(2*(vgsDC - vthDC) - vdsDC))^2) + CGDOtimesW;

      end when;

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1))));
    end Cgd;

  end SPICE2_MOS1;

  model Spice2MOS1
    extends INTERFACE.MOSFET;
    extends INIT.Part;
    inner SI.Voltage vdsDC "Drain to source voltage";
    inner SI.Voltage vgsDC "Gate to source voltage";
    inner SI.Voltage vbsDC "Bulk to source voltage";

    inner SI.Voltage vdsTran "Drain to source voltage";
    inner SI.Voltage vgsTran "Gate to source voltage";
    inner SI.Voltage vbsTran "Bulk to source voltage";

    SI.Voltage drain_vAC_mag "Magnitude of AC small-signal drain voltage";
    SI.Voltage drain_vAC_mag_dB
      "Magnitude (dB) of AC small-signal drain voltage";
    nonSI.Angle_deg drain_vAC_phase(start=0)
      "Phase (deg) of AC small-signal drain voltage";

    SI.Voltage source_vAC_mag "Magnitude of AC small-signal source voltage";
    SI.Voltage source_vAC_mag_dB
      "Magnitude (dB) of AC small-signal source voltage";
    nonSI.Angle_deg source_vAC_phase(start=0)
      "Phase (deg) of drain AC small-signal source voltage";

    SI.Voltage bulk_vAC_mag "Magnitude of AC small-signal bulk voltage";
    SI.Voltage bulk_vAC_mag_dB "Magnitude (dB) of AC small-signal bulk voltage";
    nonSI.Angle_deg bulk_vAC_phase(start=0)
      "Phase (deg) of AC small-signal bulk voltage";

    SI.Voltage gate_vAC_mag "Magnitude of AC small-signal gate voltage";
    SI.Voltage gate_vAC_mag_dB "Magnitude (dB) of AC small-signal gate voltage";
    nonSI.Angle_deg gate_vAC_phase(start=0)
      "Phase (deg) of AC small-signal gate voltage";

    SI.Current drain_iAC_mag "Magnitude of AC small-signal drain current";
    SI.Current drain_iAC_mag_dB
      "Magnitude (dB) of AC small-signal drain current";
    nonSI.Angle_deg drain_iAC_phase(start=0)
      "Phase (deg) of AC small-signal drain current";

    SI.Current source_iAC_mag "Magnitude of AC small-signal source current";
    SI.Current source_iAC_mag_dB
      "Magnitude (dB) of AC small-signal source current";
    nonSI.Angle_deg source_iAC_phase(start=0)
      "Phase (deg) of drain AC small-signal source current";

    SI.Current bulk_iAC_mag "Magnitude of AC small-signal bulk current";
    SI.Current bulk_iAC_mag_dB "Magnitude (dB) of AC small-signal bulk current";
    nonSI.Angle_deg bulk_iAC_phase(start=0)
      "Phase (deg) of AC small-signal bulk current";

    SI.Current gate_iAC_mag "Magnitude of AC small-signal gate current";
    SI.Current gate_iAC_mag_dB "Magnitude (dB) of AC small-signal gate current";
    nonSI.Angle_deg gate_iAC_phase(start=0)
      "Phase (deg) of AC small-signal gate current";

    parameter Boolean HIDDEN_COMPONENT=false "Enable or disable log";

    parameter SI.Area AD=1e-8 "drain difussion area";
    parameter SI.Area AS=1e-8 "Source difussion area";
    parameter Real CGBO=2e-10 "Gate-bulk overlap capacitance per meter [F/m]";
    parameter Real CGDO=4e-11 "Gate-drain overlap capacitance per meter [F/m]";
    parameter Real CGSO=4e-11 "Gate-source overlap capacitance per meter [F/m]";
    parameter Real CJ=2e-4
      "Capacitance at zero-bias voltage per square meter of area [F/m2]";
    parameter Real CJSW=1e-9
      "Capacitance at zero-bias voltage per meter of perimeter [F/m]";
    parameter Real FC=0.5 "Substrate-junction forward-bias coefficient";
    parameter Real GAMMA=0.526 "Body-effect parameter [V0.5]";
    parameter SI.Current IS=1e-14 "Reverse saturation current at 300K";
    parameter Real KP=27.6e-6 "Transconductance parameter [A/V2]";
    parameter SI.Length L=100e-6 "Gate length";
    parameter Real LAMBDA=0.00 "Channel-length modulation [V-1]";
    parameter SI.Length LD=0.8e-6 "Lateral diffusion";
    parameter Real MJ=0.5 "Bulk junction capacitnce grading coefficient";
    parameter Real MJSW=0.33 "Perimeter capacitance grading coefficient";
    parameter SI.Length PD=4e-4 "drain difussion perimeter";
    parameter SI.Length PS=4e-4 "source difussion perimeter";
    parameter SI.Voltage PB=0.75 "Junction potencial";
    parameter SI.Voltage PHI=0.65 "Surface inversion potencial";
    parameter SI.Resistance RD=10 "Drain ohmic resistance";
    parameter SI.Resistance RS=10 "Source ohmic resistance";
    parameter SI.Resistance RB=10 "Bulk ohmic resistance";
    parameter SI.Resistance RG=10 "Gate ohmic resistance";
    parameter SI.Length TOX=1e-7 "Gate oxide thickness";
    parameter SI.Voltage VTO=1 "Zero-bias threshold voltage";
    parameter SI.Length W=100e-6 "Gate width";

    constant Real EPSR=3.9 "Dielectric constant of the oxide";

    parameter SI.Resistance RSB=1e-4 "Source-Bulk junction resistance";
    parameter SI.Resistance RDB=1e-4 "Drain-Bulk junction resistance";

  protected
    inner SI.Voltage vdsDCSgn "Drain-pin to source-pin voltage";
    inner SI.Voltage vthDC "Threshold voltage";

    inner SI.Voltage vdsTranSgn "Drain-pin to source-pin voltage";
    inner SI.Voltage vthTran "Threshold voltage";

    inner SI.Voltage gate_vAC_Re;
    inner SI.Voltage gate_vAC_Im;
    inner SI.Voltage bulk_vAC_Re;
    inner SI.Voltage bulk_vAC_Im;

    // --------------------
    // Drain-Source current
    // --------------------
    SPICE2_MOS1.Ids Ids(
      VTO=VTO,
      GAMMA=GAMMA,
      PHI=PHI,
      KP=KP,
      W=W,
      L=L,
      LD=LD,
      LAMBDA=LAMBDA) annotation (extent=[-10, 0; 10, 20], rotation=-90);
    // --------------------
    // Source-Bulk junction
    // --------------------

    SPICE2_MOS1.Idiode Dbs(IS=IS)
      annotation (extent=[40, -25; 60, -5], rotation=180);

    SPICE2_MOS1.Cdiode Cbs(
      CJ=CJ,
      CJSW=CJSW,
      MJ=MJ,
      MJSW=MJSW,
      FC=FC,
      PB=PB,
      P=PS,
      A=AS) annotation (extent=[40, -50; 60, -30], rotation=180);

    // -------------------
    // Drain-Bulk junction
    // -------------------

    SPICE2_MOS1.Idiode Dbd(IS=IS)
      annotation (extent=[40, 25; 60, 45], rotation=180);

    SPICE2_MOS1.Cdiode Cbd(
      CJ=CJ,
      CJSW=CJSW,
      MJ=MJ,
      MJSW=MJSW,
      FC=FC,
      PB=PB,
      P=PD,
      A=AD) annotation (extent=[40, 50; 60, 70], rotation=180);

    // ----------------
    // Gate capacitance
    // ----------------
    SPICE2_MOS1.Cgd Cgd(
      PHI=PHI,
      LD=LD,
      W=W,
      L=L,
      TOX=TOX,
      EPSR=EPSR,
      CGDO=CGDO,
      CGSO=CGSO,
      gateSourcePinsC=false) annotation (extent=[-60, 25; -40, 45], rotation=0);

    SPICE2_MOS1.Cgd Cgs(
      PHI=PHI,
      LD=LD,
      W=W,
      L=L,
      TOX=TOX,
      EPSR=EPSR,
      CGDO=CGDO,
      CGSO=CGSO,
      gateSourcePinsC=true) annotation (extent=[-60, -25; -40, -5], rotation=0);

    SPICE2_MOS1.Cgb Cgb(
      PHI=PHI,
      LD=LD,
      W=W,
      L=L,
      TOX=TOX,
      EPSR=EPSR,
      CGBO=CGBO) annotation (extent=[-60, -65; -40, -45], rotation=0);
    // ---------------
    // Drain resistors
    // ---------------
    Rbreak Rs(R=RS, HIDDEN_COMPONENT=true)
      annotation (extent=[-10, -90; 10, -70], rotation=-90);
    Rbreak Rd(R=RD, HIDDEN_COMPONENT=true)
      annotation (extent=[-10, 70; 10, 90], rotation=-90);

    // -------------
    // Gate resistor
    // -------------
    Rbreak Rg(R=RG, HIDDEN_COMPONENT=true)
      annotation (extent=[-120, -10; -100, 10]);

    // -------------
    // Bulk resistor
    // -------------
    Rbreak Rb(R=RB, HIDDEN_COMPONENT=true)
      annotation (extent=[98, -10; 118, 10], rotation=180);
    Rbreak Rsb(HIDDEN_COMPONENT=true, R=RSB)
      annotation (extent=[8, -50; 28, -30], rotation=180);
    Rbreak Rdb(HIDDEN_COMPONENT=true, R=RDB)
      annotation (extent=[10, 50; 30, 70], rotation=180);
  equation

    // ----------------------------------
    // Source-bulk junction: to avoid SSE
    // ----------------------------------

    Dbs.vDiodeTran = Cbs.vTran;

    // ---------------------------------
    // Drain-bulk junction: to avoid SSE
    // ---------------------------------

    Dbd.vDiodeTran = Cbd.vTran;

    // -----------------
    // Threshold voltage
    // -----------------
    vthDC = VTO + GAMMA*(sqrt(abs(PHI - vbsDC)) - sqrt(PHI));
    vthTran = VTO + GAMMA*(sqrt(abs(PHI - vbsTran)) - sqrt(PHI));

    // ---
    // Vds
    // ---

    vdsDC = noEvent(abs(Ids.vDC));
    vdsDCSgn = Ids.vDC;

    vdsTran = noEvent(abs(Cgs.vTran - Cgd.vTran));
    vdsTranSgn = Cgs.vTran - Cgd.vTran;

    // ---
    // Vgs
    // ---

    vgsDC = max({Cgs.vDC,Cgd.vDC});
    vgsTran = max({Cgs.vTran,Cgd.vTran});

    // ---
    // Vbs
    // ---

    vbsDC = max({Cbs.vDC,Cbd.vDC});
    vbsTran = max({Cbs.vTran,Cbd.vTran});

    // ------------------------------------
    // Gate & bulk AC small-signal voltages
    // ------------------------------------
    gate_vAC_Re = g.vAC_Re;
    gate_vAC_Im = g.vAC_Im;
    bulk_vAC_Re = b.vAC_Re;
    bulk_vAC_Im = b.vAC_Im;

    (drain_vAC_mag,drain_vAC_phase) = Rect2Polar({d.vAC_Re,d.vAC_Im});
    drain_vAC_mag_dB = Decibels(drain_vAC_mag);

    (drain_iAC_mag,drain_iAC_phase) = Rect2Polar({d.iAC_Re,d.iAC_Im});
    drain_iAC_mag_dB = Decibels(drain_iAC_mag);

    (source_vAC_mag,source_vAC_phase) = Rect2Polar({s.vAC_Re,s.vAC_Im});
    source_vAC_mag_dB = Decibels(source_vAC_mag);

    (source_iAC_mag,source_iAC_phase) = Rect2Polar({s.iAC_Re,s.iAC_Im});
    source_iAC_mag_dB = Decibels(source_iAC_mag);

    (bulk_vAC_mag,bulk_vAC_phase) = Rect2Polar({b.vAC_Re,b.vAC_Im});
    bulk_vAC_mag_dB = Decibels(bulk_vAC_mag);

    (bulk_iAC_mag,bulk_iAC_phase) = Rect2Polar({b.iAC_Re,b.iAC_Im});
    bulk_iAC_mag_dB = Decibels(bulk_iAC_mag);

    (gate_vAC_mag,gate_vAC_phase) = Rect2Polar({g.vAC_Re,g.vAC_Im});
    gate_vAC_mag_dB = Decibels(gate_vAC_mag);

    (gate_iAC_mag,gate_iAC_phase) = Rect2Polar({g.iAC_Re,g.iAC_Im});
    gate_iAC_mag_dB = Decibels(gate_iAC_mag);

    when ctrl_log_DC and ((HIDDEN_COMPONENT == false) or (LOG_RESULTS == 2 and
        HIDDEN_COMPONENT == true)) then
      LogVariable(g.vDC);
      LogVariable(d.vDC);
      LogVariable(s.vDC);
      LogVariable(b.vDC);
    end when;
    when ctrl_log_DC and ((HIDDEN_COMPONENT == false and LOG_RESULTS > 0) or (
        HIDDEN_COMPONENT == true and LOG_RESULTS == 2)) then
      LogVariable(vdsDC);
      LogVariable(vbsDC);
      LogVariable(vgsDC);
    end when;

    // ---------------------
    // Component connections
    // ---------------------
    connect(d, Rd.p) annotation (points=[0, 110; 0, 100.5; 0, 91; -6.73533e-016,
           91], style(color=1));
    connect(Rd.n, Ids.p) annotation (points=[6.73533e-016, 69; 6.73533e-016, 57;
           -4.94602e-022, 57; -4.94602e-022, 45; -6.73533e-016, 45;
          -6.73533e-016, 21], style(color=1));
    connect(Ids.n, Rs.p) annotation (points=[6.73533e-016, -1; -6.73533e-016,
          -69], style(color=1));
    connect(Rs.n, s)
      annotation (points=[6.73533e-016, -91; 0, -110], style(color=1));

    connect(Rg.n, Cgd.p)
      annotation (points=[-99, 0; -80, 0; -80, 35; -61, 35], style(color=1));
    connect(Rg.n, Cgs.p)
      annotation (points=[-99, 0; -80, 0; -80, -15; -61, -15], style(color=1));
    connect(Rg.n, Cgb.p)
      annotation (points=[-99, 0; -80, 0; -80, -55; -61, -55], style(color=1));

    connect(Rg.p, g) annotation (style(color=1));

    connect(Rb.n, Dbs.p) annotation (points=[97, 1.34707e-015; 80, 0; 80, -15;
          61, -15], style(color=1));
    connect(Rb.n, Cbs.p) annotation (points=[97, 1.34707e-015; 80, 0; 80, -40;
          61, -40], style(color=1));
    connect(Rb.n, Dbd.p) annotation (points=[97, 1.34707e-015; 80, 0; 80, 35;
          61, 35], style(color=1));
    connect(Rb.n, Cbd.p) annotation (points=[97, 1.34707e-015; 80, 0; 80, 60;
          61, 60], style(color=1));
    connect(Rb.n, Cgb.n) annotation (points=[97, 1.34707e-015; 80, 0; 80, -55;
          -39, -55], style(color=1));

    connect(b, Rb.p) annotation (style(color=1));

    connect(Ids.n, Cgs.n) annotation (points=[6.73533e-016, -1; 6.73533e-016,
          -15; -39, -15], style(color=1));

    // connect(Ids.n, Rbs.n);

    connect(Ids.p, Cgd.n) annotation (points=[-6.73533e-016, 21; -6.73533e-016,
           35; -39, 35], style(color=1));

    // connect(Ids.p, Rbd.n);
    connect(Rsb.p, Cbs.n)
      annotation (points=[29, -40; 39, -40], style(color=1));
    connect(Rsb.n, Ids.n) annotation (points=[7, -40; 6.73533e-016, -40;
          6.73533e-016, -1], style(color=1));

    connect(Rdb.p, Cbd.n) annotation (points=[31, 60; 39, 60], style(color=1));
    connect(Rdb.n, Rd.n) annotation (points=[9, 60; 6.73533e-016, 60;
          6.73533e-016, 69], style(color=1));

    connect(Cbd.n, Dbd.n) annotation (points=[39, 60; 39, 53.5; 38, 53.5; 38,
          47; 39, 47; 39, 35], style(color=1));

    connect(Dbs.n, Cbs.n) annotation (points=[39, -15; 39, -21.25; 40, -21.25;
          40, -27.5; 39, -27.5; 39, -40], style(color=1));

    annotation (
      Coordsys(extent=[-130, -100; 130, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[0, -100; 100, 0],
          string="%name",
          style(color=0)),
        Text(
          extent=[-160, 100; 160, 140],
          string="%=W",
          style(color=0)),
        Text(
          extent=[-160, 60; 160, 100],
          string="%=L",
          style(color=0)),
        Line(points=[-80, 0; -60, 0], style(thickness=1, color=3)),
        Line(points=[0, 80; 0, 50], style(thickness=1, color=3)),
        Line(points=[0, -80; 0, -50], style(thickness=1, color=3)),
        Line(points=[-40, 0; 80, 0], style(thickness=1, color=3)),
        Line(points=[-40, 50; 0, 50], style(thickness=1, color=3)),
        Line(points=[-40, 70; -40, -70], style(thickness=1, color=3)),
        Line(points=[-60, 40; -60, -40], style(thickness=1, color=3)),
        Line(points=[-100, 0; -80, 0], style(thickness=1, color=3)),
        Line(points=[0, 100; 0, 80], style(thickness=1, color=3)),
        Line(points=[0, -100; 0, -80], style(thickness=1, color=3)),
        Line(points=[80, 0; 100, 0], style(thickness=1, color=3)),
        Line(points=[-40, -50; 0, -50]),
        Polygon(points=[-20, -42; -20, -58; 0, -50; -20, -42], style(
              fillPattern=1))),
      Diagram(
        Text(
          extent=[-145, -5; -135, 5],
          string="G",
          style(color=0)),
        Text(
          extent=[-5, 105; 5, 115],
          string="D",
          style(color=0)),
        Text(
          extent=[-5, -115; 5, -105],
          string="S",
          style(color=0)),
        Text(
          extent=[135, -5; 145, 5],
          string="B",
          style(color=0))));

  end Spice2MOS1;

  package SPICE2_MOS1P
    // -----------------------------------------------------------
    // SPICE2 Level1 MOS
    // Reference:
    // Semiconductor Device Modeling with SPICE. 2nd Edition, 1993
    // G. Massobrio and P. Antognetti.
    // McGraw-Hill, Inc
    // -----------------------------------------------------------

    model Idiode
      extends INTERFACE.OnePort;
      extends INIT.Part;
      parameter SI.Current IS "Reverse saturation current at 300K";
      // Boolean forwardDC "Operation region";
      // Boolean forwardTran;
      SI.Voltage vDiodeTran "Voltage drop across the diode";
    protected
      SI.Conductance gAC(start=1) "AC small-signal conductance";
      SI.Voltage thermalVolt "Thermal voltage";
    equation
      // Thermal voltage: kT/q
      thermalVolt = temp/11600;
      // ------------
      // Static model
      // ------------

      iDC = IS*(exp(vDC/thermalVolt) - 1) + vDC*scaleGMIN*GMIN;

      // -------------
      // Dynamic model
      // -------------

      iTran = if noEvent(vDiodeTran > 0) then IS*(exp(vDiodeTran/thermalVolt)
         - 1) + vDiodeTran*GMIN else (IS/thermalVolt + GMIN)*vDiodeTran;

      // ------------------
      // Small-signal model
      // ------------------
      when ctrl_AC then
        gAC = if (vDC > 0) then IS/thermalVolt*exp(vDC/thermalVolt) + GMIN
           else IS/thermalVolt + GMIN;

      end when;

      {iAC_Re,iAC_Im} = gAC*{vAC_Re,vAC_Im};

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(
          Text(
            extent=[-100, -110; 100, -55],
            string="%name",
            style(color=0)),
          Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1)),
          Ellipse(extent=[-60, -60; 60, 60], style(thickness=1, color=3)),
          Line(points=[-50, 0; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, 20; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, -20; 50, 0], style(thickness=1, color=3)),
          Line(points=[-100, 0; -60, 0], style(thickness=1, color=3)),
          Line(points=[60, 0; 100, 0], style(thickness=1, color=3))));
    end Idiode;

    model Isd
      extends INTERFACE.OnePort;
      extends INIT.Part;

      outer SI.Voltage vthDC "Threshold voltage";
      outer SI.Voltage vsgDC "Source to gate voltage";
      outer SI.Voltage vsbDC "Source to bulk voltage";
      outer SI.Voltage vsdDC "Source to drain voltage";

      outer SI.Voltage vthTran "Threshold voltage";
      outer SI.Voltage vsgTran "Source to gate voltage";
      outer SI.Voltage vsbTran "Source to bulk voltage";
      outer SI.Voltage vsdTran "Source to drain voltage";
      outer SI.Voltage vsdTranSgn "Source-pin to drain-pin voltage";

      outer SI.Voltage gate_vAC_Re;
      outer SI.Voltage gate_vAC_Im;
      outer SI.Voltage bulk_vAC_Re;
      outer SI.Voltage bulk_vAC_Im;

      parameter SI.Voltage VTO "Zero-bias threshold voltage";
      parameter Real GAMMA "Body-effect parameter [V0.5]";
      parameter SI.Voltage PHI "Surface inversion potencial";
      parameter Real KP "Transconductance parameter [A/V2]";
      parameter SI.Length W "Gate width";
      parameter SI.Length L "Gate length";
      parameter SI.Length LD "Lateral diffusion";
      parameter Real LAMBDA "Channel-length modulation [V-1]";

    protected
      parameter Real beta=KP*W/(L - 2*LD);

      Boolean pinPisSourceAC(start=true);

      SI.Current isdDC "Source to drain current";

      SI.Current isdTran "Source to drain current";

      Real ARG(start=0);

      SI.Conductance gsdAC "dIsd/dVsd";
      SI.Conductance gmbsAC "dIsb/dVsb";
      SI.Conductance gmAC "dIsd/dVsg";

      SI.Voltage vsdAC_Re;
      SI.Voltage vsdAC_Im;
      SI.Voltage vsgAC_Re;
      SI.Voltage vsgAC_Im;
      SI.Voltage vsbAC_Re;
      SI.Voltage vsbAC_Im;

      SI.Current isdAC_Re;
      SI.Current isdAC_Im;
    equation

      // ------------
      // Static model
      // ------------
      iDC = noEvent(if vDC > 0 then isdDC else -isdDC);

      isdDC = if vsgDC <= -vthDC then 0 else noEvent(if vsdDC < vsgDC + vthDC
         then beta*(vsgDC + vthDC - 0.5*vsdDC)*vsdDC*(1 + LAMBDA*vsdDC) else
        0.5*beta*(vsgDC + vthDC)^2*(1 + LAMBDA*vsdDC));

      // ------------------
      // Large-signal model
      // ------------------

      iTran = if noEvent(vsdTranSgn >= 0) then isdTran else -isdTran;

      isdTran = if vsgTran <= -vthTran then 0 else if noEvent(vsdTran < vsgTran
         + vthTran) then beta*(vsgTran + vthTran - 0.5*vsdTran)*vsdTran*(1 +
        LAMBDA*vsdTran) else 0.5*beta*(vsgTran + vthTran)^2*(1 + LAMBDA*vsdTran);

      // ---------------------
      // AC small-signal model
      // ---------------------

      {vsdAC_Re,vsdAC_Im} = if pinPisSourceAC then {vAC_Re,vAC_Im} else -{
        vAC_Re,vAC_Im};
      {vsgAC_Re,vsgAC_Im} = if pinPisSourceAC then -{gate_vAC_Re - p.vAC_Re,
        gate_vAC_Im - p.vAC_Im} else -{gate_vAC_Re - n.vAC_Re,gate_vAC_Im - n.
        vAC_Im};
      {vsbAC_Re,vsbAC_Im} = if pinPisSourceAC then -{bulk_vAC_Re - p.vAC_Re,
        bulk_vAC_Im - p.vAC_Im} else -{bulk_vAC_Re - n.vAC_Re,bulk_vAC_Im - n.
        vAC_Im};
      {isdAC_Re,isdAC_Im} = gsdAC*{vsdAC_Re,vsdAC_Im} + gmbsAC*{vsbAC_Re,
        vsbAC_Im} + gmAC*{vsgAC_Re,vsgAC_Im};
      {iAC_Re,iAC_Im} = if pinPisSourceAC then {isdAC_Re,isdAC_Im} else -{
        isdAC_Re,isdAC_Im};

      when ctrl_AC then
        pinPisSourceAC = (vDC >= 0);

        gsdAC = if (vsgDC <= -vthDC) then 0 else if (vsdDC < vsgDC + vthDC)
           then beta*(vsgDC + vthDC - vsdDC)*(1 + LAMBDA*vsdDC) + beta*(vsgDC
           + vthDC - 0.5*vsdDC)*LAMBDA*vsdDC else 0.5*beta*(vsgDC + vthDC)^2*
          LAMBDA;
        gmbsAC = gmAC*ARG;
        ARG = if vsbDC > 0 then 0.5*GAMMA/(sqrt(PHI) - 0.5*vsbDC/sqrt(PHI))
           else 0.5*GAMMA/sqrt(PHI - vsbDC);

        gmAC = if (vsgDC <= -vthDC) then 0 else if (vsdDC < vsgDC + vthDC)
           then beta*vsdDC*(1 + LAMBDA*vsdDC) else beta*(vsgDC + vthDC)*(1 +
          LAMBDA*vsdDC);

      end when;

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(
          Text(
            extent=[-100, -110; 100, -55],
            string="%name",
            style(color=0)),
          Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1)),
          Ellipse(extent=[-60, -60; 60, 60], style(thickness=1, color=3)),
          Line(points=[-50, 0; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, 20; 50, 0], style(thickness=1, color=3)),
          Line(points=[20, -20; 50, 0], style(thickness=1, color=3)),
          Line(points=[-100, 0; -60, 0], style(thickness=1, color=3)),
          Line(points=[60, 0; 100, 0], style(thickness=1, color=3))));
    end Isd;

    model Cdiode
      extends BREAKOUT.Capacitor;
      parameter Real CJ
        "Capacitance at zero-bias voltage per squere meter of area [F/m2]";
      parameter Real CJSW
        "Capacitance at zero-bias voltage per meter of perimeter [F/m]";
      parameter Real MJ "Bulk junction capacitnce grading coefficient";
      parameter Real MJSW "Perimeter capacitance grading coefficient";
      parameter Real FC "Substrate-junction forward-bias coefficient";
      parameter SI.Voltage PB "Junction potencial";
      parameter SI.Length P "Junction perimeter";
      parameter SI.Area A "Junction area";

      // Real der_vTran "Voltage derivative [V/s]";

    protected
      parameter Real F2=(1 - FC)^(1 + MJ);
      parameter Real F3=1 - FC*(1 + MJ);
      parameter Real FCtimesPB=FC*PB;
      parameter Real CJtimesA=CJ*A;
      parameter Real CJSWtimesP=CJSW*P;
      parameter Real coef1=F3*(CJtimesA/F2 + CJSW*P/F2);
      parameter Real coef2=(CJtimesA*MJ/F2 + CJSW*P*MJSW/F2)/PB;
      parameter Real invPB=1/PB;
    equation
      // ------------------------
      // Large-signal capacitance
      // ------------------------

      Cvar*der(vTran) = iTran;

      Cvar = if noEvent(vTran < FCtimesPB) then CJtimesA/(1 - invPB*vTran)^MJ
         + CJSWtimesP/(1 - invPB*vTran)^MJSW else coef1 + coef2*vTran;

      // ---------------------------
      // AC small-signal capacitance
      // ---------------------------
      when ctrl_AC then

        CvarAC = if (vDC < FCtimesPB) then CJtimesA/(1 - invPB*vDC)^MJ +
          CJSWtimesP/(1 - invPB*vDC)^MJSW else coef1 + coef2*vDC;

      end when;
      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1))));
    end Cdiode;

    model Cbg
      extends BREAKOUT.Capacitor;

      outer SI.Voltage vthDC "Threshold voltage";
      outer SI.Voltage vsdDC "Drain to source voltage";
      outer SI.Voltage vsgDC "Gate to source voltage";
      outer SI.Voltage vthTran "Threshold voltage";
      outer SI.Voltage vsdTran "Drain to source voltage";
      outer SI.Voltage vsgTran "Gate to source voltage";

      parameter SI.Voltage PHI "Surface inversion potencial";
      parameter SI.Length LD "Lateral diffusion";
      parameter SI.Length W "Gate width";
      parameter SI.Length L "Gate length";
      parameter SI.Length TOX "Gate oxide thickness";
      parameter Real EPSR "Dielectric constant of the oxide";
      parameter Real CGBO "Gate-bulk overlap capacitance per meter [F/m]";

    protected
      parameter SI.Length LEFF=L + 2*LD "Effective length";
      parameter SI.Capacitance COX=EPS0*EPSR*W*LEFF/TOX
        "Gate oxide capacitance";
      parameter Real CGBOtimesLEFF=CGBO*LEFF;
      parameter Real COXtimesinvPHI=COX/PHI;
      constant Real EPS0=8.85e-12 "Permittivity of free space [F/m]";
    equation

      // ------------------------
      // Large-signal capacitance
      // ------------------------

      Cvar*der(vTran) = iTran;
      Cvar - CGBOtimesLEFF = if noEvent(vsgTran < -vthTran - PHI) then COX
         else if noEvent(vsgTran < -vthTran) then COXtimesinvPHI*(-vthTran -
        vsgTran) else 0;

      // ------------------------------------------------
      // AC small-signal capacitance and operation region
      // ------------------------------------------------
      when ctrl_AC then

        CvarAC = if (vsgDC < -vthDC - PHI) then COX + CGBOtimesLEFF else if (
          vsgDC < -vthDC) then COXtimesinvPHI*(-vthDC - vsgDC) + CGBOtimesLEFF
           else CGBOtimesLEFF;

      end when;

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1))));
    end Cbg;

    model Cdg
      extends BREAKOUT.Capacitor;

      outer SI.Voltage vthDC "Threshold voltage";
      outer SI.Voltage vsdDC "Source to drain voltage";
      outer SI.Voltage vsdDCSgn "Source-pin to drain-pin voltage";
      outer SI.Voltage vsgDC "Source to gate voltage";

      outer SI.Voltage vthTran "Threshold voltage";
      outer SI.Voltage vsdTran "Source to drain voltage";
      outer SI.Voltage vsdTranSgn "Source-pin to drain-pin voltage";
      outer SI.Voltage vsgTran "Source to gate voltage";

      parameter SI.Voltage PHI "Surface inversion potencial";
      parameter SI.Length LD "Lateral diffusion";
      parameter SI.Length W "Gate width";
      parameter SI.Length L "Gate length";
      parameter SI.Length TOX "Gate oxide thickness";
      parameter Real EPSR "Dielectric constant of the oxide";
      parameter Real CGDO "Gate-drain overlap capacitance per meter [F/m]";
      parameter Real CGSO "Gate-source overlap capacitance per meter [F/m]";

      parameter Boolean sourceGatePinsC;

    protected
      parameter SI.Length LEFF=L + 2*LD "Effective length";
      parameter SI.Capacitance COX=EPS0*EPSR*W*LEFF/TOX
        "Gate oxide capacitance";
      constant Real EPS0=8.85e-12 "Permittivity of free space [F/m]";
      parameter Real CGSOtimesW=CGSO*W;
      parameter Real CGDOtimesW=CGDO*W;
      parameter Real twoThirdsCOX=2/3*COX;
      parameter Real threeFourthsCOX=3/4*COX;
      parameter Real halfCOX=0.5*COX;

      parameter SI.Voltage vsdTranEPS=1e-4;
      parameter SI.Voltage vsdDCEPS=1e-4;

      Real Csg;
      Real Cdg;
      Real CsgAC;
      Real CdgAC;
      Real CpinsSG;
      Real CpinsDG;
      Real CpinsSGAC;
      Real CpinsDGAC;
    equation

      // ------------------------
      // Large-signal capacitance
      // ------------------------

      Cvar*der(vTran) = iTran;

      Cvar = if sourceGatePinsC then CpinsSG else CpinsDG;

      CpinsSG = if noEvent(vsdTranSgn < -vsdTranEPS) then Cdg else if noEvent(
        vsdTranSgn < vsdTranEPS) then 0.5*(Csg - Cdg)*vsdTranSgn/vsdTranEPS +
        0.5*(Csg + Cdg) else Csg;

      CpinsDG = if noEvent(vsdTranSgn < -vsdTranEPS) then Csg else if noEvent(
        vsdTranSgn < vsdTranEPS) then 0.5*(Cdg - Csg)*vsdTranSgn/vsdTranEPS +
        0.5*(Csg + Cdg) else Cdg;
      Csg - CGSOtimesW = if noEvent(vsgTran <= -vthTran - PHI) then 0 else if
        noEvent(vsgTran <= -vthTran) then twoThirdsCOX*((vthTran - vsgTran)/PHI
         + 1) else if noEvent(vsgTran <= -vthTran + vsdTran) then twoThirdsCOX
         else if noEvent(vsdTran <= 2*vsdTranEPS) then halfCOX else
        twoThirdsCOX*(1 - ((vsgTran - vsdTran + vthTran)/(2*(vsgTran + vthTran)
         - vsdTran))^2);

      Cdg - CGDOtimesW = if noEvent(vsgTran <= -vthTran + vsdTran) then 0 else
        if noEvent(vsdTran <= 2*vsdTranEPS) then threeFourthsCOX else COX*(1 -
        ((vsgTran + vthTran)/(2*(vsgTran + vthTran) - vsdTran))^2);

      // ------------------------------------------------
      // AC small-signal capacitance and operation region
      // ------------------------------------------------
      when ctrl_AC then
        CvarAC = if sourceGatePinsC then CpinsSGAC else CpinsDGAC;
        CpinsSGAC = if noEvent(vsdDCSgn < -vsdDCEPS) then CdgAC else if noEvent(
          vsdDCSgn < vsdDCEPS) then 0.5*(CsgAC - CdgAC)*vsdDCSgn/vsdDCEPS + 0.5
          *(CsgAC + CdgAC) else CsgAC;
        CpinsDGAC = if noEvent(vsdDCSgn < -vsdDCEPS) then CsgAC else if noEvent(
          vsdDCSgn < vsdDCEPS) then 0.5*(CdgAC - CsgAC)*vsdDCSgn/vsdDCEPS + 0.5
          *(CsgAC + CdgAC) else CdgAC;

        CsgAC = if (vsgDC <= -vthDC - PHI) then CGSOtimesW else if (vsgDC <= -
          vthDC) then twoThirdsCOX*((vthDC + vsgDC)/PHI + 1) + CGSOtimesW else
          if (vsgDC <= -vthDC + vsdDC) then twoThirdsCOX + CGSOtimesW else if (
          vsdDC <= 2*vsdDCEPS) then halfCOX + CGSOtimesW else twoThirdsCOX*(1
           - ((vsgDC - vsdDC + vthDC)/(2*(vsgDC + vthDC) - vsdDC))^2) +
          CGSOtimesW;

        CdgAC = if (vsgDC <= -vthDC + vsdDC) then CGDOtimesW else if (vsdDC <=
          2*vsdDCEPS) then threeFourthsCOX + CGDOtimesW else COX*(1 - ((vsgDC
           + vthDC)/(2*(vsgDC + vthDC) - vsdDC))^2) + CGDOtimesW;

      end when;

      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Documentation(info=""),
        Icon(Line(points=[-75, -75; 75, 75], style(
              thickness=1,
              color=3,
              arrow=1))));
    end Cdg;

    annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=0,
              thickness=2)), Text(extent=[-74, 26; 80, -28], string=
              "SPICE2_MOS1")));
  end SPICE2_MOS1P;

  model Spice2MOS1P
    extends INTERFACE.MOSFET;
    extends INIT.Part;
    inner SI.Voltage vsdDC "Source to drain voltage";
    inner SI.Voltage vsgDC "Source to gate voltage";
    inner SI.Voltage vsbDC "Source to bulk voltage";

    inner SI.Voltage vsdTran "Source to drain voltage";
    inner SI.Voltage vsgTran "Source to gate voltage";
    inner SI.Voltage vsbTran "Source to bulk voltage";

    SI.Voltage drain_vAC_mag "Magnitude of AC small-signal drain voltage";
    SI.Voltage drain_vAC_mag_dB
      "Magnitude (dB) of AC small-signal drain voltage";
    nonSI.Angle_deg drain_vAC_phase(start=0)
      "Phase (deg) of AC small-signal drain voltage";

    SI.Voltage source_vAC_mag "Magnitude of AC small-signal source voltage";
    SI.Voltage source_vAC_mag_dB
      "Magnitude (dB) of AC small-signal source voltage";
    nonSI.Angle_deg source_vAC_phase(start=0)
      "Phase (deg) of drain AC small-signal source voltage";

    SI.Voltage bulk_vAC_mag "Magnitude of AC small-signal bulk voltage";
    SI.Voltage bulk_vAC_mag_dB "Magnitude (dB) of AC small-signal bulk voltage";
    nonSI.Angle_deg bulk_vAC_phase(start=0)
      "Phase (deg) of AC small-signal bulk voltage";

    SI.Voltage gate_vAC_mag "Magnitude of AC small-signal gate voltage";
    SI.Voltage gate_vAC_mag_dB "Magnitude (dB) of AC small-signal gate voltage";
    nonSI.Angle_deg gate_vAC_phase(start=0)
      "Phase (deg) of AC small-signal gate voltage";

    SI.Current drain_iAC_mag "Magnitude of AC small-signal drain current";
    SI.Current drain_iAC_mag_dB
      "Magnitude (dB) of AC small-signal drain current";
    nonSI.Angle_deg drain_iAC_phase(start=0)
      "Phase (deg) of AC small-signal drain current";

    SI.Current source_iAC_mag "Magnitude of AC small-signal source current";
    SI.Current source_iAC_mag_dB
      "Magnitude (dB) of AC small-signal source current";
    nonSI.Angle_deg source_iAC_phase(start=0)
      "Phase (deg) of drain AC small-signal source current";

    SI.Current bulk_iAC_mag "Magnitude of AC small-signal bulk current";
    SI.Current bulk_iAC_mag_dB "Magnitude (dB) of AC small-signal bulk current";
    nonSI.Angle_deg bulk_iAC_phase(start=0)
      "Phase (deg) of AC small-signal bulk current";

    SI.Current gate_iAC_mag "Magnitude of AC small-signal gate current";
    SI.Current gate_iAC_mag_dB "Magnitude (dB) of AC small-signal gate current";
    nonSI.Angle_deg gate_iAC_phase(start=0)
      "Phase (deg) of AC small-signal gate current";

    parameter Boolean HIDDEN_COMPONENT=false "Enable or disable log";

    parameter SI.Area AD=1e-8 "drain difussion area";
    parameter SI.Area AS=1e-8 "Source difussion area";
    parameter Real CGBO=2e-10 "Gate-bulk overlap capacitance per meter [F/m]";
    parameter Real CGDO=4e-11 "Gate-drain overlap capacitance per meter [F/m]";
    parameter Real CGSO=4e-11 "Gate-source overlap capacitance per meter [F/m]";
    parameter Real CJ=2e-4
      "Capacitance at zero-bias voltage per squere meter of area [F/m2]";
    parameter Real CJSW=1e-9
      "Capacitance at zero-bias voltage per meter of perimeter [F/m]";
    parameter Real FC=0.5 "Substrate-junction forward-bias coefficient";
    parameter Real GAMMA=0.526 "Body-effect parameter [V0.5]";
    parameter SI.Current IS=1e-14 "Reverse saturation current at 300K";
    parameter Real KP=27.6e-6 "Transconductance parameter [A/V2]";
    parameter SI.Length L=100e-6 "Gate length";
    parameter Real LAMBDA=0.00 "Channel-length modulation [V-1]";
    parameter SI.Length LD=0.8e-6 "Lateral diffusion";
    parameter Real MJ=0.5 "Bulk junction capacitnce grading coefficient";
    parameter Real MJSW=0.33 "Perimeter capacitance grading coefficient";
    parameter SI.Length PD=4e-4 "drain difussion perimeter";
    parameter SI.Length PS=4e-4 "source difussion perimeter";
    parameter SI.Voltage PB=0.75 "Junction potencial";
    parameter SI.Voltage PHI=0.65 "Surface inversion potencial";
    parameter SI.Resistance RD=10 "Drain ohmic resistance";
    parameter SI.Resistance RS=10 "Source ohmic resistance";
    parameter SI.Resistance RB=10 "Bulk ohmic resistance";
    parameter SI.Resistance RG=10 "Gate ohmic resistance";
    parameter SI.Length TOX=1e-7 "Gate oxide thickness";
    parameter SI.Voltage VTO=-1 "Zero-bias threshold voltage";
    parameter SI.Length W=100e-6 "Gate width";

    constant Real EPSR=3.9 "Dielectric constant of the oxide";

    parameter SI.Resistance RSB=1e-4 "Source-Bulk junction resistance";
    parameter SI.Resistance RDB=1e-4 "Drain-Bulk junction resistance";

  protected
    inner SI.Voltage vthDC "Threshold voltage";
    inner SI.Voltage vsdDCSgn "Source-pin to drain-pin voltage";

    inner SI.Voltage vsdTranSgn "Source-pin to drain-pin voltage";
    inner SI.Voltage vthTran "Threshold voltage";

    inner SI.Voltage gate_vAC_Re;
    inner SI.Voltage gate_vAC_Im;
    inner SI.Voltage bulk_vAC_Re;
    inner SI.Voltage bulk_vAC_Im;

    // --------------------
    // Drain-Source current
    // --------------------
    SPICE2_MOS1P.Isd Isd(
      VTO=VTO,
      GAMMA=GAMMA,
      PHI=PHI,
      KP=KP,
      W=W,
      L=L,
      LD=LD,
      LAMBDA=LAMBDA) annotation (extent=[-10, -4; 10, 16], rotation=90);
    // --------------------
    // Source-Bulk junction
    // --------------------
    SPICE2_MOS1P.Idiode Dsb(IS=IS)
      annotation (extent=[48, -9; 68, 11], rotation=0);
    SPICE2_MOS1P.Cdiode Csb(
      CJ=CJ,
      CJSW=CJSW,
      MJ=MJ,
      MJSW=MJSW,
      FC=FC,
      PB=PB,
      P=PS,
      A=AS) annotation (extent=[40, -50; 60, -30], rotation=0);
    // -------------------
    // Drain-Bulk junction
    // -------------------
    SPICE2_MOS1P.Idiode Ddb(IS=IS)
      annotation (extent=[42, 23; 62, 43], rotation=0);
    SPICE2_MOS1P.Cdiode Cdb(
      CJ=CJ,
      CJSW=CJSW,
      MJ=MJ,
      MJSW=MJSW,
      FC=FC,
      PB=PB,
      P=PD,
      A=AD) annotation (extent=[52, 50; 72, 70], rotation=0);
    // ----------------
    // Gate capacitance
    // ----------------
    SPICE2_MOS1P.Cdg Cdg(
      PHI=PHI,
      LD=LD,
      W=W,
      L=L,
      TOX=TOX,
      EPSR=EPSR,
      CGDO=CGDO,
      CGSO=CGSO,
      sourceGatePinsC=false)
      annotation (extent=[-58, 31; -38, 51], rotation=180);
    SPICE2_MOS1P.Cdg Csg(
      PHI=PHI,
      LD=LD,
      W=W,
      L=L,
      TOX=TOX,
      EPSR=EPSR,
      CGDO=CGDO,
      CGSO=CGSO,
      sourceGatePinsC=true)
      annotation (extent=[-54, -25; -34, -5], rotation=180);
    SPICE2_MOS1P.Cbg Cbg(
      PHI=PHI,
      LD=LD,
      W=W,
      L=L,
      TOX=TOX,
      EPSR=EPSR,
      CGBO=CGBO) annotation (extent=[-48, -69; -28, -49], rotation=180);
    // ---------------
    // Drain resistors
    // ---------------
    Rbreak Rs(R=RS, HIDDEN_COMPONENT=true)
      annotation (extent=[-10, -90; 10, -70], rotation=90);
    Rbreak Rd(R=RD, HIDDEN_COMPONENT=true)
      annotation (extent=[-10, 62; 10, 82], rotation=90);

    // -------------
    // Gate resistor
    // -------------
    Rbreak Rg(R=RG, HIDDEN_COMPONENT=true)
      annotation (extent=[-116, -10; -96, 10], rotation=180);

    // -------------
    // Bulk resistor
    // -------------
    Rbreak Rb(R=RB, HIDDEN_COMPONENT=true)
      annotation (extent=[94, -10; 114, 10], rotation=0);
    Rbreak Rsb(HIDDEN_COMPONENT=true, R=RSB)
      annotation (extent=[8, -50; 28, -30]);
    Rbreak Rdb(HIDDEN_COMPONENT=true, R=RDB)
      annotation (extent=[14, 50; 34, 70]);
  equation

    //----------------------------------
    //Source-bulk junction: to avoid SSE
    //----------------------------------
    Dsb.vDiodeTran = Csb.vTran;

    //----------------------------------
    //Drain-bulk junction: to avoid SSE
    //----------------------------------
    Ddb.vDiodeTran = Cdb.vTran;

    // -----------------
    // Threshold voltage
    // -----------------  -vsbDC
    vthDC = (VTO - GAMMA*(sqrt(abs(PHI - vsbDC)) - sqrt(PHI)));
    vthTran = (VTO - GAMMA*(sqrt(abs(PHI - vsbTran)) - sqrt(PHI)));

    // ---
    // Vsd
    // ---
    vsdDC = noEvent((abs(Isd.vDC)));
    vsdDCSgn = Isd.vDC;

    vsdTran = noEvent(abs(Csg.vTran - Cdg.vTran));
    vsdTranSgn = Csg.vTran - Cdg.vTran;

    // ---
    // Vgs
    // ---
    vsgDC = max({Csg.vDC,Cdg.vDC});
    vsgTran = max({Csg.vTran,Cdg.vTran});

    // ---
    // Vbs
    // ---
    vsbDC = max({Csb.vDC,Cdb.vDC});
    vsbTran = max({Csb.vTran,Cdb.vTran});

    // ------------------------------------
    // Gate & bulk AC small-signal voltages
    // ------------------------------------
    gate_vAC_Re = g.vAC_Re;
    gate_vAC_Im = g.vAC_Im;
    bulk_vAC_Re = b.vAC_Re;
    bulk_vAC_Im = b.vAC_Im;

    (drain_vAC_mag,drain_vAC_phase) = Rect2Polar({d.vAC_Re,d.vAC_Im});
    drain_vAC_mag_dB = Decibels(drain_vAC_mag);

    (drain_iAC_mag,drain_iAC_phase) = Rect2Polar({d.iAC_Re,d.iAC_Im});
    drain_iAC_mag_dB = Decibels(drain_iAC_mag);

    (source_vAC_mag,source_vAC_phase) = Rect2Polar({s.vAC_Re,s.vAC_Im});
    source_vAC_mag_dB = Decibels(source_vAC_mag);

    (source_iAC_mag,source_iAC_phase) = Rect2Polar({s.iAC_Re,s.iAC_Im});
    source_iAC_mag_dB = Decibels(source_iAC_mag);

    (bulk_vAC_mag,bulk_vAC_phase) = Rect2Polar({b.vAC_Re,b.vAC_Im});
    bulk_vAC_mag_dB = Decibels(bulk_vAC_mag);

    (bulk_iAC_mag,bulk_iAC_phase) = Rect2Polar({b.iAC_Re,b.iAC_Im});
    bulk_iAC_mag_dB = Decibels(bulk_iAC_mag);

    (gate_vAC_mag,gate_vAC_phase) = Rect2Polar({g.vAC_Re,g.vAC_Im});
    gate_vAC_mag_dB = Decibels(gate_vAC_mag);

    (gate_iAC_mag,gate_iAC_phase) = Rect2Polar({g.iAC_Re,g.iAC_Im});
    gate_iAC_mag_dB = Decibels(gate_iAC_mag);

    when ctrl_log_DC and ((HIDDEN_COMPONENT == false) or (LOG_RESULTS == 2 and
        HIDDEN_COMPONENT == true)) then
      LogVariable(g.vDC);
      LogVariable(d.vDC);
      LogVariable(s.vDC);
      LogVariable(b.vDC);
    end when;
    when ctrl_log_DC and ((HIDDEN_COMPONENT == false and LOG_RESULTS > 0) or (
        HIDDEN_COMPONENT == true and LOG_RESULTS == 2)) then
      LogVariable(vsdDC);
      LogVariable(vsbDC);
      LogVariable(vsgDC);
    end when;

    // ---------------------
    // Component connections
    // ---------------------
    connect(d, Rd.n)
      annotation (points=[0, 110; 0, 83; 6.73533e-016, 83], style(color=1));
    connect(Rd.p, Isd.n) annotation (points=[-6.73533e-016, 61; -6.73533e-016,
          49; 4.94602e-022, 49; 4.94602e-022, 37; 6.73533e-016, 37;
          6.73533e-016, 17], style(color=1));
    connect(Isd.p, Rs.n) annotation (points=[-6.73533e-016, -5; -6.73533e-016,
          -20.75; 4.94602e-022, -20.75; 4.94602e-022, -36.5; 6.73533e-016,
          -36.5; 6.73533e-016, -69], style(color=1));
    connect(Rs.p, s) annotation (points=[-6.73533e-016, -91; -6.73533e-016,
          -98.25; 0, -98.25; 0, -110], style(color=1));

    connect(Rg.p, Cdg.n) annotation (points=[-95, -1.34707e-015; -80,
          -1.34707e-015; -80, 41; -59, 41], style(color=1));
    connect(Rg.p, Csg.n) annotation (points=[-95, -1.34707e-015; -80,
          -1.34707e-015; -80, -15; -55, -15], style(color=1));
    connect(Rg.p, Cbg.n) annotation (points=[-95, -1.34707e-015; -80,
          -1.34707e-015; -80, -59; -49, -59], style(color=1));
    connect(Rg.n, g);

    connect(Rb.p, Dsb.n)
      annotation (points=[93, 0; 80, 0; 80, 1; 69, 1], style(color=1));
    connect(Rb.p, Csb.n)
      annotation (points=[93, 0; 80, 0; 80, -40; 61, -40], style(color=1));
    connect(Rb.p, Ddb.n)
      annotation (points=[93, 0; 80, 0; 80, 33; 63, 33], style(color=1));
    connect(Rb.p, Cdb.n)
      annotation (points=[93, 0; 80, 0; 80, 60; 73, 60], style(color=1));
    connect(Rb.p, Cbg.p)
      annotation (points=[93, 0; 80, 0; 80, -59; -27, -59], style(color=1));
    connect(b, Rb.n);

    connect(Isd.p, Csg.p) annotation (points=[-6.73533e-016, -5; -6.73533e-016,
           -15; -33, -15], style(color=1));

    connect(Isd.n, Cdg.p) annotation (points=[6.73533e-016, 17; 6.73533e-016,
          41; -37, 41], style(color=1));

    connect(Rsb.n, Csb.p)
      annotation (points=[29, -40; 39, -40], style(color=1));
    connect(Rsb.p, Isd.p) annotation (points=[7, -40; -6.73533e-016, -40;
          -6.73533e-016, -5], style(color=1));
    connect(Rdb.n, Cdb.p) annotation (points=[35, 60; 51, 60], style(color=1));
    connect(Rdb.p, Rd.p) annotation (points=[13, 60; -6.73533e-016, 60;
          -6.73533e-016, 61], style(color=1));
    connect(Cdb.p, Ddb.p)
      annotation (points=[51, 60; 41, 60; 41, 33], style(color=1));
    connect(Dsb.p, Csb.p)
      annotation (points=[47, 1; 39, 1; 39, -40], style(color=1));
    annotation (
      Coordsys(extent=[-130, -100; 130, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[0, -100; 100, 0],
          string="%name",
          style(color=0)),
        Text(
          extent=[-160, 100; 160, 140],
          string="%=W",
          style(color=0)),
        Text(
          extent=[-160, 60; 160, 100],
          string="%=L",
          style(color=0)),
        Line(points=[-80, 0; -60, 0], style(thickness=1, color=3)),
        Line(points=[0, 80; 0, 50], style(thickness=1, color=3)),
        Line(points=[0, -80; 0, -50], style(thickness=1, color=3)),
        Line(points=[-40, 0; 80, 0], style(thickness=1, color=3)),
        Line(points=[-40, 50; 0, 50], style(thickness=1, color=3)),
        Line(points=[-40, 70; -40, -70], style(thickness=1, color=3)),
        Line(points=[-60, 40; -60, -40], style(thickness=1, color=3)),
        Line(points=[-100, 0; -80, 0], style(thickness=1, color=3)),
        Line(points=[0, 100; 0, 80], style(thickness=1, color=3)),
        Line(points=[0, -100; 0, -80], style(thickness=1, color=3)),
        Line(points=[80, 0; 100, 0], style(thickness=1, color=3)),
        Polygon(points=[-11, -42; -11, -58; -32, -50; -11, -42], style(
              fillPattern=1)),
        Line(points=[0, -50; -40, -50], style(fillPattern=1))),
      Diagram(
        Text(
          extent=[-145, -5; -135, 5],
          string="G",
          style(color=0)),
        Text(
          extent=[-5, 105; 5, 115],
          string="D",
          style(color=0)),
        Text(
          extent=[-5, -115; 5, -105],
          string="S",
          style(color=0)),
        Text(
          extent=[135, -5; 145, 5],
          string="B",
          style(color=0))));

  end Spice2MOS1P;

end BREAKOUT;
