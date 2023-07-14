`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2023 12:28:36
// Design Name: 
// Module Name: instr_fetch_tb
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


module instr_fetch_tb;
reg clk;
reg rst;
reg PC_src;
reg jalr;
reg [31:0]result;
reg [31:0]immOut;
wire [31:0] instrCode;
wire [31:0] PC;
wire [31:0] PC_4;

instr_fetch DUT(
clk,
rst,
PC_src,
jalr,
result,
immOut,
instrCode,
PC,
PC_4
);

initial clk <= 0;
always #10 clk <= ~clk;

initial
begin
   rst <= 0;
   PC_src <= 0;
   jalr <= 0;
   result <= 32'hffabcd11;
   immOut <= 32'h000000ff;
   #8
   rst <= 1;
   #100
   PC_src <= 1;
   #10
   jalr <= 1;
   #50
   $finish;
end

endmodule
