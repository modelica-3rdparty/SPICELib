package tutorial "SPICELib tutorial"


annotation (
  Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1),
  Documentation(info="<html>

<H1 align=center><i>SPICE</i>Lib tutorial</H1>

<b>tutorial</b> package contains some examples illustrating the capabilities
of <i>SPICE</i>Lib for circuit modeling & analysis.

Each subpackage of <i>tutorial</i> contains an example. See these subpackages
documentation.

</HTML>"));
  annotation (Icon(Rectangle(extent=[-80, 60; 80, -60],style(color=43, thickness=2)), Text
      (extent=[-70, 30; 80, -24], string="tutorial")));
end tutorial;
