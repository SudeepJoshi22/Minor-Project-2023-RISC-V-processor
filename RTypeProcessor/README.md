This folder constains simple un-pipelined and pipelined processor datapaths supporting some chosen R-type instructions written in Verilog HDL.
Instructions supported are:
1. ADD
2. SUB
3. AND
4. OR
5. SLL
6. SRL
In the project instr_mem.v gets its memory initialized by using $readmemh.


The simple test assembly program used to test this is:
Markup:
	*add t0,t1,t2
	*sub t0,t1,t2
	*and t0,t1,t2
	*or  t0,t1,t2
	*sll t0,t1,t2
	*srl t0,t1,t2

Using RARS software these assembly instructions are converted to machine code and saved in the .mem to be read by the instr_mem.v(replace the path location in the instr_mem.v by your path whrere you have saved the .mem,
if you want to run it on your system).

Note: As we don't have any supporting instructions to load data to registers in the reg_file.v we are initializing registors x0-x31 with the values correspoding to their index(ex: x2 is initialized with 2).

The output waveform is as follows:
![Screenshot](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/RTypeProcessor/R_type_output.png)
