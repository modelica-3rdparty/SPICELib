partial model schematic
  parts.breakout.Spice2MOS1 NMOS(
    L=2e-6,
    W=4e-6,
    CGDO=3.227e-10,
    CGSO=3.227e-10,
    CJ=0.0003002,
    CJSW=1.376e-10,
    GAMMA=0.2844,
    KP=5.317e-5,
    LAMBDA=0.01302,
    LD=1.526e-7,
    MJ=0.5,
    MJSW=0.5,
    PB=0.7365,
    PHI=0.7095,
    TOX=1.6e-8,
    VTO=0.8307,
    RS=10,
    RB=10) annotation (extent=[-16, -42; 38, 0], rotation=0);
  annotation (Diagram, Coordsys(grid=[0.25, 0.25], component=[20, 20]));
  parts.breakout.Ground Ground1 annotation (extent=[1, -97; 21, -77]);
  parts.breakout.Ground Ground2 annotation (extent=[-69, 14; -49, 34]);
  parts.source.VPULSE VPULSE1(
    PW=500e-9,
    AC_MAG=0,
    TD=500e-9,
    PER=1020e-9,
    DC_VALUE=5,
    S2=0,
    S1=5,
    TF=70e-9,
    TR=70e-9) annotation (extent=[-80, -52; -60, -32], rotation=270);
  parts.breakout.Spice2MOS1P PMOS(
    CGDO=2.248e-10,
    CGSO=2.28e-10,
    CJ=0.0004138,
    CJSW=1.004e-10,
    KP=2.239e-5,
    L=2e-6,
    LAMBDA=0.01525,
    LD=1.063e-7,
    MJSW=0.5,
    PB=0.7485,
    PHI=0.7054,
    TOX=1.6e-8,
    VTO=-0.8407,
    W=20e-6) annotation (extent=[-13.5, 74.75; 36.75, 33]);
  parts.breakout.Ground Ground3
    annotation (extent=[-79.75, -88.75; -59.75, -68.75]);
  parts.source.VSIN VDD(
    OFF=5,
    AMPL=0,
    FREQ=0,
    DC_VALUE=5,
    AC_MAG=0) annotation (extent=[-69, 52.75; -49, 72.75], rotation=270);
equation
  connect(Ground1.p, NMOS.s)
    annotation (points=[11, -76; 11, -44.1], style(color=1));
  connect(PMOS.g, NMOS.g) annotation (points=[-15.4327, 53.875; -18.0769,
        53.875; -18.0769, -21], style(color=1));
  connect(PMOS.d, NMOS.d) annotation (points=[11.625, 30.9125; 11.625, 2.1; 11,
         2.1], style(color=1));
  connect(VPULSE1.p, NMOS.g)
    annotation (points=[-70, -31; -70, -21; -18.0769, -21], style(color=1));
  connect(NMOS.b, Ground1.p) annotation (points=[40.0769, -21; 40.0769, -50.5;
        11, -50.5; 11, -76], style(color=1));
  connect(VPULSE1.n, Ground3.p) annotation (points=[-70, -53; -70, -60.75; -69.75,
         -60.75; -69.75, -67.75], style(color=1));
  connect(VDD.n, Ground2.p)
    annotation (points=[-59, 51.75; -59, 35], style(color=1));
  connect(VDD.p, PMOS.s) annotation (points=[-59, 73.75; -59, 76.8375; 11.625,
        76.8375], style(color=1));
  connect(PMOS.s, PMOS.b) annotation (points=[11.625, 76.8375; 38.6827, 76.8375;
         38.6827, 53.875], style(color=1));
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.circ2 documentation
	</HTML>
"));
end schematic;


model circ2_Tran
  analyses.TRAN TRAN(
    LogResults=0,
    redeclare model Circuit = schematic,
    TSTOP=1e-6,
    SOLVE_STATIC=0,
    TimeScale=1e-7,
    SKIPBP=false) annotation (extent=[-20, 0; 0, 20]);
  annotation (experiment(StopTime=1.1e-006, Tolerance=0.001),
      experimentSetupOutput);
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.circ2 documentation
	</HTML>
"));
end circ2_Tran;
