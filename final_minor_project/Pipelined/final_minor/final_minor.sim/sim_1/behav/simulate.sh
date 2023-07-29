#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2014.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim branch_pred_unit_tb_behav -key {Behavioral:sim_1:Functional:branch_pred_unit_tb} -tclbatch branch_pred_unit_tb.tcl -log simulate.log
