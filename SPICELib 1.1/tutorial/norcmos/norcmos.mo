model schematic
  parts.breakout.Spice2MOS1P MPA(
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
    PD=0.5e-7,
    PS=0.5e-7,
    AD=1e-8,
    AS=1e-8) annotation (extent=[44, 32; 4, 64], rotation=180);
  parts.breakout.Spice2MOS1P MPB(
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
    PD=0.5e-7,
    PS=0.5e-7) annotation (extent=[50, 28; 86, 0]);
  parts.breakout.Spice2MOS1 MNA(
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
    PD=0.5e-7,
    PS=0.5e-7) annotation (extent=[-2, -64; 32, -30]);
  parts.breakout.Spice2MOS1 MNB(
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
    PD=0.5e-7,
    PS=0.5e-7) annotation (extent=[42, -62; 80, -32]);
  parts.source.VCONST VDD(
    AC_MAG=0,
    DC_VALUE=5,
    OFF=5) annotation (extent=[-36, 46; -14, 68], rotation=270);
  parts.breakout.Ground Ground2 annotation (extent=[-86, -92; -66, -72]);
  parts.breakout.Ground Ground4 annotation (extent=[-34, 12; -14, 32]);
  annotation (Diagram);
  parts.source.VPULSE V1(
    PW=500e-9,
    AC_MAG=0,
    DC_VALUE=5,
    S2=0,
    S1=5,
    TD=0e-9,
    TF=20e-9,
    TR=20e-9,
    PER=1040e-9) annotation (extent=[-86, -48; -66, -28], rotation=270);
  parts.breakout.Ground Ground1 annotation (extent=[28, -100; 48, -80]);
  parts.source.VPULSE V2(
    AC_MAG=0,
    TD=0e-9,
    DC_VALUE=5,
    S2=0,
    S1=5,
    PW=1000e-9,
    PER=2040e-9,
    TF=20e-9,
    TR=20e-9) annotation (extent=[-42, -62; -20, -36], rotation=270);
  parts.breakout.Ground Ground3 annotation (extent=[-40, -90; -20, -70]);
equation
  connect(MNA.b, MNA.s) annotation (points=[33.3077, -47; 36, -47; 36, -65.7;
        15, -65.7], style(color=1));
  connect(MNB.b, MNB.s) annotation (points=[81.4615, -47; 82, -47; 82, -64; 72,
         -64; 61, -63.5], style(color=1));
  connect(MNA.s, MNB.s) annotation (points=[15, -65.7; 15, -66; 61, -66; 61, -63.5],
       style(color=1));
  connect(MNA.d, MNB.d) annotation (points=[15, -28.3; 15, -16; 61, -16; 61,
        -30.5], style(color=1));
  connect(VDD.n, Ground4.p)
    annotation (points=[-25, 44.9; -25, 42; -24, 42; -24, 33], style(color=1));
  connect(VDD.p, MPA.s)
    annotation (points=[-25, 69.1; -25, 80; 24, 80; 24, 65.6], style(color=1));
  connect(MPB.s, MPA.d)
    annotation (points=[68, 29.4; 68, 24; 24, 24; 24, 30.4], style(color=1));
  connect(MPA.b, VDD.p) annotation (points=[45.5385, 48; 52, 48; 52, 80; -25,
        80; -25, 69.1], style(color=1));
  connect(MPB.b, VDD.p) annotation (points=[87.3846, 14; 92, 14; 92, 82; -25,
        82; -25, 69.1], style(color=1));
  connect(MPB.g, MNB.g) annotation (points=[48.6154, 14; 40, 14; 40, -47;
        40.5385, -47], style(color=1));
  connect(MPA.g, MNA.g) annotation (points=[2.46154, 48; -10, 48; -10, -47;
        -3.30769, -47], style(color=1));
  connect(MNB.d, MPB.d) annotation (points=[61, -30.5; 66, -30; 72, -32; 72,
        -1.4; 68, -1.4], style(color=1));
  connect(V1.n, Ground2.p)
    annotation (points=[-76, -49; -76, -71], style(color=1));
  connect(V1.p, MPA.g) annotation (points=[-76, -27; -76, 4; -2, 4; -2, 48;
        2.46154, 48], style(color=1));
  connect(MNA.s, Ground1.p)
    annotation (points=[15, -65.7; 15, -66; 38, -66; 38, -79], style(color=1));
  connect(V2.n, Ground3.p) annotation (points=[-31, -63.3; -31, -64; -30, -64;
        -30, -69], style(color=1));
  connect(V2.p, MPB.g) annotation (points=[-31, -34.7; -31, -2; 40, -2; 40, 14;
         48.6154, 14], style(color=1));
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.norcmos documentation
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
  annotation (experiment(
      StopTime=2.1e-006,
      Tolerance=1e-003), experimentSetupOutput(events=false));
annotation ( Documentation(info="	<html>
	Please, see SPICELib.tutorial.norcmos documentation
	</HTML>
"));
end TRAN;
