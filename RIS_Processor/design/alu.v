`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2023 09:41:59
// Design Name: 
// Module Name: alu
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

module alu(
input [31:0] A,
input [31:0] B,
input [3:0] alu_ctrl,
output reg [31:0] result,
output zero
);

parameter ADD = 4'b0000,SUB = 4'b0001,AND = 4'b0010,OR = 4'b0100,XOR = 4'b1000,SRL = 4'b1001,SLL = 4'b1010;
always @(*)
begin
    case(alu_ctrl)        
        ADD:
            result <= A + B;
        SUB:
            result <= A - B;
        AND:
            result <= A & B;
        OR:
            result <= A | B;
        XOR:
            result <= A ^ B;
        SRL:
            result <= A >> B;
        SLL:
            result <= A << B;
        default:
            result <= 32'bz;
    endcase
end

assign zero = (result == 0)? 1 : 0;


endmodule
