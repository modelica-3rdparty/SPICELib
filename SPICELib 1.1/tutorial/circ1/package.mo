package circ1 "Example 1 of SPICELib tutorial"


annotation (Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1), Documentation(info="<html>

<H1 align=center>Example 1</H1>

The modeling of the circuit shown in Figure 1 is discussed, and
OP, AC sweep and transient analyses are carried out.<br>
The results of the analysis using SPICELib are shown, together
with the results obtained using OrCAD PSpice.<br>
<IMG SRC=Fig.SPICELib.tutorial.circ1.Layout.png WIDTH=400><br>
<b>Figure 1.</b> Full wave Rectifier.<br><br>

<H2>Circuit modeling</H2>
<ul>

<li>Start Dymola with Modelica modeling language.

<li>In order to open <i>SPICE</i>Lib library, select in the Dymola window File/Open
and open the file SPICELib/package.mo

<li>Create a new package (select in the Dymola window File/New/Package): <i>circ1</i>.<br>
It is going to include the circuit and the analysis models.

<li>Create the circuit model (select in the Dymola window File/New/Model) as follows:<br>
<ul>Name of new model: <i>Schematic</i><br>
Description: Circuit model<br>
Partial model<br>
Insert in package: circ1<br></ul>
Dymola model window now contains an empty <i>Schematic</i> model.<br>
The model circuit is built up using components from the SPICELib.parts package.
The model components for a resistor, a capacitor, an inductor, a diode and a ground
can be found in SPICELib.parts.breakout. The model component for a independent voltage
source can be found in SPICELib.parts.source. Drag and drop the part models listed below
as shown in Figure 2.
<ul><li>SPICELib.parts.breakout.Ground
<li>SPICELib.parts.breakout.Rbreak
<li>SPICELib.parts.breakout.Cbreak
<li>SPICELib.parts.breakout.Lbreak
<li>SPICELib.parts.breakout.PSPICE_diode
<li>SPICELib.parts.source.VSIN</ul>

<IMG SRC=Fig.SPICELib.tutorial.circ1.Diagram1.png WIDTH=650><br>
<b>Figure 2.</b> Inserting the circuit components.<br><br>


<li>Connect the circuit parts as shown in Figure 1.
<li>Enter the parameter values of the circuit components. See Figures 3-6.<br>
The Boolean parameter HIDDEN_COMPONENT controls the log of the device
variables (see <i>SPICELib.analyses</i> package documentation).
The circuit's diodes have the same parameters. Therefore, we only show
D1's diode parameters.

<IMG SRC=Fig.SPICELib.tutorial.circ1.V1params.png WIDTH=450><br>
<b>Figure 3.</b> Voltage source parameters.<br><br>

<IMG SRC=Fig.SPICELib.tutorial.circ1.R1params.png WIDTH=450><br>
<b>Figure 4.</b> R parameters.<br><br><br>

<IMG SRC=Fig.SPICELib.tutorial.circ1.C1params.png WIDTH=450><br>
<b>Figure 5.</b> C parameters.<br><br><br>

<IMG SRC=Fig.SPICELib.tutorial.circ1.D1params.png WIDTH=450><br><br><br>
<b>Figure 6.</b> D1 parameters.<br><br>

<li>Save the <i>Schematic</i> model.
</ul>

<H2>Bias Point Analysis (OP)</H2>

<ul>

<li>Create a new model, <i>circ1_OP</i>, and insert it in <i>circ1</i> package
(see Figure 7).
<IMG SRC=Fig.SPICELib.tutorial.circ1.createCirc1_OP.png WIDTH=450><br>
<b>Figure 7.</b> Inserting <i>circ1_OP</i> in <i>circ1</i> package.<br><br>

<li>Drag an <i>SPICELib.analyses.OP</i> model into the <i>circ1_OP</i> model
(see Figure 8).

<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1OPDiagram.png WIDTH=650><br>
<b>Figure 8.</b> Inserting <i>circ1_OP</i> in <i>circ1</i> package.<br><br>

<li>Enter the OP analysis parameters (see Figure 9). The meaning of the
analysis parameters is discussed in the SPICELib.analyses.OP model documentation.
The <i>SOLVE_STATIC</i> parameter determines which of the four algorithms
to use for the bias point calculation. The four cases are discussed next.

<br>
<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1OPParams.png WIDTH=450><br>
<b>Figure 9.</b> OP analysis parameters.<br><br>
</ul>

<h3>STATIC MODEL ITERATION (<i>SOLVE_STATIC</i> := 0)</h3>

<ul>
<li>Set <i>SOLVE_STATIC</i> value equals to zero, as it is shown in Figure 9.

<li>Change to the Dymola Simulation window and translate the model
<b>circ1.circ1_OP</b>

<li>Experiment setup. Give to the <i>Stop time</i> parameter an arbitratily
large value (Dymola window option: \"Simulation/Setup/Stop time\"),
for example, <i>Stop time</i> equals 10.

<li>Run the simulation. Once it is finished, <i>dslog.txt</i> file contains the analysis
results (see Figure 10). Variables of interest are signaled with arrows.

<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1_dslog_smi.png WIDTH=650><br>
<b>Figure 10.</b> <i>dslog.txt</i> file fragment.
<i>SOLVE_STATIC</i>:=0, LOG_RESULTS:=0<br><br>

</ul>

<h3>STATIC MODEL RAMPING (<i>SOLVE_STATIC</i> := 1)</h3>

<ul>
<li>Set <i>SOLVE_STATIC</i> value equals to one.

<li>Change to the Dymola Simulation window and translate the model
<b>circ1.circ1_OP</b>

<li>Experiment setup. Give to the <i>Stop time</i> parameter an arbitratily
large value (Dymola window option: \"Simulation/Setup/Stop time\"),
for example, <i>Stop time</i> equals 10.

<li>Run the simulation. Once it is finished, <i>dslog.txt</i> file contains the analysis
results (see Figure 11).

<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1_dslog_smr.png WIDTH=650><br>
<b>Figure 11.</b> <i>dslog.txt</i> file fragment.
<i>SOLVE_STATIC</i>:=1, LOG_RESULTS:=0<br><br>

</ul>
<h3>GMIN STEPPING (<i>SOLVE_STATIC</i> := 2)</h3>
<ul>
<li>Set <i>SOLVE_STATIC</i> value equals to two.

<li>Change to the Dymola Simulation window and translate the model
<b>circ1.circ1_OP</b>

<li>Experiment setup. Give to the <i>Stop time</i> parameter an arbitratily
large value (Dymola window option: \"Simulation/Setup/Stop time\"),
for example, <i>Stop time</i> equals 10.

<li>Run the simulation. Once it is finished, <i>dslog.txt</i> file contains the analysis
results (see Figure 12).

<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1_dslog_gmin.png WIDTH=650><br>
<b>Figure 13.</b> <i>dslog.txt</i> file fragment.
<i>SOLVE_STATIC</i>:=2, LOG_RESULTS:=0<br><br>
</ul>
<h3>DYNAMIC MODEL RAMPING (<i>SOLVE_STATIC</i> := 3)</h3>

<ul>
<li>Set <i>SOLVE_STATIC</i> value equals to three.

<li>Change to the Dymola Simulation window and translate the model
<b>circ1.circ1_OP</b>

<li>Experiment setup. Give to the <i>Stop time</i> parameter an arbitratily
large value (Dymola window option: \"Simulation/Setup/Stop time\"),
for example, <i>Stop time</i> equals 10.

<li>Run the simulation. Once it is finished, <i>dslog.txt</i> file contains the analysis
results (see Figure 13).

<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1_dslog_dmr.png WIDTH=650><br>
<b>Figure 13.</b> <i>dslog.txt</i> file fragment.
<i>SOLVE_STATIC</i>:=3, LOG_RESULTS:=0<br><br>

</ul>

<h3>BIAS POINT ANALYSIS SIMULATED WITH ORCAD PSPICE</h3>

<ul>
<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1_dslog_pspice.png WIDTH=450><br>
<b>Figure 14.</b> <i>OP calculate with OrCAD PSPICE</i>.
</ul>

<H2>AC sweep analysis (AC)</H2>
<ul>

<li>Create a new model, <i>circ1_AC</i>, and insert it in <i>circ1</i> package
(see Figure 15).
<IMG SRC=Fig.SPICELib.tutorial.circ1.createCirc1_AC.png WIDTH=450><br>
<b>Figure 15.</b> Inserting <i>circ1_AC</i> in <i>circ1</i> package.<br><br>

<li>Drag an <i>SPICELib.analyses.AC</i> model into the <i>circ1_AC</i> model
(see Figure 16).

<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1ACDiagram.png WIDTH=650><br>
<b>Figure 16.</b> Inserting <i>circ1_AC</i> in <i>circ1</i> package.<br><br>

<li>Enter the AC analysis parameters (see Figure 17). The meaning of the
analysis parameters is discussed in the SPICELib.analyses.AC model documentation.

<br>
<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1ACParams.png WIDTH=450><br>
<b>Figure 17.</b> AC analysis parameters.<br><br>

<li>Change to the Dymola Simulation window and translate the model
<b>circ1.circ1_AC</b>

<li>Experiment setup. Give to the <i>Stop time</i> parameter an arbitratily
large value (Dymola window option: \"Simulation/Setup/Stop time\"),
for example, <i>Stop time</i> equals 10.

<li>Run the simulation. Once it is finished, <i>dslog.txt</i> file contains the analysis
results.
</ul>

<h3>AC SWEEP ANALYSIS SIMULATED WITH ORCAD PSPICE AND SPICELIB</h3>
<u1>
<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1ACsweep.png WIDTH=450><br>
<b>Figure 18.</b> AC sweep analysis simulated with ORCAD and SPICELib and errors.<br><br>
</ul>

<H2>Transient (time) analysis (TRAN)</H2>

<ul>

<li>Create a new model, <i>circ1_TRAN</i>, and insert it in <i>circ1</i> package
(see Figure 19).
<IMG SRC=Fig.SPICELib.tutorial.circ1.createCirc1_TRAN.png WIDTH=450><br>
<b>Figure 19.</b> Inserting <i>circ1_TRAN</i> in <i>circ1</i> package.<br><br>

<li>Drag an <i>SPICELib.analyses.TRAN</i> model into the <i>circ1_TRAN</i> model
(see Figure 20).

<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1TRANDiagram.png WIDTH=650><br>
<b>Figure 20.</b> Inserting <i>circ1_TRAN</i> in <i>circ1</i> package.<br><br>

<li>Enter the TRAN analysis parameters (see Figure 21). The meaning of the
analysis parameters is discussed in the SPICELib.analyses.TRAN model documentation.
The <i>SKIPBP</i> parameter determines whether skip or not the bias point calculation.

<br>
<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1TRANParams.png WIDTH=450><br>
<b>Figure 21.</b> TRAN analysis parameters.<br><br>
</ul>

<h3>TRANSIENT ANALYSIS SIMULATED WITH SPICELIB AND ORCAD PSPICE</h3>
<u1>
<IMG SRC=Fig.SPICELib.tutorial.circ1.circ1TRAN.png WIDTH=450><br>
<b>Figure 22.</b> Transient analysis and error.<br><br>
</ul>

</HTML>
"));


annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71, thickness
          =2)), Text(extent=[-70, 30; 80, -24], string="CIRC1")));
end circ1;
