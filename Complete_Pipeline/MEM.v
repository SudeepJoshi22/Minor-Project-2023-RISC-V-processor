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

module MEM(
input wire clk,
input wire rst,
input wire [31:0] result,
input wire [31:0] Data_store,
input wire [6:0] opcode,
input wire [31:0] Data_read,
input wire [31:0] PC_4,
input wire su,
input wire [1:0] whb,
input wire [1:0] wos,
input wire lt,
input wire ltu,
output wire cs_d_n,
output wire rd,
output wire wr,
output wire [31:0] d_addr, //address for data mem
output wire [31:0] Data_write, //data to write into data mem
output wire [31:0] Data_out_MEM, //data read from the data mem
//control signals forwarding
output wire su_MEM,
output wire [1:0] whb_MEM,
output wire [1:0] wos_MEM,
//flags forwarding
output wire lt_MEM,
output wire ltu_MEM,
//pipeline forwarding
output wire [6:0] opcode_MEM,
output wire [31:0] result_MEM,
output wire [31:0] PC_4_MEM
);

reg [31:0] address;

assign lt_MEM = lt;
assign ltu_MEM = ltu;
assign su_MEM = su;
assign whb_MEM = whb;
assign wos_MEM = wos;
assign PC_4_MEM = PC_4;
assign opcode_MEM = opcode;
assign result_MEM = result;
assign Data_out_MEM = Data_read;

assign d_addr = ~cs_d_n ? result : 32'dz;
assign Data_write = ~cs_d_n ? Data_store : 32'dz;

assign rd = (opcode == `I2)? 1'b1: 1'bz;
assign wr = (opcode == `S)? 1'b1 : 1'bz;
assign cs_d_n = ((rd == 1) || (wr == 1))? 1'b0 : 1'b1; //activate chip select only if read and write is activated

endmodule
