

model Pin
  extends src.INTERFACE.Pin;

  annotation (Window(
      x=0.03,
      y=0.02,
      width=0.24,
      height=0.45,
      library=1,
      autolayout=1), Documentation(info="<html>

<H1 align=center><i>Pin</i> connector</H1>

<IMG SRC=Fig.SPICELib.parts.Pin.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Pin.<br><br>

Device models are composed of three formulations: <ul><li>static,
<li>AC small-signal, and <li>large-signal.</ul>
Each model formulation is described by its own set of equations and
variables.<br><br>
Pin model is conceived to allow the simultaneous connection of the
three formulation terminal variables.
The connector variables are shown in Table 1.<br><br>
AC small-signal currents and voltages (complex numbers)
are represented in rectangular coordinates (i.e, real and imaginary).<br><br>


<b>Table 1.</b> <i>Pin</i> connector variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD align=center> </TD>
<TD align=center><b>DC</b></TD>
<TD align=center><b>AC</b></TD>
<TD align=center><b>TRAN</b></TD></TR>

<TR><TD align=center><b>Voltage (across)</b></TD>
<TD align=center>vDC</TD>
<TD align=center>vAC_Re ,  vAC_Im</TD>
<TD align=center>vTran</TD></TR>

<TR><TD align=center><b>Current (through)</b></TD>
<TD align=center>iDC</TD>
<TD align=center>iAC_Re ,  iAC_Im</TD>
<TD align=center>iTran</TD></TR>
</TABLE><br><br>

<b>Sign convention:</b> the current is positive when flows into the pin.
<br><br>

</HTML>
"));
end Pin;


package breakout

  model Ground
    extends src.BREAKOUT.Ground;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>Ground</i> model</H1>

<IMG SRC=Fig.SPICELib.parts.breakout.Ground.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Ground.<br><br>

<H2>Node</H2><br>

<b>Table 1.</b> Instantiation of <i>Pin</i> class
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD>Comment</TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
</TABLE><br><br>

<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<H2>Parameters</H2><br>
None.<br><br>

<H2>Variables of interest to the library user</H2><br>
None.<br><br>

<H2>Constitutive relations</H2><br>
<b>Table 3.</b> Model formulations.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Static</b></TD>
<TD>p.vDC=0</TD></TR>
<TR><TD><b>AC small-signal</b></TD>
<TD>p.vAC_Re=0<br>p.vAC_Im=0</TD></TR>
<TR><TD><b>Large signal</b></TD>
<TD>p.vTran=0</TD></TR>
</TABLE><br><br>

</HTML>
"));
  end Ground;

  model Rbreak
    extends src.BREAKOUT.Rbreak;

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>Rbreak</i> - Linear resistor</H1>

<IMG SRC=Fig.SPICELib.parts.breakout.Rbreak.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Resistor.<br><br>

<H2>Nodes</H2><br>

<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>

(+) and (-) nodes define the polarity when the resistor has a
positive voltage across it. The voltage across the component
is therefore defined as the (+) node voltage minus the
(-) node voltage.<br><br>
Positive current flows from the (+) node through the resistor
to the (-) node.<br><br>

<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

<TR><TD>pinP_vAC_mag</TD>
<TD>AC small-signal voltage. Magnitude.</TD></TR>

<TR><TD>pinP_vAC_mag_dB</TD>
<TD>AC small-signal voltage. Magnitude (dB).</TD></TR>

<TR><TD>pinP_vAC_phase</TD>
<TD>AC small-signal voltage. Phase (deg).</TD></TR>
</TABLE><br><br>

<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

<TR><TD>pinN_vAC_mag</TD>
<TD>AC small-signal voltage. Magnitude.</TD></TR>

<TR><TD>pinN_vAC_mag_dB</TD>
<TD>AC small-signal voltage. Magnitude (dB).</TD></TR>

<TR><TD>pinN_vAC_phase</TD>
<TD>AC small-signal voltage. Phase (deg).</TD></TR>
</TABLE><br><br>


<H2>Parameters</H2><br>

<b>Table 4.</b> Resistor parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Default</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>R</TD>
<TD>SI.Resistance</TD>
<TD>1000</TD>
<TD>Resistance value</TD></TR>
<TR><TD>HIDDEN_COMPONENT</TD>
<TD>Boolean</TD>
<TD>false</TD>
<TD>See <i>analyses</i> package documentation.</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>


<b>Table 5.</b> Voltage across the resistor.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

<TR><TD>vAC_mag</TD>
<TD>AC small-signal voltage. Magnitude.</TD></TR>

<TR><TD>vAC_mag_dB</TD>
<TD>AC small-signal voltage. Magnitude (dB).</TD></TR>

<TR><TD>vAC_phase</TD>
<TD>AC small-signal voltage. Phase (deg).</TD></TR>
</TABLE><br><br>

<b>Table 6.</b> Current flowing through the resistor.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>

<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>

<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>

<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>

<TR><TD>iAC_mag</TD>
<TD>AC small-signal current. Magnitude.</TD></TR>

<TR><TD>iAC_mag_dB</TD>
<TD>Small-signal current. Magnitude (dB).</TD></TR>

<TR><TD>iAC_phase</TD>
<TD>Small-signal current. Phase (deg).</TD></TR>

</TABLE><br><br>

<H2>Constitutive relations</H2><br>
<b>Table 7.</b> Model formulations.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Static</b></TD>
<TD>vDC = R * iDC</TD></TR>
<TR><TD><b>AC small-signal</b></TD>
<TD>vAC_Re  = R * iAC_Re<br>
vAC_Im = R * iAC_Im</TD></TR>
<TR><TD><b>Large signal</b></TD>
<TD>vTran = R * iTran</TD></TR>
</TABLE><br><br>

</HTML>
"));
  end Rbreak;

  model Cbreak

    extends src.BREAKOUT.Cbreak;

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>Cbreak</i> - Linear capacitor</H1>

<IMG SRC=Fig.SPICELib.parts.breakout.Cbreak.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Capacitor.<br><br>

<H2>Nodes</H2><br>

<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>

(+) and (-) nodes define the polarity when the capacitor has a
positive voltage across it. The voltage across the component
is therefore defined as the (+) node voltage minus the
(-) node voltage.<br><br>
Positive current flows from the (+) node through the capacitor
to the (-) node.<br><br>

<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>


<H2>Parameters</H2><br>

<b>Table 4.</b> Capacitor parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Default</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>C</TD>
<TD>SI.Capacitance</TD>
<TD>1e-9</TD>
<TD>Capacitance value</TD></TR>
<TR><TD>IC</TD>
<TD>SI.Voltage</TD>
<TD>0</TD>
<TD>Initial voltage across the capacitor during the bias point
calculation (see analyses.OP model documentation).<br>
<b>Note:</b> the initial voltage across the capacitor can also be set
by using the IC1 part if the capacitor is connected to ground
or by using the IC2 part for setting the initial conditions
between two nodes (these parts can be found in <i>special</i>
package). </TD></TR>
<TR><TD>IC_ENABLED</TD>
<TD>Boolean</TD>
<TD>false</TD>
<TD>The capacitor parameter IC_ENABLED enables or disables
the IC property. It allows distinguishing between the cases
when IC is intentionally set to zero and those cases when the
IC property is not enabled.</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>


<b>Table 5.</b> Voltage across the capacitor.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 6.</b> Current flowing through the capacitor.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>

<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>

<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>

<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 7.</b> Global variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>freq</TD>
<TD>AC small-signal frequency.</TD></TR>
</TABLE><br><br>

<H2>Constitutive relations</H2><br>
<b>Table 8.</b> Model formulations.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Static</b></TD>
<TD>iDC = 0</TD></TR>
<TR><TD><b>AC small-signal</b></TD>
<TD>vAC_Re =  iAC_Im / 2 * pi * freq * C<br>
vAC_Im = - iAC_Re / 2 * pi * freq * C</TD></TR>
<TR><TD><b>Large signal</b></TD>
<TD>C * der(vTran) = iTran</TD></TR>
</TABLE><br><br>



</HTML>
"));
  end Cbreak;

  model Lbreak

    extends src.BREAKOUT.Lbreak;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>Lbreak</i> - Linear inductor</H1>

<IMG SRC=Fig.SPICELib.parts.breakout.Lbreak.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Inductor.<br><br>

<H2>Nodes</H2><br>

<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>

(+) and (-) nodes define the polarity when the inductor has a
positive voltage across it. The voltage across the component
is therefore defined as the (+) node voltage minus the
(-) node voltage.<br><br>
Positive current flows from the (+) node through the inductor
to the (-) node.<br><br>

<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>


<H2>Parameters</H2><br>

<b>Table 4.</b> Inductor parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Default</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>L</TD>
<TD>SI.Inductance</TD>
<TD>1e-9</TD>
<TD>Inductance value</TD></TR>
<TR><TD>IC</TD>
<TD>SI.Current</TD>
<TD>0</TD>
<TD>Initial current across the inductor during the bias point
calculation (see analyses.OP model documentation).<br>
</TD></TR>
<TR><TD>IC_ENABLED</TD>
<TD>Boolean</TD>
<TD>false</TD>
<TD>The inductor parameter IC_ENABLED enables or disables
the IC property. It allows distinguishing between the cases
when IC is intentionally set to zero and those cases when the
IC property is not enabled.</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>


<b>Table 5.</b> Voltage across the inductor.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 6.</b> Current flowing through the inductor.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>

<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>

<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>

<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 7.</b> Global variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>freq</TD>
<TD>AC small-signal frequency.</TD></TR>
</TABLE><br><br>

<H2>Constitutive relations</H2><br>
<b>Table 8.</b> Model formulations.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Static</b></TD>
<TD>vDC = 0</TD></TR>
<TR><TD><b>AC small-signal</b></TD>
<TD>vAC_Re =  iAC_Im * 2 * pi * freq * L<br>
vAC_Im = - iAC_Re * 2 * pi * freq * L</TD></TR>
<TR><TD><b>Large signal</b></TD>
<TD>L * der(iTran) = vTran</TD></TR>
</TABLE><br><br>



</HTML>
"));
  end Lbreak;

  model PSPICE_diode
    extends src.BREAKOUT.PSPICE_diode;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>PSPICE_diode</i> - Pspice diode</H1>

<IMG SRC=Fig.SPICELib.parts.breakout.PSPICE_diode.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Diode.<br><br>

<H2>Nodes</H2><br>

<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>

(+) and (-) nodes define the polarity when the diode has a
positive voltage across it. The voltage across the component
is therefore defined as the (+) node voltage minus the
(-) node voltage.<br><br>
Positive current flows from the (+) node through the diode
to the (-) node.<br><br>

<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>


<H2>Parameters</H2><br>

<b>Table 4.</b> Diode parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Default<b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>IS</TD>
<TD>SI.Current</TD>
<TD>1e-14</TD>
<TD>Saturation current.<br>
</TD></TR>
<TR><TD>RS</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Ohmic Resistance.</TD></TR>
<TR><TD>N</TD>
<TD>Real</TD>
<TD>1</TD>
<TD>Emission coefficient.</TD></TR>
<TR><TD>TT</TD>
<TD>SI.Time</TD>
<TD>0</TD>
<TD>Transit time.</TD></TR>
<TR><TD>CJ0</TD>
<TD>SI.Capacitance</TD>
<TD>1e-6</TD>
<TD>Zero-bias junction capacitance.</TD></TR>
<TR><TD>VJ</TD>
<TD>SI.Voltage</TD>
<TD>1</TD>
<TD>Junction potential.</TD></TR>
<TR><TD>M</TD>
<TD>Real</TD>
<TD>0.5</TD>
<TD>Grading coefficient.</TD></TR>
<TR><TD>FC</TD>
<TD>Real</TD>
<TD>0.5</TD>
<TD>Coefficient for forward-bias depletion capacitance formula.</TD></TR>
<TR><TD>BV</TD>
<TD>SI.Voltage</TD>
<TD>1e40</TD>
<TD>Reverse breakdown voltage (positive number).</TD></TR>
<TR><TD>IKF</TD>
<TD>SI.Current</TD>
<TD>-1</TD>
<TD>High injection knee current.</TD></TR>
<TR><TD>ISR</TD>
<TD>SI.Current</TD>
<TD>1e-14</TD>
<TD>Recombination current.</TD></TR>
<TR><TD>NR</TD>
<TD>Real</TD>
<TD>1</TD>
<TD>Emission coefficient for ISR.</TD></TR>
<TR><TD>IBV</TD>
<TD>SI.Current</TD>
<TD>1e-3</TD>
<TD>Reverse breakdown current (positive number).</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>


<b>Table 5.</b> Voltage across the diode.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 6.</b> Current flowing through the diode.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>

<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>

<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>

<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 7.</b> Global variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>scaleGMIN</TD>
<TD>Scale factor of the GMIN stepping algorithm for bias point calculation.</TD></TR>
<TR><TD>GMIN</TD>
<TD>Conductance in parallel with the pn junction.</TD></TR>
<TR><TD>freq</TD>
<TD>AC small-signal frequency.</TD></TR>
</TABLE><br><br>

<H2>References</H2><br>
Massobrio, G. and Antognetti, P. (1993): <i>Semiconductor Device Modeling with SPICE.</i>
McGraw-Hill, Inc.<br>
Model's equations can be found in src package documentation.<br><br>

</HTML>
"));
  end PSPICE_diode;

  model Spice2MOS1
    extends src.BREAKOUT.Spice2MOS1;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>Spice2MOS1</i> - SPICE2 Level1 n-channel MOSFET</H1>

<IMG SRC=Fig.SPICELib.parts.breakout.Spice2MOS1.symbol.png WIDTH=150><br>
<b>Figure 1.</b> n-channel MOSFET.<br><br>

<H2>Nodes</H2><br>

<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>d</TD>
<TD>drain node</TD></TR>
<TR><TD>s</TD>
<TD>source node</TD></TR>
<TR><TD>g</TD>
<TD>gate node</TD></TR>
<TR><TD>b</TD>
<TD>bulk node</TD></TR>
</TABLE><br><br>


<b>Table 2.</b> drain node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>d.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>d.vTran</TD>
<TD>Large-signal voltage.</TD></TR>

<TR><TD>d.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>d.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 3.</b> (-) source node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>s.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>s.vTran</TD>
<TD>Large-signal voltage.</TD></TR>

<TR><TD>s.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>s.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 4.</b> (-) gate node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>g.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>g.vTran</TD>
<TD>Large-signal voltage.</TD></TR>

<TR><TD>g.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>g.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 5.</b> (-) bulk node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>b.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>b.vTran</TD>
<TD>Large-signal voltage.</TD></TR>

<TR><TD>b.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>b.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>


<H2>Parameters</H2><br>

<b>Table 6.</b> p-channel MOSFET parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Default</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>AD</TD>
<TD>SI.Area</TD>
<TD>1e-8</TD>
<TD>Drain junction area.</TD></TR>
<TR><TD>AS</TD>
<TD>SI.Area</TD>
<TD>1e-8</TD>
<TD>Source junction area.</TD></TR>
<TR><TD>CGB0</TD>
<TD>Real</TD>
<TD>2e-10</TD>
<TD>Gate-bulk overlap capacitance perimeter (farad/meter).</TD></TR>
<TR><TD>CGD0</TD>
<TD>Real</TD>
<TD>4e-11</TD>
<TD>Gate-drain overlap capacitance perimeter (farad/meter).</TD></TR>
<TR><TD>CGS0</TD>
<TD>Real</TD>
<TD>4e-11</TD>
<TD>Gate-source overlap capacitance perimeter (farad/meter).</TD></TR>
<TR><TD>CJ</TD>
<TD>Real</TD>
<TD>2e-4</TD>
<TD>Capacitance at zero-bias voltage per square meter of area (farad/meter<sup>2</sup>).</TD></TR>
<TR><TD>CJSW</TD>
<TD>Real</TD>
<TD>1e-9</TD>
<TD>Capacitance at zero-bias voltage per meter of perimeter (farad/meter).</TD></TR>
<TR><TD>FC</TD>
<TD>Real</TD>
<TD>0.5</TD>
<TD>Substrate-junction forward-bias coefficient.</TD></TR>
<TR><TD>GAMMA</TD>
<TD>Real</TD>
<TD>0.526</TD>
<TD>Body-effect parameter.</TD></TR>
<TR><TD>IS</TD>
<TD>SI.Current</TD>
<TD>1e-14</TD>
<TD>Reverse saturation current at 300K.</TD></TR>
<TR><TD>KP</TD>
<TD>Real</TD>
<TD>27.6e-6</TD>
<TD>Transconductance parameter (A/V<sup>2</sup>).</TD></TR>
<TR><TD>L</TD>
<TD>SI.Length</TD>
<TD>100e-6</TD>
<TD>Gate length.</TD></TR>
<TR><TD>LAMBDA</TD>
<TD>Real</TD>
<TD>0</TD>
<TD>Channel length modulation (V<sup>-1</sup>).</TD></TR>
<TR><TD>LD</TD>
<TD>SI.Length</TD>
<TD>0.8e-6</TD>
<TD>Lateral diffusion.</TD></TR>
<TR><TD>MJ</TD>
<TD>Real</TD>
<TD>0.5</TD>
<TD>Bulk junction capacitance grading coefficient.</TD></TR>
<TR><TD>MJSW</TD>
<TD>Real</TD>
<TD>0.33</TD>
<TD>Perimeter capacitance grading coefficient.</TD></TR>
<TR><TD>PB</TD>
<TD>SI.Voltage</TD>
<TD>0.75</TD>
<TD>Surface inversion potential.</TD></TR>
<TR><TD>PD</TD>
<TD>SI.Length</TD>
<TD>4e-4</TD>
<TD>Drain junction perimeter.</TD></TR>
<TR><TD>PS</TD>
<TD>SI.Length</TD>
<TD>4e-4</TD>
<TD>Source junction perimeter.</TD></TR>
<TR><TD>RD</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Drain ohmic resistance.</TD></TR>
<TR><TD>RS</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Source ohmic resistance.</TD></TR>
<TR><TD>RB</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Bulk ohmic resistance.</TD></TR>
<TR><TD>RG</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Gate ohmic resistance.</TD></TR>
<TR><TD>TOX</TD>
<TD>SI.Length</TD>
<TD>1e-7</TD>
<TD>Gate oxide thickness.</TD></TR>
<TR><TD>VT0</TD>
<TD>SI.Voltage</TD>
<TD>1</TD>
<TD>Zero-bias threshold voltage.</TD></TR>
<TR><TD>W</TD>
<TD>SI.Length</TD>
<TD>100e-6</TD>
<TD>Gate width.</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>


<b>Table 7.</b> Static Model.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>vthDC</TD>
<TD>Threshold voltage.</TD></TR>

<TR><TD>vdsDC</TD>
<TD>Drain to source voltage.</TD></TR>

<TR><TD>vgsDC</TD>
<TD>Gate to source voltage.</TD></TR>

<TR><TD>vbsDC</TD>
<TD>Bulk to source voltage.</TD></TR>

</TABLE><br><br>

<b>Table 8.</b> Large-signal model.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>vthTran</TD>
<TD>Threshold voltage.</TD></TR>

<TR><TD>vdsTran</TD>
<TD>Drain to source voltage.</TD></TR>

<TR><TD>vgsTran</TD>
<TD>Gate to source voltage.</TD></TR>

<TR><TD>vbsTran</TD>
<TD>Bulk to source voltage.</TD></TR>
</TABLE><br><br>

<b>Table 9.</b> Small-signal model.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>gate_vAC_Re</TD>
<TD>Gate voltage. Real part.</TD></TR>

<TR><TD>gate_vAC_Im</TD>
<TD>Gate voltage. Imaginary part.</TD></TR>

<TR><TD>bulk_vAC_Re</TD>
<TD>Bulk voltage. Real part.</TD></TR>

<TR><TD>bulk_vAC_Im</TD>
<TD>Bulk voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 10.</b> Global variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>scaleGMIN</TD>
<TD>Scale factor of the GMIN stepping algorithm for bias point calculation.</TD></TR>
<TR><TD>GMIN</TD>
<TD>Conductance in parallel with the pn junction.</TD></TR>
<TR><TD>freq</TD>
<TD>AC small-signal frequency.</TD></TR>
<TR><TD>Temp</TD>
<TD>Temperature.</TD></TR>
</TABLE><br><br>

<H2>References</H2><br>
Massobrio, G. and Antognetti, P. (1993): <i>Semiconductor Device Modeling with SPICE.</i>
McGraw-Hill, Inc.<br>
Model's equations can be found in src package documentation.<br><br>

</HTML>
"));
  end Spice2MOS1;

  model Spice2MOS1P
    extends src.BREAKOUT.Spice2MOS1P;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>Spice2MOS1P</i> - SPICE2 Level1 p-channel MOSFET</H1>

<IMG SRC=Fig.SPICELib.parts.breakout.Spice2MOS1P.symbol.png WIDTH=150><br>
<b>Figure 1.</b> p-channel MOSFET.<br><br>

<H2>Nodes</H2><br>

<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>d</TD>
<TD>drain node</TD></TR>
<TR><TD>s</TD>
<TD>source node</TD></TR>
<TR><TD>g</TD>
<TD>gate node</TD></TR>
<TR><TD>b</TD>
<TD>bulk node</TD></TR>
</TABLE><br><br>


<b>Table 2.</b> drain node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>d.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>d.vTran</TD>
<TD>Large-signal voltage.</TD></TR>

<TR><TD>d.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>d.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 3.</b> (-) source node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>s.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>s.vTran</TD>
<TD>Large-signal voltage.</TD></TR>

<TR><TD>s.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>s.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 4.</b> (-) gate node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>g.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>g.vTran</TD>
<TD>Large-signal voltage.</TD></TR>

<TR><TD>g.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>g.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 5.</b> (-) bulk node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>b.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>b.vTran</TD>
<TD>Large-signal voltage.</TD></TR>

<TR><TD>b.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>b.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>


<H2>Parameters</H2><br>

<b>Table 6.</b> p-channel MOSFET parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Default</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>AD</TD>
<TD>SI.Area</TD>
<TD>1e-8</TD>
<TD>Drain junction area.</TD></TR>
<TR><TD>AS</TD>
<TD>SI.Area</TD>
<TD>1e-8</TD>
<TD>Source junction area.</TD></TR>
<TR><TD>CGB0</TD>
<TD>Real</TD>
<TD>2e-10</TD>
<TD>Gate-bulk overlap capacitance perimeter (farad/meter).</TD></TR>
<TR><TD>CGD0</TD>
<TD>Real</TD>
<TD>4e-11</TD>
<TD>Gate-drain overlap capacitance perimeter (farad/meter).</TD></TR>
<TR><TD>CGS0</TD>
<TD>Real</TD>
<TD>4e-11</TD>
<TD>Gate-source overlap capacitance perimeter (farad/meter).</TD></TR>
<TR><TD>CJ</TD>
<TD>Real</TD>
<TD>2e-4</TD>
<TD>Capacitance at zero-bias voltage per square meter of area (farad/meter<sup>2</sup>).</TD></TR>
<TR><TD>CJSW</TD>
<TD>Real</TD>
<TD>1e-9</TD>
<TD>Capacitance at zero-bias voltage per meter of perimeter (farad/meter).</TD></TR>
<TR><TD>FC</TD>
<TD>Real</TD>
<TD>0.5</TD>
<TD>Substrate-junction forward-bias coefficient.</TD></TR>
<TR><TD>GAMMA</TD>
<TD>Real</TD>
<TD>0.526</TD>
<TD>Body-effect parameter.</TD></TR>
<TR><TD>IS</TD>
<TD>SI.Current</TD>
<TD>1e-14</TD>
<TD>Reverse saturation current at 300K.</TD></TR>
<TR><TD>KP</TD>
<TD>Real</TD>
<TD>27.6e-6</TD>
<TD>Transconductance parameter (A/V<sup>2</sup>).</TD></TR>
<TR><TD>L</TD>
<TD>SI.Length</TD>
<TD>100e-6</TD>
<TD>Gate length.</TD></TR>
<TR><TD>LAMBDA</TD>
<TD>Real</TD>
<TD>0</TD>
<TD>Channel length modulation (V<sup>-1</sup>).</TD></TR>
<TR><TD>LD</TD>
<TD>SI.Length</TD>
<TD>0.8e-6</TD>
<TD>Lateral diffusion.</TD></TR>
<TR><TD>MJ</TD>
<TD>Real</TD>
<TD>0.5</TD>
<TD>Bulk junction capacitance grading coefficient.</TD></TR>
<TR><TD>MJSW</TD>
<TD>Real</TD>
<TD>0.33</TD>
<TD>Perimeter capacitance grading coefficient.</TD></TR>
<TR><TD>PB</TD>
<TD>SI.Voltage</TD>
<TD>0.75</TD>
<TD>Surface inversion potential.</TD></TR>
<TR><TD>PD</TD>
<TD>SI.Length</TD>
<TD>4e-4</TD>
<TD>Drain junction perimeter.</TD></TR>
<TR><TD>PS</TD>
<TD>SI.Length</TD>
<TD>4e-4</TD>
<TD>Source junction perimeter.</TD></TR>
<TR><TD>RD</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Drain ohmic resistance.</TD></TR>
<TR><TD>RS</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Source ohmic resistance.</TD></TR>
<TR><TD>RB</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Bulk ohmic resistance.</TD></TR>
<TR><TD>RG</TD>
<TD>SI.Resistance</TD>
<TD>10</TD>
<TD>Gate ohmic resistance.</TD></TR>
<TR><TD>TOX</TD>
<TD>SI.Length</TD>
<TD>1e-7</TD>
<TD>Gate oxide thickness.</TD></TR>
<TR><TD>VT0</TD>
<TD>SI.Voltage</TD>
<TD>-1</TD>
<TD>Zero-bias threshold voltage.</TD></TR>
<TR><TD>W</TD>
<TD>SI.Length</TD>
<TD>100e-6</TD>
<TD>Gate width.</TD></TR>
</TABLE><br><br>


<H2>Variables of interest to the library user</H2><br>


<b>Table 7.</b> Static Model.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>vthDC</TD>
<TD>Threshold voltage.</TD></TR>

<TR><TD>vsdDC</TD>
<TD>Source to drain voltage.</TD></TR>

<TR><TD>vsgDC</TD>
<TD>Source to gate voltage.</TD></TR>

<TR><TD>vsbDC</TD>
<TD>Source to bulk voltage.</TD></TR>

</TABLE><br><br>

<b>Table 8.</b> Large-signal model.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>vthTran</TD>
<TD>Threshold voltage.</TD></TR>

<TR><TD>vsdTran</TD>
<TD>Source to drain voltage.</TD></TR>

<TR><TD>vsgTran</TD>
<TD>Source to gate voltage.</TD></TR>

<TR><TD>vsbTran</TD>
<TD>Source to bulk voltage.</TD></TR>
</TABLE><br><br>

<b>Table 9.</b> Small-signal model.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>gate_vAC_Re</TD>
<TD>Gate voltage. Real part.</TD></TR>

<TR><TD>gate_vAC_Im</TD>
<TD>Gate voltage. Imaginary part.</TD></TR>

<TR><TD>bulk_vAC_Re</TD>
<TD>Bulk voltage. Real part.</TD></TR>

<TR><TD>bulk_vAC_Im</TD>
<TD>Bulk voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 10.</b> Global variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>scaleGMIN</TD>
<TD>Scale factor of the GMIN stepping algorithm for bias point calculation.</TD></TR>
<TR><TD>GMIN</TD>
<TD>Conductance in parallel with the pn junction.</TD></TR>
<TR><TD>freq</TD>
<TD>AC small-signal frequency.</TD></TR>
<TR><TD>Temp</TD>
<TD>Temperature.</TD></TR>
</TABLE><br><br>

<H2>References</H2><br>
Massobrio, G. and Antognetti, P. (1993): <i>Semiconductor Device Modeling with SPICE.</i>
McGraw-Hill, Inc.<br>
Model's equations can be found in src package documentation.<br><br>

</HTML>
"));
  end Spice2MOS1P;

  annotation (
    Window(
      x=0.03,
      y=0.02,
      width=0.24,
      height=0.45,
      library=1,
      autolayout=1),
    Documentation(info="<html>

<H1 align=center><i>breakout</i> package</H1><br><br>

<p>The following summary table lists all the device types of <i>breakout</i> package.
Each device type is described in detail in the model documentation.</p><br>

<b>Table 1.</b> <i>breakout</i> package devices.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TH align=center><b>Model</b></TH>
<TH align=center><b>Device type</b></TH></TR>

<TR><TD WIDTH=40>Ground</TD>
<TD>'0' ground</TD></TR>

<TR><TD WIDTH=40>Rbreak</TD>
<TD>Resistor</TD></TR>

<TR><TD WIDTH=40>Cbreak</TD>
<TD>Capacitor</TD></TR>

<TR><TD WIDTH=40>Lbreak</TD>
<TD>Capacitor</TD></TR>

<TR><TD WIDTH=40>PSPICE_diode</TD>
<TD>PSPICE diode</TD></TR>

<TR><TD WIDTH=40>Spice2MOS1</TD>
<TD>SPICE2 level1 n-channel MOSFET</TD></TR>

<TR><TD WIDTH=40>Spice2MOS1P</TD>
<TD>SPICE2 level1 p-channel MOSFET</TD></TR>
</TABLE><br><br>

</HTML>
"),
    Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71, thickness=2)),
        Text(extent=[-86, 26; 88, -20], string="breakout")));

