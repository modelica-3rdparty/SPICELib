package parts "Types of devices supported by SPICELib"


annotation (
  Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1),
  Documentation(info="<html>

<H1 align=center>Device Models</H1><BR><BR>


<H2 align=left>Device types</H2>

<p>The following summary table lists all the device types supported by <i>SPICE</i>Lib.
Each device type is described in detail in the model documentation.</p><br>

<b>Table 1.</b> Analog device summary.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TH align=center><b>Package</b></TH>
<TH align=center><b>Model</b></TH>
<TH align=center><b>Device type</b></TH></TR>

<TR><TD WIDTH=40>parts</TD>
<TD WIDTH=40>Pin</TD>
<TD>Electric connector</TD></TR>

<TR><TD WIDTH=40>parts.breakout</TD>
<TD WIDTH=40>Ground</TD>
<TD>'0' ground</TD></TR>

<TR><TD WIDTH=40>parts.breakout</TD>
<TD WIDTH=40>Rbreak</TD>
<TD>Resistor</TD></TR>

<TR><TD WIDTH=40>parts.breakout</TD>
<TD WIDTH=40>Cbreak</TD>
<TD>Capacitor</TD></TR>

<TR><TD WIDTH=40>parts.breakout</TD>
<TD WIDTH=40>Lbreak</TD>
<TD>Inductor</TD></TR>

<TR><TD WIDTH=40>parts.breakout</TD>
<TD WIDTH=40>PSPICE_diode</TD>
<TD>SPICE2 pspice DIODE</TD></TR>

<TR><TD WIDTH=40>parts.breakout</TD>
<TD WIDTH=40>Spice2MOS1</TD>
<TD>SPICE2 level1 n-channel MOSFET</TD></TR>

<TR><TD WIDTH=40>parts.breakout</TD>
<TD WIDTH=40>Spice2MOS1P</TD>
<TD>SPICE2 level1 p-channel MOSFET</TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>V</TD>
<TD>Independent voltage source </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>VEXP</TD>
<TD>Independent voltage source & EXP stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>VPULSE</TD>
<TD>Independent voltage source & PULSE stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>VPWL</TD>
<TD>Independent voltage source & PWL stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>VSIN</TD>
<TD>Independent voltage source & SIN stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>VCONST</TD>
<TD>Independent voltage source & CONST stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>I</TD>
<TD>Independent current source </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>IEXP</TD>
<TD>Independent current source & EXP stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>IPULSE</TD>
<TD>Independent current source & PULSE stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>IPWL</TD>
<TD>Independent current source & PWL stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>ISIN</TD>
<TD>Independent current source & SIN stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>ICONST</TD>
<TD>Independent current source & CONST stimulus </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>E</TD>
<TD>Linear Voltage-Controlled Current Source</TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>F</TD>
<TD>Linear Current-Controlled Current Source </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>G</TD>
<TD>Linear Voltage-Controlled Current Source </TD></TR>

<TR><TD WIDTH=40>parts.source</TD>
<TD WIDTH=40>H</TD>
<TD>Linear Current-Controlled Voltage Source </TD></TR>

</TABLE><br><br>

Device models are composed of three formulations:
<ul><li>static,
<li>AC small-signal, and
<li>large-signal.</ul>
Each model formulation is described by its own set of equations and
variables.


<H2 align=left>Setting initial conditions</H2>

Two procedures are provided by <i>SPICE</i>Lib to specify the
initial conditions:
<ul><li>the <b>IC symbols</b> (see Table 2), and
<li>the <b>IC property</b> of capacitors and inductors. </ul>
The IC property allows the user to associate the initial condition with a device,
while the IC1 and IC2 pseudocomponents allow the association to be with a node or node
pair.<br><br>



<b>Table 2.</b> Pseudocomponents that specify initial conditions.<br>
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TH align=center><b>Package</b></TH>
<TH align=center><b>Model</b></TH>
<TH align=center><b>Device type</b></TH></TR>
<TR><TD>parts.special</TD>
<TD>IC1</TD>
<TD>A one-pin symbol that allows you to set the initial condition on a net
for both small-signal and transient bias points.</TD></TR>
<TR><TD>parts.special</TD>
<TD>IC2</TD>
<TD>A two-pin symbol that allows you to set initial condition between two nets.</TD></TR>
</TABLE><br>


</HTML>
"),
  Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=43, thickness=2)), Text
      (extent=[-70, 30; 80, -24], string="parts")));
end parts;
