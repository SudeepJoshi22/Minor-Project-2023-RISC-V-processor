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


module IF(
input wire clk,
input wire rst,
input wire PC_src,
input wire jalr,
input wire [31:0]result_EX,
input wire [31:0]immOut_EX,
input wire [31:0] instr_read,
output wire cs_i_n,
output wire [31:0] i_addr,
output wire [31:0] instrCode,
//PC forwards
output wire [31:0] PC_IF,
output wire [31:0] PC_4_IF
);
wire [31:0] PC_imm,PC_next;
reg [31:0] PC,addr;
wire [31:0] PC_4;

assign PC_IF = PC;
assign PC_4_IF = PC_4;
assign i_addr = rst? PC : 32'dz;
assign instrCode = instr_read;

assign cs_i_n = rst ? 1'b0 : 1'b1;

assign PC_imm = PC + (immOut_EX<<1);
assign PC_4 = PC + 32'd4;
assign PC_next = PC_src? ( jalr ? (result_EX & ~1) : PC_imm): PC_4;


always @(posedge clk)
begin
    if(!rst)
        PC <= 32'd0;
    else begin
        PC <= PC_next;
    end
end       

endmodule