end breakout;


package source

  model V
    parameter SI.Voltage DC_VALUE;
    parameter SI.Voltage AC_MAG;
    extends src.SOURCE.VSource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.NULL);

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>V</i> - Independent voltage source</H1>
<IMG SRC=Fig.SPICELib.parts.source.VSource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Voltage source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent voltage source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
<TR><TD>HIDDEN_COMPONENT</TD>
<TD>Boolean</TD>
<TD>See <i>analyses</i> package documentation.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
<TR><TD>iAC_mag</TD>
<TD>AC small-signal current. Magnitude.</TD></TR>
<TR><TD>iAC_mag_dB</TD>
<TD>Small-signal current. Magnitude (dB).</TD></TR>
<TR><TD>iAC_phase</TD>
<TD>Small-signal current. Phase (deg).</TD></TR>
</TABLE><br><br>
<H2>Stimulus - Transient specification</H2><br>
None.
</HTML>
"));

  end V;

  model VEXP
    parameter SI.Voltage S1 "Initial signal";
    parameter SI.Voltage S2 "Peak signal";
    parameter SI.Time TD1 "Rise (fall) delay";
    parameter SI.Time TC1 "Rise (fall) time constant";
    parameter SI.Time TD2 "Fall (rise) delay";
    parameter SI.Time TC2 "Fall (rise) time constant";
    parameter SI.Voltage DC_VALUE;
    parameter SI.Voltage AC_MAG;
    extends src.SOURCE.VSource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.EXP (
          S1=S1,
          S2=S2,
          TD1=TD1,
          TC1=TC1,
          TD2=TD2,
          TC2=TC2));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>VEXP</i> - Independent voltage source & EXP stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.VSource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Voltage source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent voltage source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
