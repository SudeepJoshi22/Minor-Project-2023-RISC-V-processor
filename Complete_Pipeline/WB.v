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

module WB(
input wire clk,
input wire rst,
input wire [31:0] read_data,
input wire [31:0] result,
input wire [6:0] opcode,
input wire [31:0] PC_4,
input wire su,
input wire [1:0] whb,
input wire [1:0] wos,
input wire lt,
input wire ltu,
output wire [31:0] DataOut_WB
);

wire [31:0] WriteBackData,WriteData_ext_set,WriteData_ext;
wire [31:0] set;

signext SIGNEXT(
WriteBackData,
whb,
su,
WriteData_ext
);

assign DataOut_WB =  WriteData_ext_set ;
 
assign WriteBackData = (opcode == `I2)? read_data : result;
assign set = (lt | ltu) ? 32'd1: 32'd0;
assign WriteData_ext_set = wos[1]? (wos[0]? 32'dz : PC_4) : (wos[0]? WriteData_ext : set);

endmodule
