`timescale 1ns / 1ps
`default_nettype none

module EX(
input wire clk,
input wire rst,
input wire [31:0] Read1,
input wire [31:0] Read2,
input wire [31:0] immOut,
input wire [31:0] PC,
input wire [31:0] PC_4,
input wire [3:0] alu_ctrl,
input wire [2:0] func3,
input wire [5:0] opcode,
//control signals to forward
input wire su,
input wire [1:0] whb,
input wire [1:0] wos,
//outputs
output wire [31:0] result,
output wire [31:0] Data_store,
output wire PC_src,
output wire jalr,
//flags out
output wire lt,
output wire ltu,
//control signals out
output wire su_EX,
output wire [1:0] whb_EX,
output wire [1:0] wos_EX,
//intruction forward
output wire [5:0] opcode_EX,
//immOut for IF stage
output wire [31:0] immOut_EX,
//PC forwards
output wire [31:0] PC_4_EX
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

wire [31:0] Ai,Bi;
wire zero,boj;

assign PC_4_EX = PC_4;

assign su_EX = su;
assign whb_EX = whb;
assign wos_EX = wos;
assign opcode_EX = opcode;
assign immOut_EX = immOut;

assign Ai = (opcode==J || opcode==UPC)? PC:Read1;  // a can either be pc or rs1
assign Bi = (opcode==R || opcode==BR)? Read2:immOut; // b can either be rs2 or imm 
assign boj = ((opcode == BR) || (opcode == J) || (opcode == JR))? 1'b1:1'b0;
assign jalr = (opcode == JR)? 1'b1: 1'b0;

alu ALU(
Ai,
Bi,
alu_ctrl,
result,
zero,
lt,
ltu
);

PC_src BRANCH_JUMP(
boj,
zero,
lt,
ltu,
func3,
opcode,
PC_src);

endmodule
