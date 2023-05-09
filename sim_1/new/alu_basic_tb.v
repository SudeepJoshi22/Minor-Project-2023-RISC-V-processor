`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2023 11:18:07
// Design Name: 
// Module Name: alu_basic_tb
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


module alu_basic_tb;
reg [31:0] A,B;
reg [3:0] op;
wire [31:0] result;
wire zero;

alu_basic DUT(A,B,op,result,zero);

initial
begin
    A <= 32'h1234;
    B <= 32'h1111;
    op <= 4'b1000;
    #10
    A <= 32'hffff;
    B <= 32'habcd;
    op <= 4'b0000;
    #10
    op <= 4'b0001;
    #10
    A <= 32'h0000;
    op <= 4'b0000;
    $finish;
end

endmodule
