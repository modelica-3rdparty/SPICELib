

package ANALYSES

  model NULL

  end NULL;

  model TotalPowerDissipationCalculation
    outer INTERFACE.PowerDissipation TotalPowerDissipation;
    INTERFACE.PowerDissipation powerDissipation annotation (extent=[0, 0; 0, 0]);
  equation
    connect(powerDissipation, TotalPowerDissipation);
  end TotalPowerDissipationCalculation;

  partial model BiasPointCalculation
    extends INIT.Analysis;
    replaceable model Circuit = NULL;
    extends Circuit;
    // Total power dissipation
    inner INTERFACE.PowerDissipation TotalPowerDissipation;
    TotalPowerDissipationCalculation TPDcal;
    SI.Power totalPowerDissipation;
    // Time-related parameters
    constant Real TIME_SLOT=100 "Percentage of TIME_SCALE";
    SI.Time CLOCK=TIME_SLOT*TIME_SCALE/100;
    // Bias point calculation algorithm
    parameter Real SOLVE_STATIC=0 "OP calculation algorithm: 0, 1, 2 or 3";
    // Local control signals
  protected
    Boolean biasPoint;
    Boolean biasPointCalculated;
    // Time-event variables
    SI.Time timeEvent_startBPC(start=1E100);
    SI.Time timeGMIN(start=0);
    // Buses of control auxiliary variables
    Boolean ctrlDC_Bus[4];
    Boolean ctrlLogDC_Bus[4];
    Boolean ctrlClampDC_Bus[4];
    Boolean biasPointCalc_Bus[4];
    Integer ctrlOPmode_Bus[4];
    Integer ctrlICmode_Bus[4];
  equation
    // --------------------
    // Analysis temperature
    // --------------------
    temp = 300;
    // ----------------------------
    // Start bias point calculation
    // ----------------------------
    when biasPoint then
      timeEvent_startBPC = time;
    end when;
    // ------------------------------------------
    // SOLVE_STATIC == 0 - Static model iteration
    // ------------------------------------------
    ctrlDC_Bus[1] = SOLVE_STATIC == 0 and time > timeEvent_startBPC and not
      time > timeEvent_startBPC + CLOCK;
    ctrlLogDC_Bus[1] = SOLVE_STATIC == 0 and time > timeEvent_startBPC and not
      time > timeEvent_startBPC + CLOCK;
    ctrlClampDC_Bus[1] = SOLVE_STATIC == 0 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + CLOCK;
    biasPointCalc_Bus[1] = SOLVE_STATIC == 0 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + CLOCK;
    ctrlOPmode_Bus[1] = 0;
    ctrlICmode_Bus[1] = 0;
    // -------------------------------------------
    // SOLVE_STATIC == 1 - Static model simulation
    // -------------------------------------------
    ctrlDC_Bus[2] = SOLVE_STATIC == 1 and time > timeEvent_startBPC and not
      time > timeEvent_startBPC + TIME_SCALE + CLOCK;
    ctrlLogDC_Bus[2] = SOLVE_STATIC == 1 and time > timeEvent_startBPC +
      TIME_SCALE and not time > timeEvent_startBPC + TIME_SCALE + CLOCK;
    ctrlClampDC_Bus[2] = SOLVE_STATIC == 1 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + TIME_SCALE + CLOCK;
    biasPointCalc_Bus[2] = SOLVE_STATIC == 1 and time > timeEvent_startBPC +
      TIME_SCALE and not time > timeEvent_startBPC + TIME_SCALE + CLOCK;
    ctrlOPmode_Bus[2] = if SOLVE_STATIC == 1 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + TIME_SCALE then 1 else 0;
    ctrlICmode_Bus[2] = if SOLVE_STATIC == 1 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + TIME_SCALE then 1 else 0;
    // ----------------------------------
    // SOLVE_STATIC == 2 - GMIN algorithm
    // ----------------------------------
    ctrlDC_Bus[3] = SOLVE_STATIC == 2 and time > timeEvent_startBPC and not
      time > timeEvent_startBPC + 12*CLOCK;
    ctrlLogDC_Bus[3] = SOLVE_STATIC == 2 and time > timeEvent_startBPC + 11*
      CLOCK and not time > timeEvent_startBPC + 12*CLOCK;
    ctrlClampDC_Bus[3] = SOLVE_STATIC == 2 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + 12*CLOCK;
    biasPointCalc_Bus[3] = SOLVE_STATIC == 2 and time > timeEvent_startBPC + 11
      *CLOCK and not time > timeEvent_startBPC + 12*CLOCK;
    ctrlOPmode_Bus[3] = 0;
    ctrlICmode_Bus[3] = 0;
    when time > timeEvent_startBPC + pre(timeGMIN) and SOLVE_STATIC == 2 then
      timeGMIN = pre(timeGMIN) + CLOCK;
      scaleGMIN = if time < timeEvent_startBPC + CLOCK/2 then 1E10 else if pre(
        scaleGMIN) > 2 then pre(scaleGMIN)/10 else 1;
    end when;
    // --------------------------------------------
    // SOLVE_STATIC == 3 - Dynamic model simulation
    // --------------------------------------------
    ctrl_IS_TranOP = SOLVE_STATIC == 3 and time > timeEvent_startBPC and not
      time > timeEvent_startBPC + 2*TIME_SCALE + CLOCK;

    ctrlOPmode_Bus[4] = if SOLVE_STATIC == 3 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + TIME_SCALE then 1 else 0;

    ctrl_IS_inhibit = SOLVE_STATIC == 3 and time > timeEvent_startBPC + 2*
      TIME_SCALE and not time > timeEvent_startBPC + 2*TIME_SCALE + CLOCK;

    ctrl_RBREAK_Tran2DC = SOLVE_STATIC == 3 and time > timeEvent_startBPC + 2*
      TIME_SCALE and not time > timeEvent_startBPC + 2*TIME_SCALE + CLOCK;

    ctrlDC_Bus[4] = SOLVE_STATIC == 3 and time > timeEvent_startBPC + 2*
      TIME_SCALE and not time > timeEvent_startBPC + 2*TIME_SCALE + 3*CLOCK;

    ctrlLogDC_Bus[4] = SOLVE_STATIC == 3 and time > timeEvent_startBPC + 2*
      TIME_SCALE + 2*CLOCK and not time > timeEvent_startBPC + 2*TIME_SCALE + 3
      *CLOCK;

    ctrl_CBREAK_resetTran = SOLVE_STATIC == 3 and time > timeEvent_startBPC + 2
      *TIME_SCALE + CLOCK and not time > timeEvent_startBPC + 2*TIME_SCALE + 2*
      CLOCK;

    biasPointCalc_Bus[4] = SOLVE_STATIC == 3 and time > timeEvent_startBPC + 2*
      TIME_SCALE + 2*CLOCK and not time > timeEvent_startBPC + 2*TIME_SCALE + 3
      *CLOCK;

    ctrl_IC_clampTran = SOLVE_STATIC == 3 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + CLOCK + 2*TIME_SCALE;

    ctrlICmode_Bus[4] = if SOLVE_STATIC == 3 and time > timeEvent_startBPC and
      not time > timeEvent_startBPC + TIME_SCALE then 1 else 0;

    ctrlClampDC_Bus[4] = SOLVE_STATIC == 3 and time > timeEvent_startBPC + 2*
      TIME_SCALE + CLOCK and not time > timeEvent_startBPC + 2*TIME_SCALE + 3*
      CLOCK;

    // --------------------------------
    // Logic-OR of control signal buses
    // --------------------------------
    ctrl_log_DC = ctrlLogDC_Bus[1] or ctrlLogDC_Bus[2] or ctrlLogDC_Bus[3] or
      ctrlLogDC_Bus[4];
    biasPointCalculated = biasPointCalc_Bus[1] or biasPointCalc_Bus[2] or
      biasPointCalc_Bus[3] or biasPointCalc_Bus[4];
    ctrl_DC = ctrlDC_Bus[1] or ctrlDC_Bus[2] or ctrlDC_Bus[3] or ctrlDC_Bus[4];
    ctrl_IC_clampDC = ctrlClampDC_Bus[1] or ctrlClampDC_Bus[2] or
      ctrlClampDC_Bus[3] or ctrlClampDC_Bus[4];
    ctrl_OP_mode = max(ctrlOPmode_Bus);
    ctrl_IC_mode = max(ctrlICmode_Bus);
    // --------------
    // OP results log
    // --------------
    when ctrl_log_DC then
      LogVariable(ctrl_log_DC);
      totalPowerDissipation = -TPDcal.powerDissipation.dissipatedPower;
      LogVariable(totalPowerDissipation);
    end when;

  end BiasPointCalculation;

  model OP
    extends BiasPointCalculation;
  protected
    SI.Time timeEvent_finishOP(start=1E100);
  equation
    // ---------------------------
    // Control signals do not used
    // ---------------------------
    ctrl_Tran = false;
    ctrl_CBREAK_Tran2IC = false;
    ctrl_CBREAK_Tran2DC = false;
    ctrl_AC = false;
    ctrl_log_AC = false;
    freq = 1E-6;
    // ----------------------
    // Bias point calculation
    // ----------------------
    when initial() then
      biasPoint = true;
      ctrl_OP_value = 0;
    end when;
    // ------------------
    // Finish OP analysis
    // ------------------
    when biasPointCalculated then
      timeEvent_finishOP = time + CLOCK;
    end when;
    when time > timeEvent_finishOP then
      terminate(
        "-----------------------\nFinished OP calculation\n-----------------------");
    end when;

  end OP;

  model TRAN
    extends BiasPointCalculation;
    parameter SI.Time TSTOP "Transient simulation end time";
    parameter Boolean SKIPBP=false "Skip initial transient solution";
    SI.Time TIME(start=-1) "Transient simulation time variable";
  protected
    SI.Time timeEvent_startTran(start=1E100);
  equation
    // ---------------------------
    // Control signals do not used
    // ---------------------------
    ctrl_AC = false;
    ctrl_log_AC = false;
    freq = 1E-6;
    // --------------------------
    // Initial transient solution
    // --------------------------
    when initial() and not SKIPBP then
      biasPoint = true;
    end when;
    ctrl_OP_value = if not (time > timeEvent_startTran + CLOCK and not time >
      timeEvent_startTran + TSTOP + CLOCK) then 1 else 0;
    // ------------------
    // Transient analysis
    // ------------------
    when biasPointCalculated and not SKIPBP or initial() and SKIPBP then
      timeEvent_startTran = time;
    end when;

    ctrl_Tran = time > timeEvent_startTran and not time > timeEvent_startTran
       + TSTOP + CLOCK;
    TIME = if ctrl_Tran then time - timeEvent_startTran else -1;

    // ----------------------------
    // Dynamic model initialization
    // ----------------------------
    ctrl_CBREAK_Tran2IC = SKIPBP and time > timeEvent_startTran and not time >
      timeEvent_startTran + CLOCK;

    ctrl_CBREAK_Tran2DC = not SKIPBP and time > timeEvent_startTran and not
      time > timeEvent_startTran + CLOCK;
    // -------------------------
    // Finish transient analysis
    // -------------------------
    when time > timeEvent_startTran + TSTOP then
      terminate(
        "------------------------\nFinished TRAN simulation\n------------------------");
    end when;

  end TRAN;

  model AC
    extends BiasPointCalculation;
    // Frequency sweep parameters
    parameter Integer TYPE_AC_SWEEP(
      start=0,
      min=0,
      max=1) "0: LIN; 1: DEC";
    parameter Integer POINTS_NUMBER(start=11) "LIN: total. DEC: points/decade";
    parameter SI.Frequency START_FREQUENCY;
    parameter SI.Frequency END_FREQUENCY;
    // Time-related auxiliary variables
    Real log10Freq;
  protected
    SI.Time timeStartAC(start=1E100);
    SI.Time timeEndAC(start=1E100);
    SI.Time timeAClog(start=0);
  equation
    // log10Freq = log10 (freq)
    // ---------------------------
    // Control signals do not used
    // ---------------------------
    ctrl_Tran = false;
    ctrl_CBREAK_Tran2IC = false;
    ctrl_CBREAK_Tran2DC = false;
    // ----------------------
    // Bias point calculation
    // ----------------------
    when initial() then
      biasPoint = true;
      ctrl_OP_value = 0;
    end when;
    // ---------------
    // Frequency sweep
    // ---------------
    when biasPointCalculated then
      ctrl_AC = true;
      timeStartAC = time;
    end when;
    0 = if TYPE_AC_SWEEP == 0 and ctrl_AC then freq - (END_FREQUENCY -
      START_FREQUENCY)*(time - timeStartAC)/((POINTS_NUMBER - 1)*2*CLOCK) -
      START_FREQUENCY else if TYPE_AC_SWEEP == 1 and ctrl_AC then log10Freq - (
      ln(END_FREQUENCY) - ln(START_FREQUENCY))/ln(10)*(time - timeStartAC)/(((
      ln(END_FREQUENCY) - ln(START_FREQUENCY))/ln(10)*(POINTS_NUMBER) - 1)*2*
      CLOCK) - ln(START_FREQUENCY)/ln(10) else freq - 1E-6;
    log10Freq = if ctrl_AC then ln(freq)/ln(10) else -1E100;
    // -----------
    // Log results
    // -----------
    when time > pre(timeAClog) and ctrl_AC then
      LogVariable(freq);
      timeAClog = time + 2*CLOCK;
    end when;
    ctrl_log_AC = not time > timeAClog - CLOCK and ctrl_AC;
    // ------------------
    // Finish AC analysis
    // ------------------
    when freq > END_FREQUENCY then
      timeEndAC = time + CLOCK;
    end when;
    when time > timeEndAC then
      terminate(
        "--------------------\nFinished AC analysis\n--------------------");
    end when;
  end AC;

  annotation (Icon(Rectangle(extent=[-80, 60; 80, -60], style(color=71,
            thickness=2)), Text(extent=[-74, 26; 76, -30], string="ANALYSES")));
end ANALYSES;