<TR><TD>HIDDEN_COMPONENT</TD>
<TD>Boolean</TD>
<TD>See <i>analyses</i> package documentation.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
<TR><TD>iAC_mag</TD>
<TD>AC small-signal current. Magnitude.</TD></TR>
<TR><TD>iAC_mag_dB</TD>
<TD>Small-signal current. Magnitude (dB).</TD></TR>
<TR><TD>iAC_phase</TD>
<TD>Small-signal current. Phase (deg).</TD></TR>
</TABLE><br><br>
<H2>Stimulus - EXP waveform</H2><br>
The EXP form causes the voltage to be S1 for the first TD1 seconds.
Then the voltage decays exponentially from S1 to S2 using a time
constant of TC1. The decay lasts TD2-TD1 seconds.
Then, the voltage decays from S2 back to S1 using a time constant
of TC2. See Tables 8 and 9.<br><br>
<b>Table 8.</b> EXP waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>S1</TD>
<TD>Initial voltage.</TD>
<TD>SI.Voltage</TD></TR>
<TR><TD>S2</TD>
<TD>Peak voltage.</TD>
<TD>SI.Voltage</TD></TR>
<TR><TD>TD1</TD>
<TD>Rise (fall) delay.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TC1</TD>
<TD>Rise (fall) time constant.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TD2</TD>
<TD>Fall (rise) delay.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TC2</TD>
<TD>Fall (rise) time constant.</TD>
<TD>SI.Time</TD></TR>
</TABLE><br><br>
<b>Table 9.</b> Exponential waveform formulas.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=8>
<TR><TD><b>Time period</b></TD>
<TD><b>Value</b></TD></TR>
<TR><TD>0 to TD1</TD>
<TD>S1</TD></TR>
<TR><TD>TD1 to TD2</TD>
<TD>S1+(S2-S1)*(1-e<sup>-(TIME-TD1)/TC1</sup>)</TD></TR>
<TR><TD>TD2 to TSTOP</TD>
<TD>S1+(S2-S1)*((1-e<sup>-(TIME-TD1)/TC1</sup>)-(1-e<sup>-(TIME-TD2)/TC2</sup>))</TD></TR>
</TABLE><br><br>
</HTML>
"));

  end VEXP;

  model VPULSE
    parameter SI.Voltage S1 "Initial signal";
    parameter SI.Voltage S2 "Pulse signal";
    parameter SI.Time TD(min=0) "Delay";
    parameter SI.Time TF(min=0) "Fall time";
    parameter SI.Time TR(min=0) "Rise time";
    parameter SI.Time PW(min=0) "Pulse width";
    parameter SI.Time PER(min=TR + PW + TF) "Period";
    parameter SI.Voltage DC_VALUE;
    parameter SI.Voltage AC_MAG;
    extends src.SOURCE.VSource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.PULSE (
          S1=S1,
          S2=S2,
          TD=TD,
          TF=TF,
          TR=TR,
          PW=PW,
          PER=PER));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>VPULSE</i> - Independent voltage source & PULSE stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.VSource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Voltage source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent voltage source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
