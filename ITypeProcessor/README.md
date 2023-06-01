This folder constains simple un-pipelined processor datapath supporting some chosen I-type instructions written in Verilog HDL. Instructions supported are:
1. ADDI
2. ANDI
3. ORI
4. SLLI
5. SRLI
6. LW
 
 In the project instr_mem.v gets its memory initialized by using $readmemh. The simple test assembly program used to test this is:

  I1: andi t3,t2,0x0ff
	I2: slli t4,t3,1
	I3: srli t5,t4,1

Using RARS software these assembly instructions are converted to machine code and saved in the .mem to be read by the instr_mem.v(replace the path location in the instr_mem.v by your path whrere you have saved the .mem, if you want to run it on your system).

Note: As we don't have any supporting instructions to store data to data memory in the data_mem.v we are initializing locations with the values correspoding to their address(address 10 will store the value 10.

The output waveform is as follows: 
![Output](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/ITypeProcessor/I_type_output.png)

