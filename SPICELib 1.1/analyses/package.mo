package analyses "Types of analyses supported by SPICELib"


annotation (
  Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1),
  Documentation(info="<html>

<H1 align=center>Performing Circuit Analyses</H1><br><br>



<p>Analysis types supported by <i>SPICE</i>Lib are shown in Table 1.
Each analysis type is described in the corresponding class documentation.</p><br>

<b>Table 1.</b> <i>SPICE</i>Lib analyses summary.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TH align=center><b>Package</b></TH>
<TH align=center><b>Model</b></TH>
<TH align=center><b>Analysis type</b></TH></TR>

<TR><TD WIDTH=40>analyses</TD>
<TD WIDTH=40>OP</TD>
<TD>Bias point calculation.</TD></TR>

<TR><TD WIDTH=40>analyses</TD>
<TD WIDTH=40>AC</TD>
<TD>AC sweep.</TD></TR>

<TR><TD WIDTH=40>analyses</TD>
<TD WIDTH=40>TRAN</TD>
<TD>Transient (time) analysis.</TD></TR>
</TABLE><br><br>

<H2>Global parameters</H2><br>

The value of two global parameters has to be defined (see Table 2).<br><br>

<b>Table 2.</b> Global parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TD><b>TimeScale</b></TD>
<TD>It is intended for providing an (rough) approximate
value of the circuit time-constant.</TD></TR>

<TR><TD><b>LogResults</b></TD>
<TD>It determines the amount of information to be logged during the
bias point calculation and the AC small-signal analysis.</TD></TR>
</TABLE><br><br>


<H2>Log of analysis results</H2><br>
<i>SPICE</i>Lib logs the analysis results to the <i>dslog.txt</i> file (using Dymola's
<i>LogVariable</i> function). Two parameters control this information log
(see Table 3 and 4).<br><br>


<b>Table 3.</b> Parameters controlling the results log.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TD><b>LogResults</b></TD>
<TD>Global parameter.</TD></TR>

<TR><TD><b>HIDDEN_COMPONENT</b></TD>
<TD>Device-dependent parameter</TD></TR>
</TABLE><br><br>

<b>Table 4.</b> LogResults values producing the variable
log as a function of HIDDEN_COMPONENT value.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TD><b> </b></TD>
<TD>HIDDEN_COMPONENT = false</TD>
<TD>HIDDEN_COMPONENT = true</TD></TR>

<TR><TD><b>Voltage at resistor pines</b></TD>
<TD>0, 1, 2</TD>
<TD>2</TD></TR>

<TR><TD><b>Current through independent voltage sources</b></TD>
<TD>0, 1, 2</TD>
<TD>2</TD></TR>

<TR><TD><b>Total power dissipation</b></TD>
<TD>0, 1, 2</TD>
<TD>2</TD></TR>

<TR><TD><b>Voltage drop at resistors</b></TD>
<TD>1, 2</TD>
<TD>2</TD></TR>

<TR><TD><b>Current through resistors</b></TD>
<TD>1, 2</TD>
<TD>2</TD></TR>

<TR><TD><b>Power dissipation at each independent voltage source</b></TD>
<TD>1, 2</TD>
<TD>2</TD></TR>

</TABLE><br><br>

The complex AC small-signal voltages and currents are logged in Cartesian
and polar coordinates. In addition, the polar magnitude is also expressed
in decibels (defined as 20*log10( )).<br><br>

<H2>Setting the Stop Time</H2><br>
<i>SPICE</i>Lib analysis models force the simulation end when they have completed their
operations. Large simulation times should be selected in the modeling environment
experiment definition (for example, \"Simulation/Setup/Stop time\" in Dymola)
to avoid interfering with analysis execution.

</HTML>
"),
  Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=43, thickness=2)), Text
      (
      extent=[-76, 44; 72, -38],
      string="analyses",
      style(gradient=2))));
end analyses;
