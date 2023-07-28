.global main

.text
main:
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