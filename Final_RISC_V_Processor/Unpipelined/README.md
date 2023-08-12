This Version of the Processor is supporting all the Instructions under the RV32I ISA. The Processor has been converted into a top core.v module where the seperate stages have been defined under different modules,
namely IF.v, ID.v, EX.v, MEM.v, WB.v.
Complete Architecture:
![archi](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/Final_RISC_V_Processor/Unpipelined/unpipeline.png)
core.v Module:
![core](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/Final_RISC_V_Processor/Unpipelined/CORE.drawio.png)

The test program to test Branchs, Jumps and Upper-type instructions are:
![test](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/Final_RISC_V_Processor/Unpipelined/branch_test_program.png)
This program must loop back indefinitely as shwn in the RARS output below.
![output](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/Final_RISC_V_Processor/Unpipelined/Screencast%20from%2004-08-23%2001%2040%2022%20AM%20IST(1).gif)

In the Vivado output below we can see that the PC is repeatedly taking jumps from 44 -> 28.
![vivado_op](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/Final_RISC_V_Processor/Unpipelined/unpipelined_output.png)

