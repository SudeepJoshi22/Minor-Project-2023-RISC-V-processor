`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2023 10:19:11
// Design Name: 
// Module Name: control_unitr
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


module control_unitr(
input [31:0] instrCode,
output reg [3:0] alu_ctrl,
output reg RegWrite
);

wire [2:0] func3;
wire [6:0] func7,opcode;

assign func7 = instrCode[31:25];
assign func3 = instrCode[14:12];
//assign opcode = instrCode[6:0]; //op-code is same for all(for R-type implementation)

always @(*)
begin
    if(func3 == 3'b000 && func7 == 7'b0000000) {RegWrite,alu_ctrl} <= 5'b1_0000; //add
    else if(func3 == 3'b000 && func7 == 7'b0100000) {RegWrite,alu_ctrl} <= 5'b1_0001; //sub
    else if(func3 == 3'b111 && func7 == 7'b0000000) {RegWrite,alu_ctrl} <= 5'b1_0010; //and
    else if(func3 == 3'b110 && func7 == 7'b0000000) {RegWrite,alu_ctrl} <= 5'b1_0100; //or
    else if(func3 == 3'b001 && func7 == 7'b0000000) {RegWrite,alu_ctrl} <= 5'b1_1000; //sll
    else if(func3 == 3'b101 && func7 == 7'b0000000) {RegWrite,alu_ctrl} <= 5'b1_0011; //srl
    else {RegWrite,alu_ctrl} <= 5'bz_zzzz;
end

endmodule
