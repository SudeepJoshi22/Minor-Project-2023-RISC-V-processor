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


module control_unit_i(
input [31:0] instr,
output reg RegWrite,
output reg [3:0] alu_ctrl,
output reg rw,
output reg MemtoReg,
output reg AluSrc,
output reg [1:0] whb,
output reg su,
output reg wos
);

wire [2:0] func3;
wire [6:0] func7;
wire [6:0] opcode;


assign func3 = instr[14:12];
assign func7 = instr[31:25];
assign opcode = instr[6:0];

parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011;

always @(*)
begin
    case(opcode)
	R:
	   begin
           if(func3 == 3'b000 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0000_x_0_0_10_1_1; //ADD 
           else if(func3 == 3'b000 && func7 == 7'b0100000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0001_x_0_0_10_1_1; //SUB 
           else if(func3 == 3'b001 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_1010_x_0_0_10_1_1; //SLL 
           else if(func3 == 3'b101 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_1001_x_0_0_10_1_1; //SRL 
           else if(func3 == 3'b100 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_1000_x_0_0_10_1_1; //XOR 
           else if(func3 == 3'b111 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0010_x_0_0_10_1_1; //AND 
           else if(func3 == 3'b110 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0100_x_0_0_10_1_1; //OR 
           else if(func3 == 3'b101 && func7 == 7'b0100000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_1100_x_0_0_10_1_1; //SRA  
           else if(func3 == 3'b010 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0001_x_0_0_10_1_0; //SLT  
           else if(func3 == 3'b011 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0001_x_0_0_10_1_0; //SLTU   
       end
    I1:
        begin
            if(func3 == 3'b000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0000_x_0_1_10_1_1; //ADDI 
            else if(func3 == 3'b001 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_1010_x_0_1_10_1_1; //SLLI 
            else if(func3 == 3'b101 && func7 == 7'b0000000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_1001_x_0_1_10_1_1; //SRLI 
            else if(func3 == 3'b100) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_1000_x_0_1_10_1_1; //XORI 
            else if(func3 == 3'b111) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0010_x_0_1_10_1_1; //ANDI 
            else if(func3 == 3'b110) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0100_x_0_1_10_1_1; //ORI 
            else if(func3 == 3'b101) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0001_x_0_1_10_1_0; //SLTI 
            else if(func3 == 3'b011) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0001_x_0_1_10_1_0; //SLTIU 
            else if(func3 == 3'b101 && func7 == 7'b0100000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_1100_x_0_1_10_1_1; //SRAI 
        end
    I2:
        begin
            if(func3 == 3'b010) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0000_1_1_1_10_1_1; //LW 
            else if(func3 == 3'b001) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0000_1_1_1_01_1_1; //LH 
            else if(func3 == 3'b000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0000_1_1_1_00_1_1; //LB 
            else if(func3 == 3'b100) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0000_1_1_1_00_0_1; //LBU 
            else if(func3 == 3'b101) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b1_0000_1_1_1_01_0_1; //LHU 
        end
    S:
        begin
	        if(func3 == 3'b010) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b0_0000_0_0_1_10_1_1; //SW 
            else if(func3 == 3'b001) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b0_0000_0_0_1_01_1_1; //SH 
            else if(func3 == 3'b000) {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb,su,wos} <= 12'b0_0000_0_0_1_00_1_1; //SB 
         end
        default: {RegWrite,alu_ctrl,rw,MemtoReg,AluSrc,whb} <= 10'bx_xxxx_x_x_x_xx; 
        
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
