`timescale 1ns / 1ps
`default_nettype none

module EX(
//inputs
input wire clk,
input wire rst,
input wire read_data_valid, //tells if the read data is valid or not
input wire [3:0] alu_ctrl, //alu control for ALU
input wire [31:0] immOut, //immediate value from the ID
//Data forwards to next stage
input wire [31:0] Read1, //rs1 Read
input wire [31:0] Read2, //rs2 Read
//pipeline forwards
input wire [4:0] rd, //rd to be forwarded
input wire [2:0] func3, //func3, to be forwarded
input wire [6:0] opcode, //opcode, to be forwarded  and used for decoding
input wire [31:0] PC, //PC from ID, to be forwarded
//outputs
output wire [2:0] func3_EX,
output wire [4:0] rd_EX,
output wire [6:0] opcode_EX,
output wire [31:0] result, //result of alu
output wire [31:0] DataStore, //Data to store into Data Memory
output wire PC_src, //PC_src, goes to IF for branch and jump instructions
output wire jalr, //goes to IF for JALR instruction
//flags out
output wire lt, //less than flag from alu
output wire ltu, //less than unsigned flag from alu
//immOut for IF stage
output wire [31:0] immOut_EX, //immediate out from instruction code, goes to IF
//PC forward
output wire [31:0] PC_EX //PC forward to next stage
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

wire [31:0] Ai,Bi;
wire zero,boj;
//wire [6:0] opcode;
wire [1:0] whb;
//wire [2:0] func3;
//wire [31:0] immOut

assign whb = func3[1:0];

assign Ai = (opcode==J || opcode==UPC)? PC:Read1;  // a can either be pc or rs1
assign Bi = (opcode==R || opcode==BR || opcode==S)? Read2:immOut; // b can either be rs2 or imm 
//assign Bi = Read2;
assign boj = ((opcode == BR) || (opcode == J) || (opcode == JR))? 1'b1:1'b0;
assign jalr = (opcode == JR)? 1'b1: 1'b0;

assign PC_EX = PC;
assign immOut_EX = immOut;
assign opcode_EX = opcode;
assign func3_EX = func3;
assign rd_EX = rd;

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


endmodule
