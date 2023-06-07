`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2023 00:34:21
// Design Name: 
// Module Name: processor_i_type_tb
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


module processor_ris_type_tb;
reg clk,rst;
wire [31:0] result;
wire zero;

processor_ris_type DUT(
clk,
rst,
result,
zero
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    #25
    rst <= 1;

end

endmodule