<TR><TD>HIDDEN_COMPONENT</TD>
<TD>Boolean</TD>
<TD>See <i>analyses</i> package documentation.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
<TR><TD>iAC_mag</TD>
<TD>AC small-signal current. Magnitude.</TD></TR>
<TR><TD>iAC_mag_dB</TD>
<TD>Small-signal current. Magnitude (dB).</TD></TR>
<TR><TD>iAC_phase</TD>
<TD>Small-signal current. Phase (deg).</TD></TR>
</TABLE><br><br>
<H2>Stimulus - PULSE waveform</H2><br>
The PULSE form causes the voltage to start at S1, and stay there for TD seconds.
Then, the voltage goes linearly from S1 to S2 during the next TR seconds, and the
the voltage stays at S2 for PW seconds.
Then it goes linearly from S2 back to S1 during the next TF seconds.
It stays at S1 for PER-(TR+PW+TF) seconds, and then the cycle is repeated
except for the initial delay of TD seconds.<br><br>
<b>Table 10.</b> PULSE waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>S1</TD>
<TD>Initial voltage.</TD>
<TD>SI.Voltage</TD></TR>
<TR><TD>S2</TD>
<TD>Pulsed voltage.</TD>
<TD>SI.Voltage</TD></TR>
<TR><TD>TD</TD>
<TD>Delay.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TF</TD>
<TD>Fall time.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TR</TD>
<TD>Rise time.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>PW</TD>
<TD>Pulse width.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>PER</TD>
<TD>Period.</TD>
<TD>SI.Time</TD></TR>
</TABLE><br><br>
<b>Table 11.</b> Pulse waveform formulas.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Time period</b></TD>
<TD><b>Value</b></TD></TR>
<TR><TD>0</TD> <TD>S1</TD></TR>
<TR><TD>TD</TD> <TD>S1</TD></TR>
<TR><TD>TD+TR</TD> <TD>S2</TD></TR>
<TR><TD>TD+TR+PW</TD> <TD>S2</TD></TR>
<TR><TD>TD+TR+PW+TF</TD> <TD>S1</TD></TR>
<TR><TD>TD+PER</TD> <TD>S1</TD></TR>
<TR><TD>TD+PER+TR</TD> <TD>S2</TD></TR>
<TR><TD>...</TD> <TD>...</TD></TR>
</TABLE><br><br>
</HTML>
"));

  end VPULSE;

  model VPWL
    parameter SI.Voltage signalCorners[:] "Signal at corners";
    parameter SI.Time timeCorners[:] "Time at corners";
    parameter Integer N=size(signalCorners, 1) "Number of corner points";
    parameter SI.Voltage DC_VALUE;
    parameter SI.Voltage AC_MAG;
    extends src.SOURCE.VSource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.PWL (
          signalCorners=signalCorners,
          timeCorners=timeCorners,
          N=Nm));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>VPWL</i> - Independent voltage source & PWL stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.VSource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Voltage source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent voltage source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
