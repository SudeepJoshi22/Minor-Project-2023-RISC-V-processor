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
	add t2,t3,t4
	sub t3,t2,t4
	sll t3,t4,t2
	srl t3,t4,t2
	xor t2,t3,t4
	and t2,t3,t4
	or t2,t3,t4
	