partial model schematic

  annotation (Diagram(Text(extent=[0, 34; 12, 28], string="Vnand")), Coordsys(
        grid=[1, 1], component=[20, 20]));
  parts.breakout.Ground Ground1 annotation (extent=[-38.8, -60; -28.8, -52]);
  parts.breakout.Ground Ground2 annotation (extent=[-92, -28.6; -80, -18.6]);
  parts.source.VPULSE V1(
    PW=500e-9,
    AC_MAG=0,
    DC_VALUE=5,
    S2=0,
    S1=5,
    TD=0e-9,
    PER=1040e-9,
    TF=20e-9,
    TR=20e-9) annotation (extent=[-87.9, -51.4; -68, -32.7], rotation=270);
  parts.source.VPULSE V2(
    AC_MAG=0,
    TD=0e-9,
    DC_VALUE=5,
    S2=0,
    S1=5,
    PW=1000e-9,
    PER=2040e-9,
    TF=20e-9,
    TR=20e-9) annotation (extent=[-96.4, -13.5; -76, 6.4], rotation=270);
  parts.breakout.Ground Ground3 annotation (extent=[-82, -62.7; -74, -57]);
  parts.breakout.Spice2MOS1 N1(
    L=2e-6,
    W=4e-6,
    CJ=0.0003002,
    LAMBDA=0.01302,
    LD=1.526e-7,
    MJ=0.5,
    MJSW=0.5,
    PB=0.7365,
    TOX=1.6e-8,
    RS=10,
    RB=10,
    CJSW=1.376e-15,
    GAMMA=0.37,
    KP=40e-6,
    PHI=0.6,
    VTO=1,
    CGBO=2e-8,
    CGDO=3.227e-8,
    CGSO=3.227e-8,
    AD=1e-12,
    AS=1e-12,
    PD=1e-6,
    PS=1e-6) annotation (extent=[-44, -42; -24, -22]);
  parts.breakout.Spice2MOS1P P1(
    CJ=0.0004138,
    L=2e-6,
    LAMBDA=0.01525,
    LD=1.063e-7,
    MJSW=0.5,
    PB=0.7485,
    TOX=1.6e-8,
    W=20e-6,
    GAMMA=0.4,
    KP=16e-6,
    PHI=0.6,
    VTO=-1,
    CGBO=2e-8,
    CGDO=2.248e-8,
    CGSO=2.28e-8,
    CJSW=1.004e-8,
    FC=0.5,
    IS=1e-14,
    MJ=0.5,
    RD=10,
    RS=10,
    RB=10,
    RG=10,
    AD=1e-12,
    AS=1e-12,
    PD=1e-6,
    PS=1e-6) annotation (extent=[-42, 42; -62, 62], rotation=180);
  parts.breakout.Spice2MOS1 N2(
    L=2e-6,
    W=4e-6,
    CJ=0.0003002,
    LAMBDA=0.01302,
    LD=1.526e-7,
    MJ=0.5,
    MJSW=0.5,
    PB=0.7365,
    TOX=1.6e-8,
    RS=10,
    RB=10,
    CJSW=1.376e-15,
    GAMMA=0.37,
    KP=40e-6,
    PHI=0.6,
    VTO=1,
    CGBO=2e-8,
    CGDO=3.227e-8,
    CGSO=3.227e-8,
    FC=0.5,
    IS=1e-14,
    RD=10,
    RG=10,
    AD=1e-12,
    AS=1e-12,
    PD=1e-6,
    PS=1e-6) annotation (extent=[-20, 0; 0, 20]);
  parts.breakout.Spice2MOS1P P2(
    CJ=0.0004138,
    L=2e-6,
    LAMBDA=0.01525,
    LD=1.063e-7,
    MJSW=0.5,
    PB=0.7485,
    TOX=1.6e-8,
    W=20e-6,
    GAMMA=0.4,
    KP=16e-6,
    PHI=0.6,
    VTO=-1,
    CGBO=2e-8,
    CGDO=2.248e-8,
    CGSO=2.28e-8,
    CJSW=1.004e-8,
    AD=1e-12,
    AS=1e-12,
    PD=1e-6,
    PS=1e-6) annotation (extent=[3, 44; -23, 60], rotation=180);
  parts.breakout.Ground Ground4 annotation (extent=[-88, 47.1; -74, 57.1]);
  parts.breakout.Ground Ground5 annotation (extent=[-5.6, -16.5; 5.8, -9.7]);
  parts.source.VCONST VDD(
    OFF=5,
    DC_VALUE=5,
    AC_MAG=0) annotation (extent=[-91, 65; -71, 85], rotation=270);
equation
  connect(V1.p, N1.g) annotation (points=[-77.95, -31.765; -61.3596, -31.765;
        -61.3596, -32; -44.7692, -32], style(color=1));
  connect(V2.n, Ground2.p) annotation (points=[-86.2, -14.495; -86.2, -16.5475;
         -86, -16.5475; -86, -18.1], style(color=1));
  connect(N1.d, N2.s)
    annotation (points=[-34, -21; -34, -1; -10, -1], style(color=1));
  connect(N1.s, N1.b) annotation (points=[-34, -43; -23.2308, -43; -23.2308,
        -32], style(color=1));
  connect(P2.d, N2.d) annotation (points=[-10, 43.2; -10, 32.1; -10, 32.1; -10,
         21], style(color=1));
  connect(P1.s, P2.s)
    annotation (points=[-52, 63; -52, 72; -10, 72; -10, 60.8], style(color=1));
  connect(P1.s, P1.b)
    annotation (points=[-52, 63; -41.2308, 63; -41.2308, 52], style(color=1));
  connect(P2.s, P2.b)
    annotation (points=[-10, 60.8; 4, 60.8; 4, 52], style(color=1));
  connect(P2.g, N2.g)
    annotation (points=[-24, 52; -23.9, 10.1; -20.7692, 10], style(color=1));
  connect(P1.g, N1.g) annotation (points=[-62.7692, 52; -62.7692, -32; -44.7692,
         -32], style(color=1));
  connect(N1.s, Ground1.p)
    annotation (points=[-34, -43; -34, -51.6; -33.8, -51.6], style(color=1));
  connect(P1.d, P2.d)
    annotation (points=[-52, 41; -10, 41; -10, 43.2], style(color=1));
  connect(V2.p, N2.g) annotation (points=[-86.2, 7.395; -85.1, 10.1; -20.7692,
        10], style(color=1));
  connect(V1.n, Ground3.p) annotation (points=[-77.95, -52.335; -77.95,
        -54.4325; -78, -54.4325; -78, -56.715], style(color=1));
  connect(N2.b, Ground5.p)
    annotation (points=[0.769231, 10; 0.1, 10; 0.1, -9.36], style(color=1));
  connect(VDD.n, Ground4.p)
    annotation (points=[-81, 64; -81, 57.6], style(color=1));
  connect(VDD.p, P2.s) annotation (points=[-81, 86; -81, 93; -29, 93; -29, 72;
        -10, 72; -10, 60.8], style(color=1));
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.nandcmos documentation
	</HTML>
"));
end schematic;


model TRAN
  analyses.TRAN TRAN1(
    LogResults=0,
    redeclare model Circuit = schematic,
    TimeScale=1e-7,
    SKIPBP=false,
    TSTOP=2e-6) annotation (extent=[-12, -14; 8, 6]);
  annotation (experiment(StopTime=2.1e-006), experimentSetupOutput(events=false));
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.nandcmos documentation
	</HTML>
"));
end TRAN;
