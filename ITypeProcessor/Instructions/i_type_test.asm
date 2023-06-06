.global main

.text 
main:
	lw t1,0(t0)
	addi t0,t1,0x123
	andi t0,t1,0x00f
	ori t0,t1,0x0f0
	slli t0,t1,0x001
	srli t0,t1,0x001
