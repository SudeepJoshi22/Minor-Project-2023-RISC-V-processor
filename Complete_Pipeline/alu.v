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

module alu(
input wire signed [31:0] A,
input wire signed [31:0] B,
input wire [3:0] alu_ctrl,
output reg signed [31:0] result,
output wire zero,
output wire lt,
output wire ltu
);

reg signed [32:0] AU,BU,resultu;

assign zero = (result == 0)? 1 : 0;
assign lt = (result < 0 )? 1 : 0;
assign ltu = (resultu < 0 )? 1 : 0;

always @(*) //FOR UNSIGNED TYPE INSTRUCTIONS
begin
    AU <= {1'b0, A};
    BU <= {1'b0, B};
end

always @(*)
begin
    case(alu_ctrl)        
        `ADD:
            result <= A + B;
        `SUB:
	begin
	    result <= A - B;
	    resultu <= AU - BU;
	end
        `AND:
            result <= A & B;
        `OR:
            result <= A | B;
        `XOR:
            result <= A ^ B;
        `SRL:
            result <= A >> B[4:0]; //Shift is only define by the lower order 5-bits of B
        `SLL:
            result <= A << B[4:0]; //Same here
        `SRA:
            result <= A >>> B[4:0];
        `BUF:
            result <= B;  
        default:
            result <= 32'bz;
    endcase
end

endmodule
