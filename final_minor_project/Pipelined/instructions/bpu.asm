
#TEST 1
#FOR LOOP

addi s1, zero, 5
addi s0, zero, 0
loop1:
addi s0, s0, 1
bne s0, s1, loop1 #BRANCH1 = 0x0000c
# should add to buffer, predict taken x 3, mispredict taken


#TEST 2
#NESTED FOR LOOP

addi s7, zero, 3
addi s6, zero, 0
loop3:


addi s2, zero, 5
loop2:
addi s2, s2, -1
beq s2, zero, done #BRANCH2 = 0x000020
j loop2
done:

addi s6, s6, 1
bne s6, s7, loop3 #BRANCH3 = 0x00002c


addi t0, zero, 555

#first run of loop3:

#branch 2 is not taken and not added to buffer x4
#on last iteration is taken and added as weakly taken

#branch 3 is added as weakly taken


#second run of loop3

# branch 2 is mispredicted taken, then updated to predict weakly not taken
# correctly predict not taken x 3, now strongly not taken
# mispredict not taken, now weakly not taken

#branch 3 is predicted taken, now strongly taken


#third run of loop3

#branch 3 is predicted not taken, now strongly not taken
#branch 3 predict not taken x3
#mispredict not taken, now weakly not taken

#branch 3 is mispredicted taken