package circ2 "Example 2 of SPICELib tutorial"
annotation (Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1), Documentation(info="<html>
<H1 align=center>Example 2</H1>
The modeling and transient analysis of the CMOS inverter shown in Figure 1 is discussed. <br>
The transient analysis plot obtained using <i>SPICE</i>Lib is shown.<br>
<IMG SRC=Fig.SPICELib.tutorial.circ2.Layout.png WIDTH=400><br>
<b>Figure 1.</b> CMOS Inverter.<br><br>
<H2>Circuit modeling</H2>
<ul>
<li>Start Dymola with Modelica modeling language.
<li>In order to open <i>SPICE</i>Lib library, select in the Dymola window File/Open
and open the file SPICELib/package.mo
<li>Create a new package (select in the Dymola window File/New/Package): <i>circ2</i>.<br>
It is going to include the circuit and the analysis models.
<li>Create the circuit model (select in the Dymola window File/New/Model) as follows:<br>
<ul>Name of new model: <i>Schematic</i><br>
Description: Circuit model<br>
Partial model<br>
Insert in package: circ2<br></ul>
Dymola model window now contains an empty <i>Schematic</i> model.<br>
The model circuit is built up using components from the SPICELib.parts package.
The model components for a n-channel MOS, a p-channel MOS and a ground can be found in
SPICELib.parts.breakout. The model component for a independent voltage source
can be found in SPICELib.parts.source. Drag and drop the part models listed below
as shown in Figure 2.
<ul><li>SPICELib.parts.breakout.Ground
<li>SPICELib.parts.breakout.Spice2MOS1
<li>SPICELib.parts.breakout.Spice2MOS1P
<li>SPICELib.parts.source.VPULSE
<li>SPICELib.parts.source.VCONST</ul>
<IMG SRC=Fig.SPICELib.tutorial.circ2.Diagram1.png WIDTH=650><br>
<b>Figure 2.</b> Inserting the circuit components.<br><br>
<li>Connect the circuit parts as shown in Figure 1.
<li>Enter the parameter values of the circuit components. See Figures 3-6.<br>
The Boolean parameter HIDDEN_COMPONENT controls the log of the device
variables (see <i>SPICELib.analyses</i> package documentation).
<IMG SRC=Fig.SPICELib.tutorial.circ2.VDDparams.png WIDTH=450><br>
<b>Figure 3.</b> VDD parameters.<br><br>
<IMG SRC=Fig.SPICELib.tutorial.circ2.VPULSE1params.png WIDTH=450><br>
<b>Figure 4.</b> VPULSE1 parameters.<br><br><br>
<IMG SRC=Fig.SPICELib.tutorial.circ2.NMOSparams.png WIDTH=450><br>
<b>Figure 5.</b> NMOS parameters.<br>
<IMG SRC=Fig.SPICELib.tutorial.circ2.PMOSparams.png WIDTH=450><br>
<b>Figure 6.</b> PMOS parameters.<br><br><br>
<li>Save the <i>Schematic</i> model.
</ul>
<H2>Transient (time) analysis (TRAN)</H2>
<ul>
<li>Create a new model, <i>circ2_TRAN</i>, and insert it in <i>circ2</i> package
(see Figure 7).
<IMG SRC=Fig.SPICELib.tutorial.circ2.createCirc2_TRAN.png WIDTH=450><br>
<b>Figure 7.</b> Inserting <i>circ2_TRAN</i> in <i>circ2</i> package.<br><br>
<li>Drag an <i>SPICELib.analyses.TRAN</i> model into the <i>circ2_TRAN</i> model
(see Figure 8).
<IMG SRC=Fig.SPICELib.tutorial.circ2.circ2TRANDiagram.png WIDTH=650><br>
<b>Figure 8.</b> Inserting <i>circ2_TRAN</i> in <i>circ2</i> package.<br><br>
<li>Enter the TRAN analysis parameters (see Figure 9). The meaning of the
analysis parameters is discussed in the SPICELib.analyses.TRAN model documentation.
The <i>SKIPBP</i> parameter determines whether skip or not the bias point calculation.
<br>
<IMG SRC=Fig.SPICELib.tutorial.circ2.circ2TRANParams.png WIDTH=450><br>
<b>Figure 9.</b> TRAN analysis parameters.<br><br>
</ul>
<h3>TRANSIENT ANALYSIS SIMULATED WITH <i>SPICE</i>LIB</h3>
<u1>
<IMG SRC=Fig.SPICELib.tutorial.circ2.circ2TRANSPICE.png WIDTH=450><br>
<b>Figure 10.</b> Transient analysis simulated with SPICELib.<br><br>
</ul>
</HTML>
"));

annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71, thickness
          =2)), Text(extent=[-70, 30; 80, -24], string="CIRC2")));
end circ2;
