encapsulated package SPICELib "A Library for Modeling & Analysis of Electric Circuits in Modelica"


import SI = Modelica.SIunits;

import nonSI = Modelica.SIunits.Conversions.NonSIunits;


annotation (
  Window(
    x=0.03,
    y=0.02,
    width=0.24,
    height=0.45,
    library=1,
    autolayout=1),
  Documentation(info="<html>

<H2 align=center><i>SPICE</i>Lib - Modeling & Analysis of Electric Circuits</H2>
<H4 align=center>Release 1.1 (October, 2003)</H4><BR><BR>

<b>Authors</b><br>
<i>Alfonso Urquia</i><br>
<i>Carla Martin</i><br>
Department of Computer Science and Automatic Control, UNED<br>
Madrid, Spain <br>
email: <A HREF=\"mailto:aurquia@dia.uned.es\">aurquia@dia.uned.es</A>,
<A HREF=\"mailto:carla@dia.uned.es\">carla@dia.uned.es</A><br>
<br>

<p><i>SPICE</i>Lib is a set of model libraries, written in Modelica language, that supports
some of the modeling and analysis capabilities of the circuit simulator PSPICE.</p>

<ul><li><b>Device types</b> supported by <i>SPICE</i>Lib are described in the documentation
of <i>parts</i> package. Library users should use the models of this package to compose
their circuits.<br><br>
<li>See the <i>analyses</i> package documentation for a detailed discussion of the
<b>analyses</b> supported by <i>SPICE</i>Lib.<br><br>
<li><i>tutorial</i> package contains some introductory <b>examples</b> showing how to run
each type of analysis.<br><br>
<li><i>src</i> package contains the <i>SPICE</i>Lib source code and the library
designer documentation.
<b>Only library designers should use or modify this package models</b>.

</ul>

<i>SPICE</i>Lib package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b> (http://www.modelica.org/library/ModelicaLicense.html).
<br><br>

<p><H2 align=left>Known Problems</H4></p>
We have detected some differences between the MOSFET small-signal description of <i>SPICE</i>Lib and
ORCAD PSPICE.<br>
<i>SPICE</i>Lib results of AC sweep analysis, when applied to circuits containing MOS transistor, should
be taken carefully.<br>

<p><H2 align=left>Release Notes</H4></p>

<TABLE BORDER=2 CELLSPACING=0 WIDTH=\"100%\" CELLPADDING=5>
<TR><TH align=center><b>Version</b></TH>
<TH align=center><b>Comments</b></TH></TR>
<TR><TD>1.0<br>(Jan, 2002)</TD>
<TD><b>Analyses:</b> OP, AC and TRAN.<br>
<b>Parts:</b>Ground, Rbreak, Cbreak, Spice2MOS1, Vsource, ISource, IC1 and IC2.</TD></TR>
<TR><TD>1.1<br>(Oct, 2003)</TD>
<TD><b>Analyses:</b> OP, AC and TRAN.<br>
<b>Parts:</b>Ground, Rbreak, Cbreak, Lbreak, PSPICE_diode, Spice2MOS1, Spice2MOS1P,
V, VEXP, VPULSE, VPWL, VSIN, VCONST, I, IEXP, IPULSE, ISIN,ICONST, E, F, G, H, IC1 and IC2.</TD></TR>
</TABLE><br>

<p><H2 align=left>References</H4></p>
<p>Cellier, F. E. (1991): <i>Continuous System Modeling.</i> Spring-Verlag.</p>
<p>Elmqvist, H. et al (2002): <i>Dymola. User's Manual.</i> Dynasim AB.Version 5.0a.</p>
<p>Kielkowski, R. M. (1998): <i>Inside SPICE.</i> McGraw-Hill, Inc. Second Edition.</p>
<p>Martin C., Urquia A. and Dormido S. (2003): <i>SPICELib- Modeling & Analysis of Electric Circuits
with Modelica. </i>3<sup>rd</sup> International Modelica Conference, November 3-4, 2003,
Linkoping, Sweeden.</p>
<p>Massobrio, G. and Antognetti, P. (1993): <i>Semiconductor Device Modeling with SPICE.</i>
McGraw-Hill, Inc.</p>
<p>Orcad (1999): <i>Orcad PSpice A/D. User's Guide.</i> Online edition 15 November 1999.</p>
<p>Orcad (1999): <i>Orcad PSpice A/D. Reference Guide.</i> Version 9.1, November, 1999.</p>
<p>Modelica Association: <i>Modelica. Language specification.</i> Version 2.0, July 10, 2002.</p>
<p> Urquia, A. and Dormido, S. (2002): <i>DC, AC Small-Signal and Transient Analysis of Level1 N-Channel
MOSFET with Modelica. </i>2<sup>nd</sup> International Modelica Conference, March 18-19, 2002,
Oberpfaffenhogen, Germany. Proceedings, pp. 99-108.</p>


</HTML>
"),
  Icon(Text(extent=[-70, 68; 74, -72], string="SPICELib"), Rectangle(extent=[
          -80, 60; 80, -60], style(color=61, thickness=2))));
end SPICELib;
