within SPICELib.analyses;

model OP
   extends src.ANALYSES.OP;

annotation (
  Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1),
  Documentation(info="<html>

<H2 align=center>OP - Bias point calculation</H2><br><br>
To calculate the DC response of an analog circuit,
<i>SPICE</i>Lib removes time from the circuit.
This is done by treating all capacitors as open circuits,
all inductors as shorts, and using only the DC values of voltage
and current sources.<br><br>

The bias point is calculated for any analysis.
However, additional information is reported when the Bias Point
analysis is made. The following information is reported to
the <i>dslog.txt</i> file:
<ul><li>a list of all analog node voltages
<li>the currents of all voltage sources and their total power
<li>a list of small-signal parameters for all devices</ul>

Bias point calculation is the most problematic step from the numerical
point of view. The nonlinear equations which describe the circuit's
static behavior must be solved.
<i>SPICE</i>Lib provides four alterative algorithms for solving the circuit
static model (see Table 1). The SOLVE_STATIC parameter determines which
of the four algorithms to use.<br><br>

<b>Table 1.</b> Algorithms for solving the circuit static model.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD>SOLVE_STATIC=0</TD>
<TD><b>Static model iteration</b><br>
The solution of the circuit static model is left in hands of the modeling
environment (for instance, Dymola). <br><i>SPICE</i>Lib has two symbols to provide
an initial guess for Newton-Raphson algorithm: NODESET1 and NODESET2.
</TD></TR>

<TR><TD>SOLVE_STATIC=1</TD>
<TD><b>Static model ramping</b><br>
The static value of the independent sources is ramped by
<i>SPICE</i>Lib from zero up to their target values.
The clamping voltages of the IC symbols and the capacitor IC
property are also adequately ramped.
The value of the parameter TIME_SCALE determines the time length
of the ramping.  </TD></TR>

<TR><TD>SOLVE_STATIC=2</TD>
<TD><b>GMIN stepping</b><br>
GMIN stepping attemps to find a solution for the static model
(with power supplies at 100%) by starting with a large value of
GMIN, initially 1e10 times the nominal value.
If a solution is found at this setting, <i>SPICE</i>Lib reduces
GMIN by a factor of 10 and tries again. This continues until either
GMIN is back to the nominal value, or a repeating cycle fails to converge.
</TD></TR>

<TR><TD>SOLVE_STATIC=3</TD>
<TD><b>Dynamic model ramping</b><br>
The initial condition to iterate the static model is obtained by simulating
the large-signal model. A transient analysis is performed: all sources are ramped
up from zero to the desired initial value and this value is held
for some time to allow the circuit to stabilise. Then, the
voltage values calculated from this transient analysis are used as initial
conditions for solving the static model.
</TD></TR>
</TABLE>

<br><br><b>Note:</b><br>
The algorithms <i>static model iteration</i>,
<i>static model ramping</i>, and
<i>GMIN stepping</i> are supported by PSpice.
PSpice first tries to solve the static model of the circuit using the
Newton-Raphson algorithm. If a solution is not found and <i>GMIN
stepping</i> is enabled, then <i>GMIN algorithm</i> is applied. If it also
fails or it is not enabled, then <i>\"static model ramping\"</i> is
applied.<br>

The algorithm <i>dynamic model ramping</i> is proposed in
\"Cellier F.E. (1991): <i>Continuous System Modeling</i>. Springer-Verlag\".<br>


</HTML>
"),
Icon(
      Rectangle(extent=[-90, -50; 60, 35], style(thickness= 2, color=3)),
      Line(points=[-90, 35;  -60, 50],style(thickness=2, color=3)),
      Line(points=[60, 35;  90, 50],style(thickness=2, color=3)),
      Line(points=[-60, 50;  90, 50],style(thickness=2, color=3)),
      Line(points=[90, -35;  90, 50],style(thickness=2, color=3)),
      Line(points=[60, -50;  90, -35],style(thickness=2, color=3)),
      Text(extent=[-90, -50; 60, 35],    string=".OP",style(color=1))
      ));
end OP;

model AC
  extends src.ANALYSES.AC;

