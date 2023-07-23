.global main

.text
main:
<<<<<<< HEAD:RISC-V_Unpipelined_Processor/Instructions/riscv_uncomplete_pipeline.asm
	lui t1,0x800ff
	auipc t1,1000
	jalr a0,x0,0x14
	addi t2,x0,10
	slli t2,t2,10

	addi t1,x0,0xff
	addi t0,x0,0xfe
	
	beq t0,t1,loc
	blt t1,t0,loc
	bltu t1,t0,loc
	back:
	bne t0,t1,loc
	bge t2,t1,loc
	addi t0,x0,-100
	bgeu t0,t1,loc
	addi t0,x0,100
	loc:
	addi t1,x0,0xfe
	addi t2,x0,0xff
	jal t2,back
=======
	addi t0,zero,0x07ff
	slli t1,t0,0xf
	add t1,t1,t0
	srli t0,t0,0x8
	xori t0,t0,0x7ff
	andi t0,t0,0x7f0
	ori t0,t0,0x0ff
	sw t1,0(zero)
	sh t1,4(zero)
	sb t1,8(zero)
	lb t2,4(zero)
	lw t3,8(zero)
	lh t4,0(zero)
	lhu t4,0(zero)
	lbu t2,4(zero)
	add t2,t3,t4
	sub t3,t2,t4
	sll t3,t4,t2
	srl t3,t4,t2
	slli t0,t1,0x006
	sra t0,t0,t2
	slt t3,t4,t2
	sltu t3,t2,t4
	slti t3,t2,0x001
	sltiu t3,t3,0x7ff
	xor t2,t3,t4
	and t2,t3,t4
	or t2,t3,t4
>>>>>>> 4e0830f4901d8bbec00a03eb2adbf3ff9098ca97:Final RISC-V Processor/Unpipelined/instructions/ris_complete_test.asm
