`timescale 1ns / 1ps
`default_nettype none

module control_unit(
input wire [31:0] instr,
output reg [3:0] alu_ctrl,
output reg [1:0] whb,
output reg su,
output reg [1:0]wos
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,B=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

wire [2:0] func3;
wire [6:0] func7;
wire [6:0] opcode;

assign func3 = instr[14:12];
assign func7 = instr[31:25];
assign opcode = instr[6:0];

always @(*)
<<<<<<< HEAD
begin
    case(opcode)
    R:
         if(func3 == 3'b000 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_x_0_0_10_1_01_0_0; //ADD 
         else if(func3 == 3'b000 && func7 == 7'b0100000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0001_x_0_0_10_1_01_0_0; //SUB 
         else if(func3 == 3'b001 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1010_x_0_0_10_1_01_0_0; //SLL 
         else if(func3 == 3'b101 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1001_x_0_0_10_1_01_0_0; //SRL 
         else if(func3 == 3'b100 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1000_x_0_0_10_1_01_0_0; //XOR 
         else if(func3 == 3'b111 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0010_x_0_0_10_1_01_0_0; //AND 
         else if(func3 == 3'b110 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0100_x_0_0_10_1_01_0_0; //OR 
         else if(func3 == 3'b101 && func7 == 7'b0100000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1100_x_0_0_10_1_01_0_0; //SRA  
         else if(func3 == 3'b010 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0001_x_0_0_10_1_00_0_0; //SLT  
         else if(func3 == 3'b011 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0001_x_0_0_10_1_00_0_0; //SLTU  
    I1:
         if(func3 == 3'b000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_x_0_1_10_1_01_0_0; //ADDI 
         else if(func3 == 3'b001 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1010_x_0_1_10_1_01_0_0; //SLLI 
         else if(func3 == 3'b101 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1001_x_0_1_10_1_01_0_0; //SRLI 
         else if(func3 == 3'b100) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1000_x_0_1_10_1_01_0_0; //XORI 
         else if(func3 == 3'b111) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0010_x_0_1_10_1_01_0_0; //ANDI 
         else if(func3 == 3'b110) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0100_x_0_1_10_1_01_0_0; //ORI 
         else if(func3 == 3'b101) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0001_x_0_1_10_1_00_0_0; //SLTI 
         else if(func3 == 3'b011) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0001_x_0_1_10_1_00_0_0; //SLTIU 
         else if(func3 == 3'b101 && func7 == 7'b0100000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1100_x_0_1_10_1_01_0_0; //SRAI 
    I2:
         if(func3 == 3'b010) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_1_1_1_10_1_01_0_0; //LW 
         else if(func3 == 3'b001) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_1_1_1_01_1_01_0_0; //LH 
         else if(func3 == 3'b000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_1_1_1_00_1_01_0_0; //LB 
         else if(func3 == 3'b100) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_1_1_1_00_0_01_0_0; //LBU 
         else if(func3 == 3'b101) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_1_1_1_01_0_01_0_0; //LHU 
    S:
         if(func3 == 3'b010) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0000_0_0_1_10_1_01_0_0; //SW 
         else if(func3 == 3'b001) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0000_0_0_1_01_1_01_0_0; //SH 
         else if(func3 == 3'b000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0000_0_0_1_00_1_01_0_0; //SB 
    B:
         if(func3 == 3'b000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0001_x_x_0_10_1_01_1_0; //BEQ 
         else if(func3 == 3'b001) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0001_x_x_0_10_1_01_1_0; //BNE  
         else if(func3 == 3'b100) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0001_x_x_0_10_1_01_1_0; //BLT 
         else if(func3 == 3'b101) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0001_x_x_0_10_1_01_1_0; //BGE 
         else if(func3 == 3'b110) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0001_x_x_0_10_0_01_1_0; //BLTU 
         else if(func3 == 3'b111) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b0_0001_x_x_0_10_0_01_1_0; //BGEU 
    JR:
         if(func3 == 3'b000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_x_x_1_10_1_10_1_1; //JALR 
    J:
         {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_x_x_1_10_1_10_1_0; //JAL 
    U:
         {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_1101_x_0_1_10_1_01_0_0; //LUI 
    UPC:
         {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <= 15'b1_0000_1_1_1_10_1_01_0_0; //AUIPC 
     default:                    
          {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos,boj,jalr} <=15'bx_xxxx_x_x_x_xx_x_xx_x_x; 
=======
    begin
        case(opcode)
            R:   
                if(func3 == 3'b000 && func7 == 7'b0000000) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //ADD 
                else if(func3 == 3'b000 && func7 == 7'b0100000)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_01; //SUB 
                else if(func3 == 3'b001 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1010_10_1_01; //SLL 
                else if(func3 == 3'b101 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1001_10_1_01; //SRL 
                else if(func3 == 3'b100 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1000_10_1_01; //XOR 
                else if(func3 == 3'b111 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b0010_10_1_01; //AND 
                else if(func3 == 3'b110 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b0100_10_1_01; //OR 
                else if(func3 == 3'b101 && func7 == 7'b0100000)
                    {alu_ctrl,whb,su,wos} <= 9'b1100_10_1_01; //SRA  
                else if(func3 == 3'b010 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_00; //SLT  
                else if(func3 == 3'b011 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_00; //SLTU  
                else 
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;
>>>>>>> 4e0830f4901d8bbec00a03eb2adbf3ff9098ca97
        
            I1:
                if(func3 == 3'b000) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //ADDI 
                else if(func3 == 3'b001 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1010_10_1_01; //SLLI 
                else if(func3 == 3'b101 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1001_10_1_01; //SRLI 
                else if(func3 == 3'b100)
                    {alu_ctrl,whb,su,wos} <= 9'b1000_10_1_01; //XORI 
                else if(func3 == 3'b111)
                    {alu_ctrl,whb,su,wos} <= 9'b0010_10_1_01; //ANDI 
                else if(func3 == 3'b110)
                    {alu_ctrl,whb,su,wos} <= 9'b0100_10_1_01; //ORI 
                else if(func3 == 3'b010)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_00; //SLTI 
                else if(func3 == 3'b011)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_00; //SLTIU 
                else if(func3 == 3'b101 && func7 == 7'b0100000)
                    {alu_ctrl,whb,su,wos} <= 9'b1100_10_1_01; //SRAI 
                else
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;
            I2:
                if(func3 == 3'b010)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //LW 
                else if(func3 == 3'b001)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_01_1_01; //LH 
                else if(func3 == 3'b000)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_00_1_01; //LB 
                else if(func3 == 3'b100)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_00_0_01; //LBU 
                else if(func3 == 3'b101)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_01_0_01; //LHU 
                else 
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;
            S:
                if(func3 == 3'b010) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //SW 
                else if(func3 == 3'b001) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_01_1_01; //SH 
                else if(func3 == 3'b000) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_00_1_01; //SB 
                else 
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;
            B:
                    {alu_ctrl,whb,su,wos} <=9'b0001_10_1_01; //BEQ, BNE, BLT, BGE, BLTU, BGEU
            JR:
                if(func3 == 3'b000) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_10; //JALR 
                else
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx; 
            J:
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_10; //JAL 
            U:
                    {alu_ctrl,whb,su,wos} <= 9'b1101_10_1_01; //LUI 
            UPC:
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //AUIPC 
            default:                    
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;        
        endcase
    end

endmodule
