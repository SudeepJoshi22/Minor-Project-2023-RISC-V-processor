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
ExecStep $xv_path/bin/xelab -wto 152242e094414545a04bc79ae1f82389 -m64 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot branch_pred_unit_tb_behav xil_defaultlib.branch_pred_unit_tb xil_defaultlib.glbl -log elaborate.log
