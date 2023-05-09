`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2023 10:44:23
// Design Name: 
// Module Name: control_unit_tb
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


module control_unit_tb;
reg [31:0] instrCode;
wire [3:0] alu_ctrl;
wire RegWrite;

control_unitr DUT(instrCode,alu_ctrl,RegWrite);

initial
begin
    instrCode = 32'h006283b3;
    #20
    instrCode = 32'h40628433;
    #20
    instrCode = 32'h0062f4b3;

end

endmodule
