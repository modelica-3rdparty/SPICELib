package WAVEFORMS

  partial model NULL
    extends INIT.Part;
    replaceable type SignalType = Real;
  protected
    SignalType signal;
    parameter SignalType TRANS_INITIAL=0;
  equation
    signal = 0;
  end NULL;

  partial model EXP
    extends INIT.Part;
    replaceable type SignalType = Real;
    parameter SignalType S1=0 "Initial signal";
    parameter SignalType S2=0 "Peak signal";
    parameter SI.Time TD1(min=0) = 0 "Rise (fall) delay";
    parameter SI.Time TC1(min=0) = 0 "Rise (fall) time constant";
    parameter SI.Time TD2(min=0) = 0 "Fall (rise) delay";
    parameter SI.Time TC2(min=0) = 0 "Fall (rise) time constant";
  protected
    parameter SignalType TRANS_INITIAL=S1;
    SignalType signal;
    SI.Time timeStartTran(start=-1);
    SI.Time timeTran;
  equation
    when ctrl_Tran then
      timeStartTran = time;
    end when;
    timeTran = if ctrl_Tran then time - timeStartTran else -1;
    signal = if timeTran < TD1 then S1 else if timeTran < TD2 then S1 + (S2 -
      S1)*(1 - exp(-(timeTran - TD1)/TC1)) else S1 + (S2 - S1)*((1 - exp(-(
      timeTran - TD1)/TC1)) - (1 - exp(-(timeTran - TD2)/TC2)));
  end EXP;

  partial model PULSE
    extends INIT.Part;
    replaceable type SignalType = Real;
    parameter SignalType S1=0 "Initial signal";
    parameter SignalType S2=0 "Pulse signal";
    parameter SI.Time TD(min=0) = 0 "Delay";
    parameter SI.Time TF(min=0) = 0 "Fall time";
    parameter SI.Time TR(min=0) = 0 "Rise time";
    parameter SI.Time PW(min=0) = 0 "Pulse width";
    parameter SI.Time PER(min=TR + PW + TF) "Period";
  protected
    SignalType signal;
    SI.Time timePulse(start=0, fixed=true);
    parameter SignalType TRANS_INITIAL=S1;
  equation
    when ctrl_Tran then
      reinit(timePulse, -TD);
    end when;
    signal = if timePulse < 0 or timePulse > TR + PW + TF then S1 else if
      timePulse > TR + PW then S2 + (S1 - S2)*(timePulse - TR - PW)/TF else if
      timePulse > TR then S2 else S1 + (S2 - S1)*timePulse/TR;
    der(timePulse) = if ctrl_Tran then 1 else 0;
    when timePulse > PER then
      reinit(timePulse, 0);
    end when;
  end PULSE;

  partial model PWL
    extends INIT.Part;
    replaceable type SignalType = Real;
    parameter SignalType signalCorners[:] "Signal at corners";
    parameter SI.Time timeCorners[:] "Time at corners";
    parameter Integer N=size(signalCorners, 1) "Number of corner points";
  protected
    SignalType signal;
    parameter SignalType TRANS_INITIAL=signalCorners[1];
    Real c[N];
    SignalType f[N];
    SI.Time timeStartTran;
    SI.Time timeTran;
  equation
    assert(size(signalCorners, 1) == size(timeCorners, 1),
      "Invalid corner points");
    assert(timeCorners[1] == 0, "First time corner must be zero");
    when ctrl_Tran then
      timeStartTran = time;
    end when;
    timeTran = if ctrl_Tran then time - timeStartTran else -1;
    for i in 1:N - 1 loop
      assert(timeCorners[i] < timeCorners[i + 1], "Invalid time corners");
      c[i] = if not timeTran < timeCorners[i] and timeTran < timeCorners[i + 1]
         then 1 else 0;
      f[i] = signalCorners[i] + (signalCorners[i + 1] - signalCorners[i])*(
        timeTran - timeCorners[i])/(timeCorners[i + 1] - timeCorners[i]);
    end for;
    c[N] = if not timeTran < timeCorners[N] then 1 else 0;
    f[N] = signalCorners[N];
    signal = c*f;
  end PWL;

  annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71,
            thickness=2)), Text(
        extent=[-72, 22; 74, -22],
        style(thickness=2),
        string="WAVEFORMS")));
  partial model SIN

    extends INIT.Part;
    replaceable type SignalType = Real;
    parameter SignalType OFF=0 "DC signal";
    parameter SignalType AMPL=0 "Amplitude";
    parameter SI.Frequency FREQ(min=0) "Frequency";
  protected
    parameter SignalType TRANS_INITIAL=OFF;
    SignalType signal;
    SI.Time timeStartTran(start=-1);
    SI.Time timeTran;
    constant Real pi=3.14159265358979;
  equation
    when ctrl_Tran then
      timeStartTran = time;
    end when;
    timeTran = if ctrl_Tran then time - timeStartTran else -1;
    signal = OFF + AMPL*sin(2*pi*FREQ*timeTran);

  end SIN;

  model CONST
    extends INIT.Part;
    replaceable type SignalType = Real;
    parameter SignalType OFF=0 "Constant signal";
  protected
    parameter SignalType TRANS_INITIAL=OFF;
    SignalType signal;
    SI.Time timeStartTran(start=-1);
    SI.Time timeTran;
  equation
    when ctrl_Tran then
      timeStartTran = time;
    end when;
    timeTran = if ctrl_Tran then time - timeStartTran else -1;
    signal = OFF;
  end CONST;
end WAVEFORMS;
