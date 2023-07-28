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
ExecStep $xv_path/bin/xsim top_module_tb_behav -key {Behavioral:sim_1:Functional:top_module_tb} -tclbatch top_module_tb.tcl -log simulate.log
