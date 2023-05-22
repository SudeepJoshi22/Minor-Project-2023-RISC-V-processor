`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2023 11:38:32
// Design Name: 
// Module Name: processor_r_type
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module processor_r_type(clk,rst,result,zero);
input clk,rst;
output wire [31:0] result;
output wire zero;

wire [31:0] instrCode,A,B;
wire [4:0] rs1,rs2,rd;
wire RegWrite;
wire [3:0] alu_ctrl;

assign rs1 = instrCode[19:15];
assign rs2 = instrCode[24:20];
assign rd = instrCode[11:7];

instr_fetch fetch(clk,rst,instrCode);

control_unitr control(instrCode,alu_ctrl,RegWrite);

reg_file reg_file(clk,RegWrite,rst,rs1,rs2,rd,result,A,B);

alu_r alu(A,B,alu_ctrl,result,zero);

endmodule
