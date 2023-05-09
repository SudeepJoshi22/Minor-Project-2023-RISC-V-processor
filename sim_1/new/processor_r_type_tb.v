`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2023 11:46:19
// Design Name: 
// Module Name: processor_r_type_tb
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


module processor_r_type_tb;
reg clk,rst;
wire [31:0] result;
wire zero;

//processor_r_type DUT(clk,rst,result,zero);
processor_r_type_pipelined DUT(clk,rst,result,zero);


initial clk <=0;
always #10 clk <= ~clk;

initial
begin
    rst = 0;
    #25 rst = 1;
end

endmodule
