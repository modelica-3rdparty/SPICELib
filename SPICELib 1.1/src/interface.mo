

package INTERFACE

  connector PowerDissipation
    flow SI.Power dissipatedPower "Dissipated power";
    annotation (
      Coordsys(extent=[-1, -1; 1, 1]),
      Documentation(info=""),
      Icon(Rectangle(extent=[0, 0; 0, 0], style(color=8))));
  end PowerDissipation;

  connector Pin
    SI.Voltage vDC "DC potential at the pin";
    SI.Voltage vTran "Transient/Small-signal potential at the pin";
    SI.Voltage vAC_Re "Small-signal potential at the pin. Real part";
    SI.Voltage vAC_Im "Small-signal potential at the pin. Imaginary part";

    flow SI.Current iDC "DC current flowing into the pin";
    flow SI.Current iTran "Transient current flowing into the pin";
    flow SI.Current iAC_Re
      "Small-signal current flowing into the pin. Real part";
    flow SI.Current iAC_Im
      "Small-signal current flowing into the pin. Imaginary part";
    annotation (
      Coordsys(extent=[-1, -1; 1, 1]),
      Documentation(info=""),
      Icon(Rectangle(extent=[-1, -1; 1, 1], style(color=1, fillColor=1))),
      Diagram(Rectangle(extent=[-1, -1; 1, 1], style(color=1, fillColor=1))),
      Terminal(Rectangle(extent=[-1, -1; 1, 1], style(color=1, fillColor=1))));
  end Pin;

  partial model OnePin
    Pin p "(+) node" annotation (extent=[-10, 100; 10, 120]);
  end OnePin;

  partial model TwoPin
    Pin p "(+) node" annotation (extent=[-120, -10; -100, 10]);
    Pin n "(-) node" annotation (extent=[100, -10; 120, 10]);
    annotation (
      Coordsys(extent=[-100, -100; 100, 100]),
      Documentation(info=""),
      Icon(Text(
          extent=[-140, -10; -40, 80],
          string="+",
          style(color=0)), Text(
          extent=[40, -10; 140, 80],
          string="-",
          style(color=0))));
  end TwoPin;

  partial model MOSFET
    Pin d "Drain" annotation (extent=[-10, 100; 10, 120]);
    Pin s "Source" annotation (extent=[-10, -120; 10, -100]);
    Pin g "Gate" annotation (extent=[-150, -10; -130, 10]);
    Pin b "Bulk" annotation (extent=[130, -10; 150, 10]);
  end MOSFET;

  partial model OnePort
    extends TwoPin;
  protected
    SI.Voltage vDC "DC voltage between pines";
    SI.Voltage vTran "Transient voltage between pines";
    SI.Voltage vAC_Re "Real part of AC small-signal voltage between pines";
    SI.Voltage vAC_Im "Imaginary part of AC small-signal voltage between pines"
      ;
    SI.Current iDC "DC current";
    SI.Current iTran "Transient/Small-signal current";
    SI.Current iAC_Re "Small-signal current. Real part";
    SI.Current iAC_Im "Small-signal current. Imaginary part";
  equation
    // i, v sign criterion: Positive current flows from
    // the (+) node through the part to the (-) node
    {iDC,iTran,iAC_Re,iAC_Im} = {p.iDC,p.iTran,p.iAC_Re,p.iAC_Im};
    {iDC,iTran,iAC_Re,iAC_Im} = -{n.iDC,n.iTran,n.iAC_Re,n.iAC_Im};
    {vDC,vTran,vAC_Re,vAC_Im} = {p.vDC,p.vTran,p.vAC_Re,p.vAC_Im} - {n.vDC,n.
      vTran,n.vAC_Re,n.vAC_Im};
  end OnePort;

  partial model TwoPort
  protected
    SI.Voltage vDC1 "DC Voltage drop over the left port";
    SI.Voltage vTran1 "Transient voltage drop over the left port";
    SI.Voltage vAC_Re1
      "Real part of AC small-signal voltage drop over the left port";
    SI.Voltage vAC_Im1
      "Imaginary part of AC small-signal voltage drop over the left port";
    SI.Current iDC1 "DC current flowing from pos. to neg. pin of the left port"
      ;
    SI.Current iTran1
      "Transient/Small-signal current flowing from pos. to neg. pin of the left port"
      ;
    SI.Current iAC_Re1
      "Small-signal current flowing from pos. to neg. pin of the left port. Real part"
      ;
    SI.Current iAC_Im1
      "Small-signal current flowing from pos. to neg. pin of the left port. Imaginary part"
      ;

    SI.Voltage vDC2 "DC Voltage drop over the right port";
    SI.Voltage vTran2 "Transient voltage drop over the right port";
    SI.Voltage vAC_Re2
      "Real part of AC small-signal voltage drop over the right port";
    SI.Voltage vAC_Im2
      "Imaginary part of AC small-signal voltage drop over the right port";
    SI.Current iDC2
      "DC current flowing from pos. to neg. pin of the right port";
    SI.Current iTran2
      "Transient/Small-signal current flowing from pos. to neg. pin of the right port"
      ;
    SI.Current iAC_Re2
      "Small-signal current flowing from pos. to neg. pin of the right port. Real part"
      ;
    SI.Current iAC_Im2
      "Small-signal current flowing from pos. to neg. pin of the right port. Imaginary part"
      ;
  public
    Pin p1 "Positive pin of the left port" annotation (extent=[-100, 50; -80,
          70], color=3);
    Pin n1 "Negative pin of the left port" annotation (extent=[-100, -50; -80,
          -30], color=3);
    Pin p2 "Positive pin of the right port" annotation (extent=[100, 50; 120,
          70]);
    Pin n2 "Negative pin of the right port" annotation (extent=[100, -50; 120,
          -30]);
  equation
    // i, v sign criterion: Positive current flows from
    // the (+) node through the part to the (-) node
    {iDC1,iTran1,iAC_Re1,iAC_Im1} = {p1.iDC,p1.iTran,p1.iAC_Re,p1.iAC_Im};
    {iDC1,iTran1,iAC_Re1,iAC_Im1} = -{n1.iDC,n1.iTran,n1.iAC_Re,n1.iAC_Im};
    {vDC1,vTran1,vAC_Re1,vAC_Im1} = {p1.vDC,p1.vTran,p1.vAC_Re,p1.vAC_Im} - {n1
      .vDC,n1.vTran,n1.vAC_Re,n1.vAC_Im};

    {iDC2,iTran2,iAC_Re2,iAC_Im2} = {p2.iDC,p2.iTran,p2.iAC_Re,p2.iAC_Im};
    {iDC2,iTran2,iAC_Re2,iAC_Im2} = -{n2.iDC,n2.iTran,n2.iAC_Re,n2.iAC_Im};
    {vDC2,vTran2,vAC_Re2,vAC_Im2} = {p2.vDC,p2.vTran,p2.vAC_Re,p2.vAC_Im} - {n2
      .vDC,n2.vTran,n2.vAC_Re,n2.vAC_Im};
    annotation (Diagram(
        Line(points=[-80, 88; -80, 72; -80, 80; -90, 80; -70, 80]),
        Line(points=[100, 88; 100, 72; 100, 80; 90, 80; 110, 80]),
        Line(points=[-90, -20; -70, -20]),
        Line(points=[90, -20; 110, -20; 108, -20])), Icon(
        Line(points=[-80, 88; -80, 72; -80, 80; -90, 80; -70, 80]),
        Line(points=[100, 88; 100, 72; 100, 80; 90, 80; 110, 80]),
        Line(points=[-90, -20; -70, -20]),
        Line(points=[90, -20; 110, -20; 108, -20])));
  end TwoPort;
  annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71,
            thickness=2)), Text(
        extent=[-76, 18; 76, -20],
        style(thickness=2),
        string="INTERFACE")));
end INTERFACE;
