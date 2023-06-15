This folder constains simple un-pipelined processor datapath supporting some chosen R-type, I-type and S-type instructions written in Verilog HDL. Instructions supported are:
1. ADD
2. SUB
3. SLL
4. SRL
5. XOR
6. AND
7. OR
8. ADDI
9. SLLI
10. SRLI
11. XORI
12. ANDI
13. ORI
14. LW
15. LH
16. LB
17. SW
18. SH
19. SB

 In the project instr_mem.v gets its memory initialized by using $readmemh. The simple test assembly program used to test this is:
addi t0,zero,0x07ff
* slli t1,t0,0xf
* add t1,t1,t0
* srli t0,t0,0x8
* xori t0,t0,0x7ff
* andi t0,t0,0x7f0
* ori t0,t0,0x0ff
* sw t1,0(zero)
* sh t1,4(zero)
* sb t1,8(zero)
* lb t2,4(zero)
* lw t3,8(zero)
* lh t4,0(zero)
* add t2,t3,t4
* sub t3,t2,t4
* sll t3,t4,t2
* srl t3,t4,t2
* xor t2,t3,t4
* and t2,t3,t4
* or t2,t3,t4

Using RARS software these assembly instructions are converted to machine code and saved in the .mem to be read by the instr_mem.v(replace the path location in the instr_mem.v by your path whrere you have saved the .mem, if you want to run it on your system).

The Output waveform is as follows:
* ![Screenshot](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/RIS_Minimal_Processor/Vivado_output_1.png)
* ![Screenshot](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/RIS_Minimal_Processor/Vivado_output_2.png)
* ![Screenshot](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/RIS_Minimal_Processor/Vivado_output_3.png)
