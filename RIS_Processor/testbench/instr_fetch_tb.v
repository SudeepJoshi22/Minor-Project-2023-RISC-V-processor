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
reg clk,rst;
wire [31:0] instrCode;

instr_fetch DUT(clk,rst,instrCode);

initial clk = 0;

always #10 clk <= ~clk;

initial
begin
    rst = 1;
    #10
    rst = 0;
    #10 
    rst = 1;
    #200 
    $finish;

end

endmodule