annotation (
  Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1),
  Documentation(info="<html>

<H2 align=center>AC sweep - Frequency response of the circuit</H2><br>

AC sweep is a frequency response analysis. <i>SPICE</i>Lib calculates
the small-signal response of the circuit to a combination of inputs
by transforming it around the bias point and treating it as a linear
circuit.
<ul><li>Nonlinear devices are transformed to linear circuits about
their bias point value before <i>SPICE</i>Lib runs the linear
(small-signal) analysis.
<li>Because AC sweep analysis is a linear analysis, it only considers
the gain and the phase response of the circuit; it does not limit voltages
or currents.</ul>

The best way to use AC sweep analysis is to set the source magnitude to one.
This way, the measured output equals the gain, relative to the input source,
at that output.<br><br>

<b>Setting up an AC analysis</b><br><br>
To run an AC sweep analysis, you need to place and connect one or more
independent sources and then set the AC magnitude and phase for each source.
Each independent source in your circuit contains its own AC specification
for magnitude and phase.<br><br>

The parameters defining the frequency sweep are shown in Table 1.<br><br>

<b>Table 1.</b> Parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD>TYPE_AC_SWEEP</TD>
<TD>It defines the frequency sweep type:<br>
<ul><li>TYPE_AC_SWEEP=0   -   Linear.
    <li>TYPE_AC_SWEEP=1   -   Logarithmically by decades.</ul>
</TD></TR>
<TR><TD>POINTS_NUMBER</TD>
<TD>Number of sweep points:<br>
<ul><li>TYPE_AC_SWEEP=0   -   Total number of points.
    <li>TYPE_AC_SWEEP=1   -   Total number of points per decade.</ul>
</TD></TR>
<TR><TD>START_FREQUENCY</TD>
<TD>Starting frequency for the sweep.
</TD></TR>
<TR><TD>END_FREQUENCY</TD>
<TD>Ending frequency for the sweep.
</TD></TR>
</TABLE>

</HTML>
"),
Icon(
      Rectangle(extent=[-90, -50; 60, 35], style(thickness= 2, color=3)),
      Line(points=[-90, 35;  -60, 50],style(thickness=2, color=3)),
      Line(points=[60, 35;  90, 50],style(thickness=2, color=3)),
      Line(points=[-60, 50;  90, 50],style(thickness=2, color=3)),
      Line(points=[90, -35;  90, 50],style(thickness=2, color=3)),
      Line(points=[60, -50;  90, -35],style(thickness=2, color=3)),
      Text(extent=[-90, -50; 60, 35],    string=".AC",style(color=1))
      ));

end AC;

model TRAN
  extends src.ANALYSES.TRAN;

annotation (
  Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1),
  Documentation(info="<html>

<H2 align=center>TRAN - Transient analysis</H2><br>

The Transient response analysis causes the response of the circuit
to be calculated from <b>TIME</b>=0 to a specified time (see the
note below). During a transient analysis, any or all of the independent
sources may have time-varying values.<br><br>

The parameters defining the transient analysis are shown in Table 1.<br><br>

<b>Table 1.</br> Parameters
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TD><b>TSTOP</b></TD>
<TD>Length of the transient simulation.</TD></TR>
<TR><TD><b>SKIPBP</b></TD>
<TD><b>SKIPBP=false</b><br>
The transient analysis does its own calculation of a bias point to start
with, using the same technique as described for Bias Point. This is necessary
because the initial values of the sources can be different from their DC
values.<br>
Two equivalent procedures are provided to specify the analysis initial
conditions: the IC symbols and the IC property.<br><br>

<b>SKIPBP=true</b><br>
The bias point calculation is skipped and the simulation proceeds directly
with transient analysis at TIME=0.
The large-signal circuit state is initialised to the IC-property corresponding
values.
Devices with IC property defined start
with the specified voltage or current value; however, all other such devices
have an initial voltage or current of zero. <i>IC symbols are ignored</i>.
</TD></TR>


</TABLE>

<br><br><H3>Simulation time during transient analysis</H3>
When the transient simulation is started, the value of Modelica
variable <i>time</i> is different from zero. For this reason, a
variable is defined to measure the transient simulation time:
<b>TIME</b>.

</HTML>
"),
Icon(
      Rectangle(extent=[-90, -50; 60, 35], style(thickness= 2, color=3)),
      Line(points=[-90, 35;  -60, 50],style(thickness=2, color=3)),
      Line(points=[60, 35;  90, 50],style(thickness=2, color=3)),
      Line(points=[-60, 50;  90, 50],style(thickness=2, color=3)),
      Line(points=[90, -35;  90, 50],style(thickness=2, color=3)),
      Line(points=[60, -50;  90, -35],style(thickness=2, color=3)),
      Text(extent=[-90, -50; 60, 35],    string=".TRAN",style(color=1))
      ));

end TRAN;


