

package INIT

  partial model Analysis
    // Control signals
    inner Boolean ctrl_AC;
    inner Boolean ctrl_CBREAK_resetTran;
    inner Boolean ctrl_CBREAK_Tran2DC;
    inner Boolean ctrl_CBREAK_Tran2IC;
    inner Boolean ctrl_DC;
    inner Boolean ctrl_IC_clampDC;
    inner Boolean ctrl_IC_clampTran;
    inner Integer ctrl_IC_mode(min=0, max=1);
    inner Boolean ctrl_IS_inhibit;
    inner Boolean ctrl_IS_TranOP;
    inner Boolean ctrl_log_AC;
    inner Boolean ctrl_log_DC;
    inner Integer ctrl_OP_mode(min=0, max=1);
    inner Integer ctrl_OP_value(min=0, max=1);
    inner Boolean ctrl_RBREAK_Tran2DC;
    inner Boolean ctrl_Tran;
    // Global variables
    inner Real scaleGMIN(start=1) "Scale factor of GMIN algorithm";
    inner SI.Frequency freq(start=1E-6) "AC small-signal analysis frequency";
    inner SI.Temp_K temp(start=300) "Analysis temperature";
    // Global parameters
    parameter SI.Time TimeScale "Time scale";
    parameter Integer LogResults(min=0, max=2) "Log variables mode";
    parameter SI.Conductance Gmin=1e-12
      "Conductance in parallel with the pn-junction";
    inner SI.Time TIME_SCALE=TimeScale;
    inner Integer LOG_RESULTS=LogResults;
    inner SI.Conductance GMIN=Gmin;
  end Analysis;

  partial model Part
    // Control signals
    outer Boolean ctrl_AC;
    outer Boolean ctrl_CBREAK_resetTran;
    outer Boolean ctrl_CBREAK_Tran2DC;
    outer Boolean ctrl_CBREAK_Tran2IC;
    outer Boolean ctrl_DC;
    outer Boolean ctrl_IC_clampDC;
    outer Boolean ctrl_IC_clampTran;
    outer Integer ctrl_IC_mode(min=0, max=1);
    outer Boolean ctrl_IS_inhibit;
    outer Boolean ctrl_IS_TranOP;
    outer Boolean ctrl_log_AC;
    outer Boolean ctrl_log_DC;
    outer Integer ctrl_OP_mode(min=0, max=1);
    outer Integer ctrl_OP_value(min=0, max=1);
    outer Boolean ctrl_RBREAK_Tran2DC;
    outer Boolean ctrl_Tran;
    // Global variables
    outer Real scaleGMIN(start=1) "Scale factor of GMIN algorithm";
    outer SI.Frequency freq(start=1E-6) "AC small-signal analysis frequency";
    outer SI.Temp_K temp(start=300) "Analysis temperature";
    // Global parameters
    outer SI.Time TIME_SCALE "Time scale";
    outer Integer LOG_RESULTS "Log variables mode";
    outer SI.Conductance GMIN "Conductance in parallel with the pn-junction";
  end Part;

  annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71,
            thickness=2)), Text(
        extent=[-66, 32; 60, -36],
        style(thickness=2),
        string="INIT")));
end INIT;

