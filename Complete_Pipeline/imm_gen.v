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

module imm_gen(
input wire [31:0] instr,
output wire [31:0] immOut
);

reg [11:0] imm;
reg [19:0] imm_j_u; //20 bit immediate for both u type and j type
wire [6:0] opcode;
wire [2:0] func3;

assign func3 = instr[14:12];
assign opcode = instr[6:0];
assign immOut = (opcode == `U || opcode == `UPC) ? {imm_j_u,12'd0} : (opcode == `J)? {{12{imm_j_u[19]}},imm_j_u[19:0]} : {{20{imm[11]}}, imm[11:0]};

always @(*)
begin
    case(opcode)
        `I1:
        begin 
            if( func3 == 3'b001 || func3 == 3'b101)
                imm <= {{7{instr[24]}},instr[24:20]}; //for I-type shift instructions shift amount is encoded in the instructions only
            else
                imm <= instr[31:20];
           
        end
        `I2:  
            imm <= instr[31:20]; 
        `S:
            imm <= {instr[31:25],instr[11:7]};
        `BR: 
            imm<={instr[31],instr[7],instr[30:25],instr[11:8]};
        `J: 
            imm_j_u<={instr[31],instr[19:12],instr[20],instr[30:21]};
        `JR:
            imm<={instr[31:20]};   
        `U:
            imm_j_u<={instr[31:12]};   
        `UPC:
            imm_j_u<={instr[31:12]};        
        default:
        begin 
            imm <= 12'd0;
            imm_j_u <= 20'd0;
        end
    endcase
        
end

endmodule
