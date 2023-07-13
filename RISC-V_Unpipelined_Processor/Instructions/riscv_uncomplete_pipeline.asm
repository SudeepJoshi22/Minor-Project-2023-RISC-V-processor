.global main

.text
main:
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
	lui t1,0x800ff
        auipc t2,-100
	beq t0,t1,loc
        bne t0,t1,loc
        blt t0,t1,loc
        bge t0,t1,loc
        bltu t0,t1,loc
        bgeu t0,t1,loc
        jal t1,loc
        jalr t1,t2,0x01
        
        loc:
        addi t3,t1,100
