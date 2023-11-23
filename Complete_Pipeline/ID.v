// MIT License
// 
// Copyright (c) 2023 Sudeep et al.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

`timescale 1ns / 1ps
`default_nettype none
`include "parameters.vh"

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
output wire [6:0] opcode,
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
assign Read1 = A;

assign RegWrite = (opcode == `S || opcode == `BR)? 1'b0:1'b1;

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
