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

module top_module(
input wire clk,
input wire rst_n,
output wire [31:0] i_data,
output wire [31:0] d_data,
output wire rd,
output wire wr,
output wire cs_i_n,
output wire cs_d_n,
output wire [31:0] i_addr,
output wire [31:0] result,
output wire [31:0] DataOut_WB,
output wire [31:0] d_addr,
output wire [31:0] Data_write
);


core M0(
clk,
rst_n,
i_data,
d_data,
cs_i_n,
cs_d_n,
rd,
wr,
i_addr,
d_addr,
Data_write,
result,
DataOut_WB
);

instr_mem M1(
clk,
i_addr,
rst_n,
cs_i_n,
i_data
);

data_mem M2(
clk,
rst_n,
rd,
wr,
cs_d_n,
d_addr,
Data_write,
d_data
);

endmodule
