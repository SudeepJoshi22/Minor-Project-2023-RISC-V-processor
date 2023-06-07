This folder constains simple un-pipelined processor datapath supporting some chosen I-type instructions written in Verilog HDL. Instructions supported are:
1. ADDI
2. ANDI
3. ORI
4. SLLI
5. SRLI
6. LW
 
 In the project instr_mem.v gets its memory initialized by using $readmemh. The simple test assembly program used to test this is:
* lw t1,0(t0)
* addi t0,t1,0x123
* andi t0,t1,0x00f
* ori t0,t1,0x0f0
* slli t0,t1,0x001
* srli t0,t1,0x001

Using RARS software these assembly instructions are converted to machine code and saved in the .mem to be read by the instr_mem.v(replace the path location in the instr_mem.v by your path whrere you have saved the .mem, if you want to run it on your system).

Note: As we don't have any supporting instructions to store data to data memory in the data_mem.v we are initializing locations with the values correspoding to their address(address 10 will store the value 10.

The output waveform is as follows: 
![Output](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/ITypeProcessor/i_type_vivado.png)

