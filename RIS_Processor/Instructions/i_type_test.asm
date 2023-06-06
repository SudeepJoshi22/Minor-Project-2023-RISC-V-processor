.global main

.text
main:
	andi t3,t2,0x0ff
	slli t4,t3,1
	srli t5,t4,1