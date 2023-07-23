`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2023 12:19:51
// Design Name: 
// Module Name: instr_mem_tb
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


module instr_mem_tb;
reg [31:0] PC;
reg rst;
wire [31:0] instrCode;

instr_mem DUT(PC,rst,instrCode);

initial
begin
    rst = 0;
    #10 
    rst = 1;
    PC = 32'h0000;
    #10
    PC = 32'h0004;
    #10
    PC = 32'h000c;
    $finish;
end

endmodule
