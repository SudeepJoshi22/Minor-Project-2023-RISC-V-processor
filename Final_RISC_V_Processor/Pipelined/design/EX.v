`timescale 1ns / 1ps
`default_nettype none

module EX(
input wire clk,
input wire rst,
input wire [31:0] Read1,
input wire [31:0] Read2,
input wire [31:0] PC,
input wire [3:0] alu_ctrl,
//outputs
output wire [31:0] result,
output wire [31:0] DataStore,
output wire PC_src,
output wire jalr,
//flags out
output wire lt,
output wire ltu,
//immOut for IF stage
output wire [31:0] immOut,
//PC forwards
output wire [31:0] PC_EX
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

wire [31:0] Ai,Bi;
wire zero,boj;
wire [6:0] opcode;
wire [1:0] whb;
wire [2:0] func3;
//wire [31:0] immOut

assign func3 = PC[14:12];
assign opcode = PC[6:0];
assign whb = func3[1:0];

assign Ai = (opcode==J || opcode==UPC)? PC:Read1;  // a can either be pc or rs1
assign Bi = (opcode==R || opcode==BR || opcode==S)? Read2:immOut; // b can either be rs2 or imm 
//assign Bi = Read2;
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

store_whb SIGN_EXT_STORE(
Read2,
whb,
DataStore
);

imm_gen IMM_GEN(
PC,
immOut
);

endmodule
