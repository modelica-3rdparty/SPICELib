

package SPECIAL

  model IC1
    extends INTERFACE.OnePin;
    extends INIT.Part;
    parameter SI.Voltage IC;
    constant SI.Resistance R_EPS=2e-4;
  protected
    SI.Voltage vClampDC;
    SI.Voltage vClampTran;
    SI.Time timeClampDC(start=1E100);
    SI.Time timeClampTran(start=1E100);
  equation
    // ------------
    // Static model
    // ------------
    p.iDC = if ctrl_IC_clampDC then (p.vDC - vClampDC)/R_EPS else 0;
    when ctrl_IC_clampDC then
      timeClampDC = time;
    end when;
    vClampDC = if ctrl_IC_clampDC and ctrl_IC_mode == 0 then IC else if
      ctrl_IC_clampDC and ctrl_IC_mode == 1 then IC*(time - timeClampDC)/
      TIME_SCALE else 0;
    // ---------------------
    // AC small-signal model
    // ---------------------
    {p.iAC_Re,p.iAC_Im} = zeros(2);
    // ---------------
    // Transient model
    // ---------------
    p.iTran = if ctrl_IC_clampTran then (p.vTran - vClampTran)/R_EPS else 0;
    when ctrl_IC_clampTran then
      timeClampTran = time;
    end when;
    vClampTran = if ctrl_IC_clampTran and ctrl_IC_mode == 0 then IC else if
      ctrl_IC_clampTran and ctrl_IC_mode == 1 then IC*(time - timeClampTran)/
      TIME_SCALE else 0;
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[-100, -55; 100, 0],
          string="%=IC",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Rectangle(extent=[-30, 20; 30, 80], style(color=3)),
        Text(
          extent=[-30, 20; 30, 80],
          string="+",
          style(color=0)),
        Line(points=[0, 80; 0, 100], style(color=3, thickness=1))));
  end IC1;

  model IC2
    extends INTERFACE.OnePort;
    extends INIT.Part;
    parameter SI.Voltage IC;
    constant SI.Resistance R_EPS=2e-4;
  protected
    SI.Voltage vClampDC;
    SI.Voltage vClampTran;
    SI.Time timeClampDC(start=1E100);
    SI.Time timeClampTran(start=1E100);
  equation
    // ------------
    // Static model
    // ------------
    iDC = if ctrl_IC_clampDC then (vDC - vClampDC)/R_EPS else 0;
    when ctrl_IC_clampDC then
      timeClampDC = time;
    end when;
    vClampDC = if ctrl_IC_clampDC and ctrl_IC_mode == 0 then IC else if
      ctrl_IC_clampDC and ctrl_IC_mode == 1 then IC*(time - timeClampDC)/
      TIME_SCALE else 0;
    // ---------------------
    // AC small-signal model
    // ---------------------
    {iAC_Re,iAC_Im} = zeros(2);
    // ---------------
    // Transient model
    // ---------------
    iTran = if ctrl_IC_clampTran then (vTran - vClampTran)/R_EPS else 0;
    when ctrl_IC_clampTran then
      timeClampTran = time;
    end when;
    vClampTran = if ctrl_IC_clampTran and ctrl_IC_mode == 0 then IC else if
      ctrl_IC_clampTran and ctrl_IC_mode == 1 then IC*(time - timeClampTran)/
      TIME_SCALE else 0;
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(
        Text(
          extent=[-100, -55; 100, 0],
          string="%=IC",
          style(color=0)),
        Text(
          extent=[-100, -110; 100, -55],
          string="%name",
          style(color=0)),
        Rectangle(extent=[-120, 10; 120, 80], style(color=3))));
  end IC2;

  annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71,
            thickness=2)), Text(
        extent=[-66, 42; 70, -42],
        style(thickness=2),
        string="SPECIAL")));
end SPECIAL;