<TR><TD>HIDDEN_COMPONENT</TD>
<TD>Boolean</TD>
<TD>See <i>analyses</i> package documentation.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
<TR><TD>iAC_mag</TD>
<TD>AC small-signal current. Magnitude.</TD></TR>
<TR><TD>iAC_mag_dB</TD>
<TD>Small-signal current. Magnitude (dB).</TD></TR>
<TR><TD>iAC_phase</TD>
<TD>Small-signal current. Phase (deg).</TD></TR>
</TABLE><br><br>
<H2>Stimulus - PWL waveform</H2><br>
The PWL form describes a piecewise linear waveform.
Each pair of time-voltage values specifies a corner of the waveform.
The voltage at times between corners is the linear interpolation of
the voltages at the corners.<br><br>
<b>Table 12.</b> PWL waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>timeCorners[:]</TD>
<TD>Time at corners.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>signalCorners[:]</TD>
<TD>Voltage at corners.</TD>
<TD>SI.Voltage</TD></TR>
</TABLE><br><br>
</HTML>
"));

  end VPWL;

  model VSIN
    parameter SI.Voltage OFF "Constant Voltage";
    parameter SI.Voltage AMPL "Amplitude";
    parameter SI.Frequency FREQ "Frequency";
    parameter SI.Voltage DC_VALUE;
    parameter SI.Voltage AC_MAG;
    extends src.SOURCE.VSource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.SIN (
          OFF=OFF,
          AMPL=AMPL,
          FREQ=FREQ));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>VSIN</i> - Independent voltage source & SIN stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.VSource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Voltage source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent voltage source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
<TR><TD>HIDDEN_COMPONENT</TD>
<TD>Boolean</TD>
<TD>See <i>analyses</i> package documentation.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
<TR><TD>iAC_mag</TD>
<TD>AC small-signal current. Magnitude.</TD></TR>
<TR><TD>iAC_mag_dB</TD>
<TD>Small-signal current. Magnitude (dB).</TD></TR>
<TR><TD>iAC_phase</TD>
<TD>Small-signal current. Phase (deg).</TD></TR>
</TABLE><br><br>
<H2>Stimulus - SIN waveform</H2><br>
The SIN form causes the voltage to follow v = OFF + AMPL*sin(2*pi*FREQ*time).
See Table 8.<br><br>
<b>Table 8.</b> SIN waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>OFF</TD>
<TD>Constant voltage.</TD>
<TD>SI.Voltage</TD></TR>
<TR><TD>AMPL</TD>
<TD>Amplitude.</TD>
<TD>SI.Voltage</TD></TR>
<TR><TD>FREQ</TD>
<TD>Frequency.</TD>
<TD>SI.Frequency</TD></TR>
</HTML>
"));
  end VSIN;

  model VCONST
    parameter SI.Voltage OFF "Constant Voltage";
    parameter SI.Voltage DC_VALUE;
    parameter SI.Voltage AC_MAG;
    extends src.SOURCE.VSource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.CONST (OFF=OFF));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>VCONST</i> - Independent voltage source & CONST stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.VSource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Voltage source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent voltage source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
<TR><TD>HIDDEN_COMPONENT</TD>
<TD>Boolean</TD>
<TD>See <i>analyses</i> package documentation.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
<TR><TD>iAC_mag</TD>
<TD>AC small-signal current. Magnitude.</TD></TR>
<TR><TD>iAC_mag_dB</TD>
<TD>Small-signal current. Magnitude (dB).</TD></TR>
<TR><TD>iAC_phase</TD>
<TD>Small-signal current. Phase (deg).</TD></TR>
</TABLE><br><br>
<H2>Stimulus - CONST waveform</H2><br>
The CONST form causes the voltage to follow v = OFF.
See Table 8.<br><br>
<b>Table 8.</b> CONST waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>OFF</TD>
<TD>Constant voltage.</TD>
<TD>SI.Voltage</TD></TR>
</HTML>
"));
  end VCONST;

  model I
    parameter SI.Current DC_VALUE;
    parameter SI.Current AC_MAG;
    extends src.SOURCE.ISource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.NULL);

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>I</i> - Independent current source</H1>
<IMG SRC=Fig.SPICELib.parts.source.ISource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Current source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent current source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Stimulus - Transient specification</H2><br>
None.
</HTML>
"));

  end I;

  model IEXP
    parameter SI.Current S1 "Initial signal";
    parameter SI.Current S2 "Peak signal";
    parameter SI.Time TD1 "Rise (fall) delay";
    parameter SI.Time TC1 "Rise (fall) time constant";
    parameter SI.Time TD2 "Fall (rise) delay";
    parameter SI.Time TC2 "Fall (rise) time constant";
    parameter SI.Current DC_VALUE;
    parameter SI.Current AC_MAG;
    extends src.SOURCE.ISource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.EXP (
          S1=S1,
          S2=S2,
          TD1=TD1,
          TC1=TC1,
          TD2=TD2,
          TC2=TC2));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>IEXP</i> - Independent current source & EXP stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.ISource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Current source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent current source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Stimulus - EXP waveform</H2><br>
The EXP form causes the current to be S1 for the first TD1 seconds.
Then the current decays exponentially from S1 to S2 using a time
constant of TC1. The decay lasts TD2-TD1 seconds.
Then, the current decays from S2 back to S1 using a time constant
of TC2. See Tables 8 and 9.<br><br>
<b>Table 8.</b> EXP waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>S1</TD>
<TD>Initial voltage.</TD>
<TD>SI.Current</TD></TR>
<TR><TD>S2</TD>
<TD>Peak voltage.</TD>
<TD>SI.Current</TD></TR>
<TR><TD>TD1</TD>
<TD>Rise (fall) delay.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TC1</TD>
<TD>Rise (fall) time constant.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TD2</TD>
<TD>Fall (rise) delay.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TC2</TD>
<TD>Fall (rise) time constant.</TD>
<TD>SI.Time</TD></TR>
</TABLE><br><br>
<b>Table 9.</b> Exponential waveform formulas.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=8>
<TR><TD><b>Time period</b></TD>
<TD><b>Value</b></TD></TR>
<TR><TD>0 to TD1</TD>
<TD>S1</TD></TR>
<TR><TD>TD1 to TD2</TD>
<TD>S1+(S2-S1)*(1-e<sup>-(TIME-TD1)/TC1</sup>)</TD></TR>
<TR><TD>TD2 to TSTOP</TD>
<TD>S1+(S2-S1)*((1-e<sup>-(TIME-TD1)/TC1</sup>)-(1-e<sup>-(TIME-TD2)/TC2</sup>))</TD></TR>
</TABLE><br><br>
</HTML>
"));

  end IEXP;

  model IPULSE
    parameter SI.Current S1 "Initial signal";
    parameter SI.Current S2 "Pulse signal";
    parameter SI.Time TD(min=0) "Delay";
    parameter SI.Time TF(min=0) "Fall time";
    parameter SI.Time TR(min=0) "Rise time";
    parameter SI.Time PW(min=0) "Pulse width";
    parameter SI.Time PER(min=TR + PW + TF) "Period";
    parameter SI.Current DC_VALUE;
    parameter SI.Current AC_MAG;
    extends src.SOURCE.ISource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.PULSE (
          S1=S1,
          S2=S2,
          TD=TD,
          TF=TF,
          TR=TR,
          PW=PW,
          PER=PER));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>IPULSE</i> - Independent current source & PULSE stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.ISource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Current source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent current source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Stimulus - PULSE waveform</H2><br>
The PULSE form causes the current to start at S1, and stay there for TD seconds.
Then, the current goes linearly from S1 to S2 during the next TR seconds, and the
the current stays at S2 for PW seconds.
Then it goes linearly from S2 back to S1 during the next TF seconds.
It stays at S1 for PER-(TR+PW+TF) seconds, and then the cycle is repeated
except for the initial delay of TD seconds.<br><br>
<b>Table 10.</b> PULSE waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>S1</TD>
<TD>Initial voltage.</TD>
<TD>SI.Current</TD></TR>
<TR><TD>S2</TD>
<TD>Pulsed voltage.</TD>
<TD>SI.Current</TD></TR>
<TR><TD>TD</TD>
<TD>Delay.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TF</TD>
<TD>Fall time.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>TR</TD>
<TD>Rise time.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>PW</TD>
<TD>Pulse width.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>PER</TD>
<TD>Period.</TD>
<TD>SI.Time</TD></TR>
</TABLE><br><br>
<b>Table 11.</b> Pulse waveform formulas.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Time period</b></TD>
<TD><b>Value</b></TD></TR>
<TR><TD>0</TD> <TD>S1</TD></TR>
<TR><TD>TD</TD> <TD>S1</TD></TR>
<TR><TD>TD+TR</TD> <TD>S2</TD></TR>
<TR><TD>TD+TR+PW</TD> <TD>S2</TD></TR>
<TR><TD>TD+TR+PW+TF</TD> <TD>S1</TD></TR>
<TR><TD>TD+PER</TD> <TD>S1</TD></TR>
<TR><TD>TD+PER+TR</TD> <TD>S2</TD></TR>
<TR><TD>...</TD> <TD>...</TD></TR>
</TABLE><br><br>
</HTML>
"));

  end IPULSE;

  model IPWL
    parameter SI.Currrent signalCornersm[:] "Signal at corners";
    parameter SI.Time timeCornersm[:] "Time at corners";
    parameter Integer Nm=size(signalCorners, 1) "Number of corner points";
    parameter SI.Voltage DC_VALUE;
    parameter SI.Voltage AC_MAG;
    extends src.SOURCE.ISource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.PWL (
          signalCorners=signalCorners,
          timeCorners=timeCorners,
          N=N));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>IPWL</i> - Independent current source & PWL stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.ISource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Current source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent current source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Stimulus - PWL waveform</H2><br>
