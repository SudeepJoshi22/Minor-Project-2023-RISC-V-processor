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

module control_unit(
input wire [31:0] instr,
output reg [3:0] alu_ctrl,
output reg [1:0] whb,
output reg su,
output reg [1:0]wos
);

wire [2:0] func3;
wire [6:0] func7;
wire [6:0] opcode;

assign func3 = instr[14:12];
assign func7 = instr[31:25];
assign opcode = instr[6:0];

always @(*)
    begin
        case(opcode)
            `R:   
                if(func3 == 3'b000 && func7 == 7'b0000000) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //ADD 
                else if(func3 == 3'b000 && func7 == 7'b0100000)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_01; //SUB 
                else if(func3 == 3'b001 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1010_10_1_01; //SLL 
                else if(func3 == 3'b101 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1001_10_1_01; //SRL 
                else if(func3 == 3'b100 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1000_10_1_01; //XOR 
                else if(func3 == 3'b111 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b0010_10_1_01; //AND 
                else if(func3 == 3'b110 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b0100_10_1_01; //OR 
                else if(func3 == 3'b101 && func7 == 7'b0100000)
                    {alu_ctrl,whb,su,wos} <= 9'b1100_10_1_01; //SRA  
                else if(func3 == 3'b010 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_00; //SLT  
                else if(func3 == 3'b011 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_00; //SLTU  
                else 
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;
        
            `I1:
                if(func3 == 3'b000) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //ADDI 
                else if(func3 == 3'b001 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1010_10_1_01; //SLLI 
                else if(func3 == 3'b101 && func7 == 7'b0000000)
                    {alu_ctrl,whb,su,wos} <= 9'b1001_10_1_01; //SRLI 
                else if(func3 == 3'b100)
                    {alu_ctrl,whb,su,wos} <= 9'b1000_10_1_01; //XORI 
                else if(func3 == 3'b111)
                    {alu_ctrl,whb,su,wos} <= 9'b0010_10_1_01; //ANDI 
                else if(func3 == 3'b110)
                    {alu_ctrl,whb,su,wos} <= 9'b0100_10_1_01; //ORI 
                else if(func3 == 3'b010)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_00; //SLTI 
                else if(func3 == 3'b011)
                    {alu_ctrl,whb,su,wos} <= 9'b0001_10_1_00; //SLTIU 
                else if(func3 == 3'b101 && func7 == 7'b0100000)
                    {alu_ctrl,whb,su,wos} <= 9'b1100_10_1_01; //SRAI 
                else
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;
            `I2:
                if(func3 == 3'b010)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //LW 
                else if(func3 == 3'b001)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_01_1_01; //LH 
                else if(func3 == 3'b000)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_00_1_01; //LB 
                else if(func3 == 3'b100)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_00_0_01; //LBU 
                else if(func3 == 3'b101)
                    {alu_ctrl,whb,su,wos} <= 9'b0000_01_0_01; //LHU 
                else 
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;
            `S:
                if(func3 == 3'b010) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //SW 
                else if(func3 == 3'b001) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_01_1_01; //SH 
                else if(func3 == 3'b000) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_00_1_01; //SB 
                else 
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;
            `BR:
                    {alu_ctrl,whb,su,wos} <=9'b0001_10_1_01; //BEQ, BNE, BLT, BGE, BLTU, BGEU
            `JR:
                if(func3 == 3'b000) 
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_10; //JALR 
                else
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx; 
            `J:
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_10; //JAL 
            `U:
                    {alu_ctrl,whb,su,wos} <= 9'b1101_10_1_01; //LUI 
            `UPC:
                    {alu_ctrl,whb,su,wos} <= 9'b0000_10_1_01; //AUIPC 
            default:                    
                    {alu_ctrl,whb,su,wos} <=9'bxxxx_xx_x_xx;        
        endcase
    end

endmodule
