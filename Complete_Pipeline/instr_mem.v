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

`include "parameters.vh"
`timescale 1ns / 1ps
`default_nettype none


module instr_mem(
input wire clk,
input wire [31:0] iaddr,
input wire rst,
input wire cs_n,
output reg [31:0] instrCode
);

reg [7:0] Mem[`INSTR_MEM_SIZE:0];

always @(*)
begin
    if(~rst)
    begin
        $readmemh("memory.mem",Mem);
        instrCode <= 32'dz;
    end
end

always @(*)
begin
    instrCode <= {Mem[iaddr+3],Mem[iaddr+2],Mem[iaddr+1],Mem[iaddr]};
end

endmodule
