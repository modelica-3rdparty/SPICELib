package norcmos "Nor gate"
annotation (Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1), Documentation(info="<html>
<H1 align=center>Nor CMOS</H1>
The modeling and transient analysis of the CMOS nor gate shown in Figure 1 is discussed. <br>
The transient analysis plot obtained using <i>SPICE</i>Lib and ORCAD PSpice are shown.<br>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.Layout.png WIDTH=600><br>
<b>Figure 1.</b> CMOS Nor Gate.<br><br>
<H2>Circuit modeling</H2>
<ul>
<li>Start Dymola with Modelica modeling language.
<li>In order to open <i>SPICE</i>Lib library, select in the Dymola window File/Open
and open the file SPICELib/package.mo
<li>Create a new package (select in the Dymola window File/New/Package): <i>norcmos</i>.<br>
It is going to include the circuit and the analysis models.
<li>Create the circuit model (select in the Dymola window File/New/Model) as follows:<br>
<ul>Name of new model: <i>schematic</i><br>
Description: Circuit model<br>
Partial model<br>
Insert in package: norcmos<br></ul>
Dymola model window now contains an empty <i>schematic</i> model.<br>
The model circuit is built up using components from the SPICELib.parts package.
The model components for n-channel MOS, p-channel MOS and ground can be found in
SPICELib.parts.breakout. The model component for a independent voltage source
can be found in SPICELib.parts.source. Drag and drop the part models.
<ul><li>SPICELib.parts.breakout.Ground
<li>SPICELib.parts.breakout.Spice2MOS1
<li>SPICELib.parts.breakout.Spice2MOS1P
<li>SPICELib.parts.source.VPULSE
<li>SPICELib.parts.source.VCONST</ul>
<li>Connect the circuit parts as shown in Figure 1.
<li>Enter the parameter values of the circuit components. See Figures 2-6.
MNA and MNB have the same parameters. MPA and MPB also have the same parameters.<br>
The Boolean parameter HIDDEN_COMPONENT controls the log of the device
variables (see <i>SPICELib.analyses</i> package documentation).
<IMG SRC=Fig.SPICELib.tutorial.norcmos.VDDparams.png WIDTH=450><br>
<b>Figure 2.</b> VDD parameters.<br><br>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.V1params.png WIDTH=450><br>
<b>Figure 3.</b> V1 parameters.<br><br><br>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.V2params.png WIDTH=450><br>
<b>Figure 4.</b> V2 parameters.<br><br><br>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.NMOSparams.png WIDTH=750><br>
<b>Figure 5.</b> NMOS parameters.<br>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.PMOSparams.png WIDTH=750><br>
<b>Figure 6.</b> PMOS parameters.<br><br><br>
<li>Save the <i>Schematic</i> model.
</ul>
<H2>Transient (time) analysis (TRAN)</H2>
<ul>
<li>Create a new model, <i>TRAN</i>, and insert it in <i>norcmos</i> package
(see Figure 7).
<IMG SRC=Fig.SPICELib.tutorial.norcmos.createTRAN.png WIDTH=450><br>
<b>Figure 7.</b> Inserting <i>TRAN</i> in <i>norcmos</i> package.<br><br>
<li>Drag an <i>SPICELib.analyses.TRAN</i> model into the <i>TRAN</i> model
(see Figure 8).
<IMG SRC=Fig.SPICELib.tutorial.norcmos.norcmosTRANDiagram.png WIDTH=650><br>
<b>Figure 8.</b> Inserting <i>TRAN</i> in <i>norcmos</i> package.<br><br>
<li>Enter the TRAN analysis parameters (see Figure 9). The meaning of the
analysis parameters is discussed in the SPICELib.analyses.TRAN model documentation.
The <i>SKIPBP</i> parameter determines whether skip or not the bias point calculation.
<br>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.TRANParams.png WIDTH=450><br>
<b>Figure 9.</b> TRAN analysis parameters.<br><br>
</ul>
<h3>TRANSIENT ANALYSIS</h3>
Figure 10 shows the input stimuli. Figure 11 shows the results obtaines with <i>SPICE</i>Lib
and ORCAD PSPICE and in Figure 12 the difference between the results obtained with
<i>SPICE</i>Lib and ORCAD PSpice is presented.<br><br>
<u1>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.inputTRAN.png WIDTH=450><br>
<b>Figure 10.</b> Input stimuli.<br><br>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.TRAN.png WIDTH=450><br>
<b>Figure 11.</b> Results obtained with SPICELib and ORCAD PSpice.<br><br>
<IMG SRC=Fig.SPICELib.tutorial.norcmos.errorTRAN.png WIDTH=450><br>
<b>Figure 12.</b> Difference between the results obtained with SPICELib and ORCAD.<br><br>
</ul>

</HTML>
"));

annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71, thickness
          =2)), Text(extent=[-70, 30; 80, -24], string="NORCMOS")));
end norcmos;
