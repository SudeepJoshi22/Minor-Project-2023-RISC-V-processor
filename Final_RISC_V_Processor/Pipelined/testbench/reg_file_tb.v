`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2023 23:48:11
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb;
reg clk,RegWrite,rst;
reg [4:0] ReadAddr1,ReadAddr2,WriteAddr;
reg [31:0] WriteData;
wire [31:0]  ReadData1,ReadData2;

reg_file DUT(clk,RegWrite,rst,ReadAddr1,ReadAddr2,WriteAddr,ReadData1,ReadData2,WriteData);
initial clk<=0;

always #10 clk<=~clk;

initial
begin
    rst <= 0;
    #5
    rst <= 1;
    RegWrite <= 1;
    WriteData <= 32'ha000b000;
    WriteAddr <= 5'b00000;
    #10
    RegWrite <= 1;
    WriteAddr <= 5'b00001;
    #10
    ReadAddr1 <= 5'b00000;
    ReadAddr2 <= 5'b00001;
    #50 $finish;
end

endmodule
