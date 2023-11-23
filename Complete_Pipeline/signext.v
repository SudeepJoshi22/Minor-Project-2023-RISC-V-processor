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

module signext(
input wire [31:0]  data,
input wire [1:0] whb,
input wire su,
output wire [31:0] data_op
);

parameter byte  = 2'b00, half_word = 2'b01, word = 2'b10;

//if su - 1, then sign extend, if su-1 then zero padding
assign data_op = su? ( ( whb== word )? data : ( (whb == half_word )? ({{16{data[15]}},data[15:0]}) : ( (whb == byte)? ( {{24{data[7]}},data[7:0]} ) : 32'dz ) ) ) : ( ( whb== word )? data : ( (whb == half_word )? ({{16{1'b0}},data[15:0]}) : ( (whb == byte)? ( {{24{1'b0}},data[7:0]} ) : 32'dz ) ) );

endmodule
