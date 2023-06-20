This folder constains simple un-pipelined processor datapath supporting all R-type, I-type and S-type instructions written in Verilog HDL. Instructions supported are:
1. ADD
2. SUB
3. SLL
4. SRL
5. XOR
6. AND
6. OR
7. SRA 
8. SLT 
9. SLTU 
10. ADDI
11. SLLI
12. SRLI
13. XORI
14. ANDI
15. ORI
16. SLTI
17. SLTIU
18. SRAI
19. LW
20. LH
21. LB
22. LBU
23. LHU
24. SW
25. SH
26. SB


 In the project instr_mem.v gets its memory initialized by using $readmemh. 
 
 Simple test assembly program used to test:
 
* addi t0,zero,0x07ff
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
* lhu t4,0(zero)
* lbu t2,4(zero)
* add t2,t3,t4
* sub t3,t2,t4
* sll t3,t4,t2
* srl t3,t4,t2
* slli t0,t1,0x006
* sra t0,t0,t2
* slt t3,t4,t2
* sltu t3,t2,t4
* slti t3,t2,0x001
* sltiu t3,t3,0x7ff
* xor t2,t3,t4
* and t2,t3,t4
* or t2,t3,t4

Using RARS software these assembly instructions are converted to machine code and saved in the .mem to be read by the instr_mem.v(replace the path location in the instr_mem.v by your path whrere you have saved the .mem, if you want to run it on your system).

The Output waveform is as follows:
* ![Screenshot](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/RIS_Complete_Processor/complete_ris1.png)
* ![Screenshot](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/RIS_Complete_Processor/complete_ris2.png)
* ![Screenshot](https://github.com/SudeepJoshi22/Minor-Project-2023-RISC-V-processor/blob/master/RIS_Complete_Processor/complete_ris3.png)


