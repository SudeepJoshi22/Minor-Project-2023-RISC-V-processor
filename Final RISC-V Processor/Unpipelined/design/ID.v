`timescale 1ns / 1ps
`default_nettype none

module ID(
input wire clk,
input wire rst,
input wire [31:0] instrCode,
input wire [31:0] Data_WB,
input wire [31:0] PC,
input wire [31:0] PC_4,
//Data forwards to next stage
output wire [31:0] Read1,
output wire [31:0] Read2,
output wire [31:0] immOut,
//instruction forwards to next stage
output wire [5:0] opcode,
output wire [2:0] func3,
//control signlas
output wire su,
output wire [1:0] whb,
output wire [1:0] wos,
output wire [3:0] alu_ctrl,
//pipeline forwards
output wire [31:0] PC_ID,
output wire [31:0] PC_4_ID
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

wire [31:0] A,B,B_ext;
wire [4:0] rs1,rs2,rd;
wire [11:0] imm;
wire RegWrite;

assign imm = instrCode[31:20];
assign rs1 = instrCode[19:15];
assign rs2 = instrCode[24:20];
assign rd = instrCode[11:7];
assign opcode = instrCode[6:0];
assign func3 = instrCode[14:12];
assign PC_ID  = PC;
assign PC_4_ID = PC_4;

assign Read2 = B_ext;

assign RegWrite = (opcode == S || opcode == BR)? 1'b0:1'b1;

reg_file REG_FILE(
clk,
RegWrite,
rst,
rs1,
rs2,
rd,
Data_WB,
A,
B
);

store_whb STORE_WHB(
B,
whb,
B_ext
);

imm_gen IMM_GEN(
instrCode,
immOut
);

control_unit CONTROL_UNIT(
instrCode,
alu_ctrl,
whb,
su,
wos
);

endmodule