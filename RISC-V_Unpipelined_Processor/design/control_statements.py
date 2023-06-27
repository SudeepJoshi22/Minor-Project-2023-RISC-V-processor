import pandas as pd

table = pd.read_excel('Instruction Decoding Table.xls')

(r,c) = table.shape

i_type_c = "X" #current instruction type
i_type_n = "Y" #next instructions type

code = open("control_code.txt",'w')
for i in range(r):
    i_type_n = table.Type[i]
    if i_type_n != i_type_c:
        code.write(f"{i_type_n}:\n")
    i_type_c = i_type_n
    if table.func7[i] == "-":
        #print("func7 not present")
        code.write(f"\t else if(func3 == 3'b{table.func3[i][1:-1]}) {{RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,branch,jump}} <= 14'b{table.RegWrite[i][1:-1]}_{table.alu_ctrl[i][1:-1]}_{table.rw[i][1:-1]}_{table.MemtoReg[i][1:-1]}_{table.AluSrc[i][1:-1]}_{table.whb[i][1:-1]}_{table.su[i][1:-1]}_{table.wos[i][1:-1]}_{table.branch[i][1:-1]}_{table.jump[i][1:-1]}; //{table.Instructions[i]} \n")
    else:
        code.write(f"\t else if(func3 == 3'b{table.func3[i][1:-1]} && func7 == 7'b{table.func7[i][1:-1]}) {{RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,branch,jump}} <= 14'b{table.RegWrite[i][1:-1]}_{table.alu_ctrl[i][1:-1]}_{table.rw[i][1:-1]}_{table.MemtoReg[i][1:-1]}_{table.AluSrc[i][1:-1]}_{table.whb[i][1:-1]}_{table.su[i][1:-1]}_{table.wos[i][1:-1]}_{table.branch[i][1:-1]}_{table.jump[i][1:-1]}; //{table.Instructions[i]} \n")
  
code.close()
