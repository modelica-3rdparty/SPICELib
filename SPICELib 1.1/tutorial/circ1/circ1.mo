partial model schematic
  parts.breakout.Rbreak R(R=1000) annotation (extent=[52, 14; 72, 34]);
  parts.breakout.Ground Ground1 annotation (extent=[30, -78; 50, -58]);
  annotation (Diagram);
  parts.source.VSIN V1(
    FREQ=50,
    AMPL=5,
    AC_MAG=1,
    DC_VALUE=0.7,
    OFF=2) annotation (extent=[-94, -20; -74, 0], rotation=270);
  src.BREAKOUT.PSPICE_diode D1(
    IS=14.11e-9,
    RS=33.89e-3,
    N=1.984,
    VJ=0.3905,
    M=0.2762,
    BV=100.1,
    IKF=94.81,
    ISR=100e-12,
    NR=2,
    IBV=10,
    CJ0=51.17e-12,
    TT=4.761e-6) annotation (extent=[-54, 36; -34, 56]);
  parts.breakout.PSPICE_diode D3(
    IS=14.11e-9,
    RS=33.89e-3,
    N=1.984,
    VJ=0.3905,
    M=0.2762,
    BV=100.1,
    IKF=94.81,
    ISR=100e-12,
    NR=2,
    IBV=10,
    CJ0=51.17e-12,
    TT=4.761e-6) annotation (extent=[-52, 2; -32, 22]);
  parts.breakout.PSPICE_diode D2(
    IS=14.11e-9,
    RS=33.89e-3,
    N=1.984,
    VJ=0.3905,
    M=0.2762,
    BV=100.1,
    IKF=94.81,
    ISR=100e-12,
    NR=2,
    IBV=10,
    CJ0=51.17e-12,
    TT=4.761e-6) annotation (extent=[-16, 36; 4, 56]);
  parts.breakout.PSPICE_diode D4(
    IS=14.11e-9,
    RS=33.89e-3,
    N=1.984,
    VJ=0.3905,
    M=0.2762,
    BV=100.1,
    IKF=94.81,
    ISR=100e-12,
    NR=2,
    IBV=10,
    CJ0=51.17e-12,
    TT=4.761e-6) annotation (extent=[-14, 2; 6, 22]);
  src.BREAKOUT.Cbreak C(C=100e-6)
    annotation (extent=[36, -22; 56, -2], rotation=270);
equation
  connect(R.n, Ground1.p) annotation (points=[73, 24; 86, 24; 86, -44; 40, -44;
         40, -57], style(color=1));
  connect(V1.p, D2.p) annotation (points=[-84, 1; -84, 58; -26, 58; -26, 46; -17,
         46], style(color=1));
  connect(D1.n, D2.p) annotation (points=[-33, 46; -17, 46], style(color=1));
  connect(D2.n, R.p)
    annotation (points=[5, 46; 16, 46; 16, 24; 51, 24], style(color=1));
  connect(D4.n, R.p)
    annotation (points=[7, 12; 16, 12; 16, 24; 51, 24], style(color=1));
  connect(D1.p, D3.p)
    annotation (points=[-55, 46; -64, 46; -64, 12; -53, 12], style(color=1));
  connect(D3.p, Ground1.p) annotation (points=[-53, 12; -64, 12; -64, 28; -76,
        28; -76, -44; 40, -44; 40, -57], style(color=1));
  connect(V1.n, D4.p)
    annotation (points=[-84, -21; -22, -21; -22, 12; -15, 12], style(color=1));
  connect(D3.n, D4.p) annotation (points=[-31, 12; -15, 12], style(color=1));
  connect(R.p, C.p)
    annotation (points=[51, 24; 46, 24; 46, -1], style(color=1));
  connect(Ground1.p, C.n)
    annotation (points=[40, -57; 40, -44; 46, -44; 46, -23], style(color=1));
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.circ1 documentation
	</HTML>
"));
end schematic;


model circ1_OP
  analyses.OP OP(
    redeclare model Circuit = schematic,
    LogResults=0,
    TimeScale=0.1,
    SOLVE_STATIC=0) annotation (extent=[-20, 0; 0, 20]);
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.circ1 documentation
	</HTML>
"));
end circ1_OP;


model circ1_AC
  analyses.AC AC(
    LogResults=0,
    redeclare model Circuit = schematic,
    SOLVE_STATIC=0,
    TYPE_AC_SWEEP=1,
    END_FREQUENCY=1000,
    TimeScale=0.01,
    START_FREQUENCY=1,
    POINTS_NUMBER=100) annotation (extent=[-20, 0; 0, 20]);
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.circ1 documentation
	</HTML>
"));
end circ1_AC;


model circ1_TRAN
  analyses.TRAN TRAN(
    LogResults=0,
    SOLVE_STATIC=0,
    redeclare model Circuit = schematic,
    TimeScale=0.01,
    TSTOP=0.05,
    SKIPBP=false) annotation (extent=[-20, 0; 0, 20]);
  annotation (experiment, experimentSetupOutput);
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.circ1 documentation
	</HTML>
"));
end circ1_TRAN;
