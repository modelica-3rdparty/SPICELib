# SPICELib
Free library with some of the modeling and analysis capabilities of the electric circuit simulator PSPICE.

## Library description

`SPICELib` is a set of model libraries, written in Modelica language, that supports some of the modeling and analysis capabilities of the circuit simulator PSPICE.

* *Device types* supported by SPICELib are described in the documentation of the `parts` package. Library users should use the models of this package to compose their circuits.
* See the `analyses` package documentation for a detailed discussion of the analyses supported by `SPICELib`.
* The `tutorial` package contains some introductory examples showing how to run each type of analysis.
* The `src` package contains the SPICELib source code and the library designer documentation. Only library designers should use or modify this package models.

*This library was presented during the Modelica'2003 Conference.*

### Known Problems

We have detected some differences between the MOSFET small-signal description of SPICELib and ORCAD PSPICE.
`SPICELib` results of AC sweep analysis, when applied to circuits containing MOS transistor, should be taken carefully.

## Current release

Download [SPICELib v1.1 (2003-10-14)](../../archive/v1.1.zip)

#### Release notes

* [Version v1.1 (2003-10-14)](../../archive/v1.1.zip)
  * **Analyses**: OP, AC and TRAN.
  * **Parts**: Ground, Rbreak, Cbreak, Lbreak, PSPICE_diode, Spice2MOS1, Spice2MOS1P, V, VEXP, VPULSE, VPWL, VSIN, VCONST, I, IEXP, IPULSE, ISIN,ICONST, E, F, G, H, IC1 and IC2.

## License

This Modelica package is free software and the use is completely at your own risk;
it can be redistributed and/or modified under the terms of the [Modelica License 2](https://modelica.org/licenses/ModelicaLicense2).

## Development and contribution
Authors:
 - [Alfonso Urquia](mailto:aurquia@dia.uned.es)
 - [Carla Martin](mailto:carla@dia.uned.es)

    Department of Computer Science and Automatic Control, UNED
    Madrid, Spain