The PWL form describes a piecewise linear waveform.
Each pair of time-current values specifies a corner of the waveform.
The current at times between corners is the linear interpolation of
the currents at the corners.<br><br>
<b>Table 12.</b> PWL waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>timeCorners[:]</TD>
<TD>Time at corners.</TD>
<TD>SI.Time</TD></TR>
<TR><TD>signalCorners[:]</TD>
<TD>Voltage at corners.</TD>
<TD>SI.Current</TD></TR>
</TABLE><br><br>
</HTML>
"));

  end IPWL;

  model ISIN
    parameter SI.Current OFF "DC Voltage";
    parameter SI.Current AMPL "Amplitude";
    parameter SI.Frequency FREQ "Frequency";
    parameter SI.Current DC_VALUE;
    parameter SI.Current AC_MAG;
    extends src.SOURCE.ISource(
      DC_VALUE=DC_VALUE,
      AC_MAG=AC_MAG,
      redeclare model TransientSpecification = src.WAVEFORMS.SIN (
          OFF=OFF,
          AMPL=AMPL,
          FREQ=FREQ));

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>ISIN</i> - Independent current source & SIN stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.ISource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Current source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent current source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Voltage</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Voltage</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Stimulus - SIN waveform</H2><br>
The SIN form causes the voltage to follow v = OFF + AMPL*sin(2*pi*FREQ*time).
See Table 8.<br><br>
<b>Table 8.</b> SIN waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>OFF</TD>
<TD>DC voltage.</TD>
<TD>SI.Voltage</TD></TR>
<TR><TD>AMPL</TD>
<TD>Amplitude.</TD>
<TD>SI.Voltage</TD></TR>
<TR><TD>FREQ</TD>
<TD>Frequency.</TD>
<TD>SI.Frequency</TD></TR>
</HTML>
"));
  end ISIN;

