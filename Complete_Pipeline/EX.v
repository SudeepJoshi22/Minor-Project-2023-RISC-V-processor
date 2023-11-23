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
input wire [6:0] opcode,
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
output wire [6:0] opcode_EX,
//immOut for IF stage
output wire [31:0] immOut_EX,
//PC forwards
output wire [31:0] PC_4_EX
);

wire [31:0] Ai,Bi;
wire zero,boj;

assign PC_4_EX = PC_4;

assign su_EX = su;
assign whb_EX = whb;
assign wos_EX = wos;
assign opcode_EX = opcode;
assign immOut_EX = immOut;
assign Data_store = Read2;

assign Ai = ( opcode == `J || opcode == `UPC ) ? PC : Read1;  // a can either be pc or rs1
assign Bi = ( opcode == `R || opcode == `BR ) ? Read2 : immOut; // b can either be rs2 or imm 
assign boj = (( opcode == `BR) || (opcode == `J) || (opcode == `JR ))? 1'b1:1'b0;
assign jalr = ( opcode == `JR )? 1'b1: 1'b0;

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
