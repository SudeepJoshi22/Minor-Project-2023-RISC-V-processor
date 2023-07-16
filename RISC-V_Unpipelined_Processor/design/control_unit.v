`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2023 23:25:49
// Design Name: 
// Module Name: control_unit_i
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit(
input [31:0] instr,
output reg RegWrite,
output reg [3:0] alu_ctrl,
output reg rw,
output reg MemtoReg,
output reg AluSrc,
output reg [1:0] whb,
output reg su,
output reg [1:0]wos,
output reg boj,
output reg jalr
);

wire [2:0] func3;
wire [6:0] func7;
wire [6:0] opcode;


assign func3 = instr[14:12];
assign func7 = instr[31:25];
assign opcode = instr[6:0];

parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,B=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

always @(*)
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
        
    endcase
 end

    /*
    if(func3 == 3'b000) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0000_x_1_0_1;
    else if(func3 == 3'b111) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0010_x_1_0_1;
    else if(func3 == 3'b110) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0100_x_1_0_1;
    else if(func3 == 3'b001) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b1000_x_1_0_1;
    else if(func3 == 3'b101) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0011_x_1_0_1;
    else if(func3 == 3'b010) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0000_1_1_1_1;
    else {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'bx;
    */


endmodule