model ICONST
  parameter SI.Current OFF "Constant Current";
  parameter SI.Current DC_VALUE;
  parameter SI.Current AC_MAG;
  extends src.SOURCE.ISource(
    DC_VALUE=DC_VALUE,
    AC_MAG=AC_MAG,
    redeclare model TransientSpecification = src.WAVEFORMS.CONST (OFF=OFF));

  annotation (Window(
      x=0.03,
      y=0.02,
      width=0.24,
      height=0.45,
      library=1,
      autolayout=1), Documentation(info="<html>
<H1 align=center><i>ICONST</i> - Independent current source & CONST stimulus</H1>
<IMG SRC=Fig.SPICELib.parts.source.ISource.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Current source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<H2>Parameters</H2><br>
Model parameters allow defining the DC and AC characteristics of the source
(see Table 4).<br><br>
<b>Table 4.</b> Parameters of the independent current source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>DC_VALUE</TD>
<TD>SI.Current</TD>
<TD>DC value.</TD></TR>
<TR><TD>AC_MAG</TD>
<TD>SI.Current</TD>
<TD>AC magnitude value.</TD></TR>
<TR><TD>AC_PHASE</TD>
<TD>nonSI.Angle_deg</TD>
<TD>AC phase value.</TD></TR>
<TR><TD>HIDDEN_COMPONENT</TD>
<TD>Boolean</TD>
<TD>See <i>analyses</i> package documentation.</TD></TR>
</TABLE><br><br>
<H2>Variables of interest to the library user</H2><br>
<b>Table 5.</b> Voltage across the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>
<b>Table 6.</b> Current flowing through the source.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
<TR><TD>iAC_mag</TD>
<TD>AC small-signal current. Magnitude.</TD></TR>
<TR><TD>iAC_mag_dB</TD>
<TD>Small-signal current. Magnitude (dB).</TD></TR>
<TR><TD>iAC_phase</TD>
<TD>Small-signal current. Phase (deg).</TD></TR>
</TABLE><br><br>
<H2>Stimulus - CONST waveform</H2><br>
The CONST form causes the voltage to follow v = OFF.
See Table 8.<br><br>
<b>Table 8.</b> CONST waveform parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Parameter</b></TD>
<TD><b>Description</b></TD>
<TD><b>Units</b></TD></TR>
<TR><TD>OFF</TD>
<TD>Constant current.</TD>
<TD>SI.Current</TD></TR>
</HTML>
"));
end ICONST;

  model E
    extends src.SOURCE.E;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>E</i> - Voltage controlled voltage source</H1>
<IMG SRC=Fig.SPICELib.parts.source.E.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Voltage controlled voltage source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p1</TD>
<TD>(+) controlling node</TD></TR>
<TR><TD>n1</TD>
<TD>(-) controlling node</TD></TR>
<TR><TD>p2</TD>
<TD>(+) node</TD></TR>
<TR><TD>n2</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) controlling node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p1.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p1.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p1.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p1.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 3.</b> (-) controlling node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n1.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n1.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n1.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n1.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 4.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p2.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p2.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p2.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p2.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 5.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n2.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n2.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n2.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n2.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<H2>Parameters</H2><br>
<b>Table 6.</b> Parameters of the voltage controlled voltage source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>GAIN</TD>
<TD>Real</TD>
<TD>Voltage gain</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>
<b>Table 7.</b> Voltage across the controlling port.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC1</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran1</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re1</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im1</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 8.</b> Voltage across the source port.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC2</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran2</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re2</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im2</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 9.</b> Current flowing through the controlling port.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC1</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran1</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re1</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im1</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 10.</b> Current flowing through the source port.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC2</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran2</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re2</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im2</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>

<H2>Constitutive relations</H2><br>
<b>Table 11.</b> Model formulations.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Static</b></TD>
<TD>iDC1 = 0<br>
vDC2 = Gain*vDC1</TD></TR>
<TR><TD><b>AC small-signal</b></TD>
<TD>iAC_Re1 =  0,  iAC_Im1 = 0<br>
 vAC_Re2 = Gain * vAC_Re1, vAC_Im2 = Gain * vAC_Re1</TD></TR>
<TR><TD><b>Large signal</b></TD>
<TD>iTran1 = 0<br>
vTran2 = Gain*vTran1</TD></TR>
</TABLE><br><br>
</HTML>
"));
  end E;

  model F
    extends src.SOURCE.F;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
<H1 align=center><i>F</i> - Current controlled current source</H1>
<IMG SRC=Fig.SPICELib.parts.source.F.symbol.png WIDTH=150><br>
<b>Figure 1.</b> Current controlled current source.<br><br>
<H2>Nodes</H2><br>
<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p1</TD>
<TD>(+) controlling node</TD></TR>
<TR><TD>n1</TD>
<TD>(-) controlling node</TD></TR>
<TR><TD>p2</TD>
<TD>(+) node</TD></TR>
<TR><TD>n2</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>
Positive current flows from the (+) node through the source
to the (-) node.<br><br>
<b>Table 2.</b> (+) controlling node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p1.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p1.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p1.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p1.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 3.</b> (-) controlling node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n1.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n1.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n1.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n1.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 4.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>p2.vDC</TD>
<TD>Static model.</TD></TR>
<TR><TD>p2.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>p2.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>p2.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 5.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>n2.vDC</b></TD>
<TD>Static model.</TD></TR>
<TR><TD>n2.vTran</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>n2.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>n2.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<H2>Parameters</H2><br>
<b>Table 6.</b> Parameters of the voltage controlled voltage source
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Type</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>GAIN</TD>
<TD>Real</TD>
<TD>Current gain</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>
<b>Table 7.</b> Voltage across the controlling port.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC1</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran1</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re1</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im1</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 8.</b> Voltage across the source port.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>
<TR><TD>vDC2</TD>
<TD>Static model.</TD></TR>
<TR><TD>vTran2</TD>
<TD>Large-signal voltage</TD></TR>
<TR><TD>vAC_Re2</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>
<TR><TD>vAC_Im2</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 9.</b> Current flowing through the controlling port.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC1</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran1</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re1</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im1</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>

<b>Table 10.</b> Current flowing through the source port.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>
<TR><TD>iDC2</TD>
<TD>DC current.</TD></TR>
<TR><TD>iTran2</TD>
<TD>Large-signal current.</TD></TR>
<TR><TD>iAC_Re2</TD>
<TD>Small-signal current. Real part.</TD></TR>
<TR><TD>iAC_Im2</TD>
<TD>Small-signal current. Imaginary part.</TD></TR>
</TABLE><br><br>

<H2>Constitutive relations</H2><br>
<b>Table 11.</b> Model formulations.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Static</b></TD>
<TD>vDC1 = 0<br>
iDC2 = Gain*iDC1</TD></TR>
<TR><TD><b>AC small-signal</b></TD>
<TD> vAC_Re1 = 0,  vAC_Im1 = 0<br>
 iAC_Re2 = Gain*iAC_Re1, iAC_Im2 = Gain*iAC_Im1</TD></TR>
<TR><TD><b>Large signal</b></TD>
<TD>vTran1 = 0<br>
iTran2 = Gain*iTran1</TD></TR>
</TABLE><br><br>
</HTML>
"));
  end F;

  model G
    extends src.SOURCE.G;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
  <H1 align=center><i>G</i> - Voltage controlled current source</H1>
  <IMG SRC=Fig.SPICELib.parts.source.G.symbol.png WIDTH=150><br>
  <b>Figure 1.</b> Voltage controlled current source.<br><br>
  <H2>Nodes</H2><br>
  <b>Table 1.</b> Instantiations of <i>Pin</i> class.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</b></TD>
  <TD><b>Description</b></TD></TR>
  <TR><TD>p1</TD>
  <TD>(+) controlling node</TD></TR>
  <TR><TD>n1</TD>
  <TD>(-) controlling node</TD></TR>
  <TR><TD>p2</TD>
  <TD>(+) node</TD></TR>
  <TR><TD>n2</TD>
  <TD>(-) node</TD></TR>
  </TABLE><br><br>
  Positive current flows from the (+) node through the source
  to the (-) node.<br><br>
  <b>Table 2.</b> (+) controlling node variables.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</b></TD>
  <TD><b>Description<b></TD></TR>
  <TR><TD>p1.vDC</TD>
  <TD>Static model.</TD></TR>
  <TR><TD>p1.vTran</TD>
  <TD>Large-signal voltage</TD></TR>
  <TR><TD>p1.vAC_Re</TD>
  <TD>AC small-signal voltage. Real part.</TD></TR>
  <TR><TD>p1.vAC_Im</TD>
  <TD>AC small-signal voltage. Imaginary part.</TD></TR>
  </TABLE><br><br>

  <b>Table 3.</b> (-) controlling node variables.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</b></TD>
  <TD><b>Description<b></TD></TR>
  <TR><TD>n1.vDC</b></TD>
  <TD>Static model.</TD></TR>
  <TR><TD>n1.vTran</TD>
  <TD>Large-signal voltage</TD></TR>
  <TR><TD>n1.vAC_Re</TD>
  <TD>AC small-signal voltage. Real part.</TD></TR>
  <TR><TD>n1.vAC_Im</TD>
  <TD>AC small-signal voltage. Imaginary part.</TD></TR>
  </TABLE><br><br>

  <b>Table 4.</b> (+) node variables.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</b></TD>
  <TD><b>Description<b></TD></TR>
  <TR><TD>p2.vDC</TD>
  <TD>Static model.</TD></TR>
  <TR><TD>p2.vTran</TD>
  <TD>Large-signal voltage</TD></TR>
  <TR><TD>p2.vAC_Re</TD>
  <TD>AC small-signal voltage. Real part.</TD></TR>
  <TR><TD>p2.vAC_Im</TD>
  <TD>AC small-signal voltage. Imaginary part.</TD></TR>
  </TABLE><br><br>

  <b>Table 5.</b> (-) node variables.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</b></TD>
  <TD><b>Description<b></TD></TR>
  <TR><TD>n2.vDC</b></TD>
  <TD>Static model.</TD></TR>
  <TR><TD>n2.vTran</TD>
  <TD>Large-signal voltage</TD></TR>
  <TR><TD>n2.vAC_Re</TD>
  <TD>AC small-signal voltage. Real part.</TD></TR>
  <TR><TD>n2.vAC_Im</TD>
  <TD>AC small-signal voltage. Imaginary part.</TD></TR>
  </TABLE><br><br>

  <H2>Parameters</H2><br>
  <b>Table 6.</b> Parameters of the voltage controlled voltage source
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</b></TD>
  <TD><b>Type</b></TD>
  <TD><b>Description<b></TD></TR>
  <TR><TD>GAIN</TD>
  <TD>SI.Conductance</TD>
  <TD>Transconductance</TD></TR>
  </TABLE><br><br>

  <H2>Variables of interest to the library user</H2><br>
  <b>Table 7.</b> Voltage across the controlling port.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</b></TD>
  <TD><b>Description<b></TD></TR>
  <TR><TD>vDC1</TD>
  <TD>Static model.</TD></TR>
  <TR><TD>vTran1</TD>
  <TD>Large-signal voltage</TD></TR>
  <TR><TD>vAC_Re1</TD>
  <TD>AC small-signal voltage. Real part.</TD></TR>
  <TR><TD>vAC_Im1</TD>
  <TD>AC small-signal voltage. Imaginary part.</TD></TR>
  </TABLE><br><br>

  <b>Table 8.</b> Voltage across the source port.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</b></TD>
  <TD><b>Description<b></TD></TR>
  <TR><TD>vDC2</TD>
  <TD>Static model.</TD></TR>
  <TR><TD>vTran2</TD>
  <TD>Large-signal voltage</TD></TR>
  <TR><TD>vAC_Re2</TD>
  <TD>AC small-signal voltage. Real part.</TD></TR>
  <TR><TD>vAC_Im2</TD>
  <TD>AC small-signal voltage. Imaginary part.</TD></TR>
  </TABLE><br><br>

  <b>Table 9.</b> Current flowing through the controlling port.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</TD>
  <TD><b>Description</b></TD></TR>
  <TR><TD>iDC1</TD>
  <TD>DC current.</TD></TR>
  <TR><TD>iTran1</TD>
  <TD>Large-signal current.</TD></TR>
  <TR><TD>iAC_Re1</TD>
  <TD>Small-signal current. Real part.</TD></TR>
  <TR><TD>iAC_Im1</TD>
  <TD>Small-signal current. Imaginary part.</TD></TR>
  </TABLE><br><br>

  <b>Table 10.</b> Current flowing through the source port.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Name</TD>
  <TD><b>Description</b></TD></TR>
  <TR><TD>iDC2</TD>
  <TD>DC current.</TD></TR>
  <TR><TD>iTran2</TD>
  <TD>Large-signal current.</TD></TR>
  <TR><TD>iAC_Re2</TD>
  <TD>Small-signal current. Real part.</TD></TR>
  <TR><TD>iAC_Im2</TD>
  <TD>Small-signal current. Imaginary part.</TD></TR>
  </TABLE><br><br>

  <H2>Constitutive relations</H2><br>
  <b>Table 11.</b> Model formulations.
  <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
  <TR><TD><b>Static</b></TD>
  <TD>iDC1 = 0<br>
  iDC2 = Gain*vDC1</TD></TR>
  <TR><TD><b>AC small-signal</b></TD>
  <TD> iAC_Re1 = 0,  iAC_Im1 = 0<br>
   iAC_Re2 = Gain*vAC_Re1, iAC_Im2 = Gain*vAC_Im1</TD></TR>
  <TR><TD><b>Large signal</b></TD>
  <TD>iTran1 = 0<br>
  iTran2 = Gain*vTran1</TD></TR>
  </TABLE><br><br>
  </HTML>
"));
  end G;

  model H
    extends src.SOURCE.H;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>
   <H1 align=center><i>H</i> - Current controlled voltage source</H1>
   <IMG SRC=Fig.SPICELib.parts.source.H.symbol.png WIDTH=150><br>
   <b>Figure 1.</b> Current controlled voltage source.<br><br>
   <H2>Nodes</H2><br>
   <b>Table 1.</b> Instantiations of <i>Pin</i> class.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</b></TD>
   <TD><b>Description</b></TD></TR>
   <TR><TD>p1</TD>
   <TD>(+) controlling node</TD></TR>
   <TR><TD>n1</TD>
   <TD>(-) controlling node</TD></TR>
   <TR><TD>p2</TD>
   <TD>(+) node</TD></TR>
   <TR><TD>n2</TD>
   <TD>(-) node</TD></TR>
   </TABLE><br><br>
   Positive current flows from the (+) node through the source
   to the (-) node.<br><br>
   <b>Table 2.</b> (+) controlling node variables.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</b></TD>
   <TD><b>Description<b></TD></TR>
   <TR><TD>p1.vDC</TD>
   <TD>Static model.</TD></TR>
   <TR><TD>p1.vTran</TD>
   <TD>Large-signal voltage</TD></TR>
   <TR><TD>p1.vAC_Re</TD>
   <TD>AC small-signal voltage. Real part.</TD></TR>
   <TR><TD>p1.vAC_Im</TD>
   <TD>AC small-signal voltage. Imaginary part.</TD></TR>
   </TABLE><br><br>

   <b>Table 3.</b> (-) controlling node variables.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</b></TD>
   <TD><b>Description<b></TD></TR>
   <TR><TD>n1.vDC</b></TD>
   <TD>Static model.</TD></TR>
   <TR><TD>n1.vTran</TD>
   <TD>Large-signal voltage</TD></TR>
   <TR><TD>n1.vAC_Re</TD>
   <TD>AC small-signal voltage. Real part.</TD></TR>
   <TR><TD>n1.vAC_Im</TD>
   <TD>AC small-signal voltage. Imaginary part.</TD></TR>
   </TABLE><br><br>

   <b>Table 4.</b> (+) node variables.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</b></TD>
   <TD><b>Description<b></TD></TR>
   <TR><TD>p2.vDC</TD>
   <TD>Static model.</TD></TR>
   <TR><TD>p2.vTran</TD>
   <TD>Large-signal voltage</TD></TR>
   <TR><TD>p2.vAC_Re</TD>
   <TD>AC small-signal voltage. Real part.</TD></TR>
   <TR><TD>p2.vAC_Im</TD>
   <TD>AC small-signal voltage. Imaginary part.</TD></TR>
   </TABLE><br><br>

   <b>Table 5.</b> (-) node variables.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</b></TD>
   <TD><b>Description<b></TD></TR>
   <TR><TD>n2.vDC</b></TD>
   <TD>Static model.</TD></TR>
   <TR><TD>n2.vTran</TD>
   <TD>Large-signal voltage</TD></TR>
   <TR><TD>n2.vAC_Re</TD>
   <TD>AC small-signal voltage. Real part.</TD></TR>
   <TR><TD>n2.vAC_Im</TD>
   <TD>AC small-signal voltage. Imaginary part.</TD></TR>
   </TABLE><br><br>

   <H2>Parameters</H2><br>
   <b>Table 6.</b> Parameters of the voltage controlled voltage source
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</b></TD>
   <TD><b>Type</b></TD>
   <TD><b>Description<b></TD></TR>
   <TR><TD>GAIN</TD>
   <TD>SI.Resistance</TD>
   <TD>Transresistance</TD></TR>
   </TABLE><br><br>

   <H2>Variables of interest to the library user</H2><br>
   <b>Table 7.</b> Voltage across the controlling port.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</b></TD>
   <TD><b>Description<b></TD></TR>
   <TR><TD>vDC1</TD>
   <TD>Static model.</TD></TR>
   <TR><TD>vTran1</TD>
   <TD>Large-signal voltage</TD></TR>
   <TR><TD>vAC_Re1</TD>
   <TD>AC small-signal voltage. Real part.</TD></TR>
   <TR><TD>vAC_Im1</TD>
   <TD>AC small-signal voltage. Imaginary part.</TD></TR>
   </TABLE><br><br>

   <b>Table 8.</b> Voltage across the source port.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</b></TD>
   <TD><b>Description<b></TD></TR>
   <TR><TD>vDC2</TD>
   <TD>Static model.</TD></TR>
   <TR><TD>vTran2</TD>
   <TD>Large-signal voltage</TD></TR>
   <TR><TD>vAC_Re2</TD>
   <TD>AC small-signal voltage. Real part.</TD></TR>
   <TR><TD>vAC_Im2</TD>
   <TD>AC small-signal voltage. Imaginary part.</TD></TR>
   </TABLE><br><br>

   <b>Table 9.</b> Current flowing through the controlling port.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</TD>
   <TD><b>Description</b></TD></TR>
   <TR><TD>iDC1</TD>
   <TD>DC current.</TD></TR>
   <TR><TD>iTran1</TD>
   <TD>Large-signal current.</TD></TR>
   <TR><TD>iAC_Re1</TD>
   <TD>Small-signal current. Real part.</TD></TR>
   <TR><TD>iAC_Im1</TD>
   <TD>Small-signal current. Imaginary part.</TD></TR>
   </TABLE><br><br>

   <b>Table 10.</b> Current flowing through the source port.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Name</TD>
   <TD><b>Description</b></TD></TR>
   <TR><TD>iDC2</TD>
   <TD>DC current.</TD></TR>
   <TR><TD>iTran2</TD>
   <TD>Large-signal current.</TD></TR>
   <TR><TD>iAC_Re2</TD>
   <TD>Small-signal current. Real part.</TD></TR>
   <TR><TD>iAC_Im2</TD>
   <TD>Small-signal current. Imaginary part.</TD></TR>
   </TABLE><br><br>

   <H2>Constitutive relations</H2><br>
   <b>Table 11.</b> Model formulations.
   <TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
   <TR><TD><b>Static</b></TD>
   <TD>vDC1 = 0<br>
   vDC2 = Gain*iDC1</TD></TR>
   <TR><TD><b>AC small-signal</b></TD>
   <TD> vAC_Re1 = 0,  vAC_Im1 = 0<br>
    vAC_Re2 = Gain*iAC_Re1, vAC_Im2 = Gain*iAC_Im1;</TD></TR>
   <TR><TD><b>Large signal</b></TD>
   <TD>vTran1 = 0<br>
   vTran2 = Gain*iTran1</TD></TR>
   </TABLE><br><br>
   </HTML>
"));
  end H;

  annotation (
    Window(
      x=0.03,
      y=0.02,
      width=0.24,
      height=0.45,
      library=1,
      autolayout=1),
    Documentation(info="<html>
<H1 align=center><i>source</i> package</H1><br><br>
<p>The following summary table lists all the device types of <i>source</i> package.
Each device type is described in detail in the model documentation.</p><br>
<b>Table 1.</b> <i>source</i> package devices.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TH align=center><b>Model</b></TH>
<TH align=center><b>Device type</b></TH></TR>
<TR><TD WIDTH=40>V</TD>
<TD>Independent voltage source (DC and AC characteristics).</TD></TR>
<TR><TD WIDTH=40>VEXP</TD>
<TD>Independent voltage source & EXP stimulus.</TD></TR>
<TR><TD WIDTH=40>VPULSE</TD>
<TD>Independent voltage source & PULSE stimulus.</TD></TR>
<TR><TD WIDTH=40>VPWL</TD>
<TD>Independent voltage source & PWL stimulus.</TD></TR>
<TR><TD WIDTH=40>VSIN</TD>
<TD>Independent voltage source & SIN stimulus.</TD></TR>
<TR><TD WIDTH=40>VCONST</TD>
<TD>Independent voltage source & CONST stimulus.</TD></TR>
<TR><TD WIDTH=40>I</TD>
<TD>Independent current source (DC and AC characteristics).</TD></TR>
<TR><TD WIDTH=40>IEXP</TD>
<TD>Independent current source & EXP stimulus.</TD></TR>
<TR><TD WIDTH=40>IPULSE</TD>
<TD>Independent current source & PULSE stimulus.</TD></TR>
<TR><TD WIDTH=40>IPWL</TD>
<TD>Independent current source & PWL stimulus</TD></TR>
<TR><TD WIDTH=40>ISIN</TD>
<TD>Independent current source & SIN stimulus</TD></TR>
<TR><TD WIDTH=40>ICONST</TD>
<TD>Independent current source & CONST stimulus</TD></TR>
<TR><TD WIDTH=40>E</TD>
<TD>Voltage controlled voltage source</TD></TR>
<TR><TD WIDTH=40>F</TD>
<TD>Current controlled current source</TD></TR>
<TR><TD WIDTH=40>G</TD>
<TD>Voltage controlled current source</TD></TR>
<TR><TD WIDTH=40>H</TD>
<TD>Current controlled voltage source</TD></TR>
</TABLE><br><br>
</HTML>
"),
    Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71, thickness=2)),
        Text(extent=[-64, 76; 68, -70], string="source")));


