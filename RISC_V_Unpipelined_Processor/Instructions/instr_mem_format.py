dump = open('risc_v_unpipeline.txt','r')
instr = dump.read()
code = []

mem = open('dump.mem','w')
ii = 0
while ii < len(instr):
    if(instr[ii] == 'i'):
        ii += 5
        while instr[ii] != '\n':
            code.append(instr[ii])
            ii += 1
        while len(code) != 8:
            code.insert(0,'0')
        mem.write(f"{code[6]}{code[7]} {code[4]}{code[5]} {code[2]}{code[3]} {code[0]}{code[1]}\n")
        print(code)
        
    code = []
    ii += 1
mem.close()
