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

module PC_src(
input wire boj,
input wire zero,
input wire lt,
input wire ltu,
input wire [2:0] func3,
input wire [6:0] opcode,
output reg PC_src);
   
always @(*)
begin
    if(boj == 1)
    begin
        if(opcode == `J || opcode == `JR)
            PC_src <= 1;
        else 
        begin
            case(func3)
                `BEQ: begin
                         if(zero==1)
                            PC_src<=1;
                         else
                            PC_src<=0;
                     end
                `BNE:begin
                        if(zero==0)
                            PC_src<=1;
                        else
                            PC_src<=0;
                    end
                `BLT:begin
                        if(lt==1)
                            PC_src<=1;
                        else
                            PC_src<=0;
                    end
                `BGE:begin
                        if(zero==1 || lt!=1)
                            PC_src<=1;
                        else
                            PC_src<=0;
                    end
                `BLTU:begin
                         if(ltu==1)
                            PC_src<=1;
                         else
                            PC_src<=0;
                     end
                `BGEU:begin
                         if(zero==1 || ltu!=1)
                            PC_src<=1;
                         else
                            PC_src<=0;
                     end
                default:
                            PC_src<=0;
            endcase
        end
    end
    else 
       PC_src<=0;
end

endmodule
