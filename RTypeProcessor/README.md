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
.global main

.text
main:
	add t2, t0, t1 
	sub s0, t0, t1 
	and s1, t0, t1 
	sll t6,t4,s1

Using RARS software these assembly instructions are converted to machine code and saved in the .mem to be read by the instr_mem.v(replace the path location in the instr_mem.v by your path whrere you have saved the .mem,
if you want to run it on your system).

Note: As we don't have any supporting instructions to load data to registers in the reg_file.v we are initializing registors x0-x31 with the values correspoding to their index(ex: x2 is initialized with 2).

The output waveform is as follows:
