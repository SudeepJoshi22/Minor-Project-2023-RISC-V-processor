`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2023 10:25:02
// Design Name: 
// Module Name: alu_r
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


module alu_r(
input [31:0] A,
input [31:0] B,
input [3:0] alu_ctrl,
output reg [31:0] result,
output reg zero
);

parameter ADD = 4'b0000,SUB = 4'b0001,AND = 4'b0010,OR = 4'b0100,SLL = 4'b1000,SRL = 4'b0011;
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
        SLL:
            result <= A << B;
        SRL:
            result <= A >> B;
        default:
            result <= 32'bz;
    endcase

assign zero = (result == 0)? 1 : 0;

end


endmodule
