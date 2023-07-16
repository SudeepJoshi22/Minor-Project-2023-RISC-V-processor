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
wire [31:0] WriteData_ext_set;
wire zero;
wire lt;
wire ltu;

processor_unpipelined DUT(
clk,
rst,
result,
WriteData_ext_set,
zero,
lt,
ltu
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    #15
    rst <= 1;

end

endmodule
