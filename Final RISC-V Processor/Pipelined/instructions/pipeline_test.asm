.text
	addi t0,x0,0x00f
	addi t1,x0,0x123
	addi t2,x0,0x00e
	addi t3,x0,0x00d
	addi t4,x0,0x004
	addi t5,x0,0x0fe
	addi t6,x0,0x7ff
	addi x0,x0,0
	addi x0,x0,0
	sll a5,t0,t4
	add a0,t0,t1
	sub a1,t2,t3
	addi a2,t3,0x004
	xori a3,t3,0x7ff
	sll a4,t6,t4