end source;


package special

  model IC1
    extends src.SPECIAL.IC1;
    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>IC1</i> pseudocomponent</H1>

<IMG SRC=Fig.SPICELib.parts.special.IC1.symbol.png WIDTH=150><br>
<b>Figure 1.</b> IC1 pseudocomponent.<br><br>

<H2>Node</H2><br>

<b>Table 1.</b> Instantiation of <i>Pin</i> class
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD>Comment</TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
</TABLE><br><br>

<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br>

<H2>Parameters</H2><br>

<b>Table 3.</b> IC1 symbol parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>IC</TD>
<TD>Value of the initial voltage.</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>
None.<br><br>

<H2>Internal implementation</H2>
<i>SPICE</i>Lib attaches a voltage source with a 0.0002 ohm series
resistance to each net to which the IC symbol is connected (see Figure 2).
The voltages are clamped this way for the entire bias point calculation.<br>

<IMG SRC=Fig.SPICELib.parts.special.IC1.implementation.png WIDTH=300><br>
<b>Figure 2.</b> IC1 symbol implementation.<br><br>

</HTML>
"));
  end IC1;

  model IC2
    extends src.SPECIAL.IC2;

    annotation (Window(
        x=0.03,
        y=0.02,
        width=0.24,
        height=0.45,
        library=1,
        autolayout=1), Documentation(info="<html>

<H1 align=center><i>IC2</i> pseudocomponent</H1>

<IMG SRC=Fig.SPICELib.parts.special.IC2.symbol.png WIDTH=150><br>
<b>Figure 1.</b> IC2 pseudocomponent.<br><br>

<H2>Nodes</H2><br>

<b>Table 1.</b> Instantiations of <i>Pin</i> class.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description</b></TD></TR>
<TR><TD>p</TD>
<TD>(+) node</TD></TR>
<TR><TD>n</TD>
<TD>(-) node</TD></TR>
</TABLE><br><br>

<b>Table 2.</b> (+) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>p.vDC</TD>
<TD>Static model.</TD></TR>

<TR><TD>p.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>p.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>p.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>

</TABLE><br><br>

<b>Table 3.</b> (-) node variables.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</b></TD>
<TD><b>Description<b></TD></TR>

<TR><TD>n.vDC</b></TD>
<TD>Static model.</TD></TR>

<TR><TD>n.vTran</TD>
<TD>Large-signal voltage</TD></TR>

<TR><TD>n.vAC_Re</TD>
<TD>AC small-signal voltage. Real part.</TD></TR>

<TR><TD>n.vAC_Im</TD>
<TD>AC small-signal voltage. Imaginary part.</TD></TR>
</TABLE><br><br>


<H2>Parameters</H2><br>

<b>Table 3.</b> IC2 symbol parameters.
<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=2>
<TR><TD><b>Name</TD>
<TD><b>Description</b></TD></TR>

<TR><TD>IC</TD>
<TD>Value of the initial voltage between two nodes.</TD></TR>
</TABLE><br><br>

<H2>Variables of interest to the library user</H2><br>
None.<br><br>

<H2>Internal implementation</H2>
<i>SPICE</i>Lib attaches a voltage source with a 0.0002 ohm series
resistance between the two nets to which the IC symbol is connected.
The voltages are clamped this way for the entire bias point calculation.<br>

<IMG SRC=Fig.SPICELib.parts.special.IC2.implementation.png WIDTH=300><br>
<b>Figure 2.</b> IC2 symbol implementation.<br><br>

</HTML>
"));

  end IC2;

  annotation (
    Window(
      x=0.03,
      y=0.02,
      width=0.24,
      height=0.45,
      library=1,
      autolayout=1),
    Documentation(info="<html>

<H1 align=center><i>special</i> package</H1>

<H2>IC symbols: IC1 and IC2</H2>
IC symbols specify initial conditions for the bias point.<br>
<b>They substitute the model initialization procedures of the
modeling environment</b> (for instance, Dymola).<br>


<IMG SRC=Fig.SPICELib.parts.special.IC.png WIDTH=320><br>
<b>Figure 1.</b> IC symbols.<br><br>

The example in Figure 1 includes
<ul><li>a one-pin symbol (i.e., IC1) that allows setting the initial condition on a net
for both small-signal and transient bias points, and
<li>a two-pin symbol (i.e., IC2) that allows setting initial condition between two nets.</ul>

</HTML>
"),
    Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71, thickness=2)),
        Text(extent=[-68, 36; 72, -34], string="special")));
end special;

