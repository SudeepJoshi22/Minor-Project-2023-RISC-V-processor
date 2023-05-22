`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2023 23:25:49
// Design Name: 
// Module Name: control_unit_i
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


module control_unit_i(
input [31:0] instr,
output reg RegWrite,
output reg [3:0] alu_ctrl,
output reg rw,
output reg MemToReg,
output reg AluSrc
);

wire [2:0] func3;

assign func3 = instr[14:12];

always @(*)
begin
    if(func3 == 3'b000) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0000_x_1_0_1;
    else if(func3 == 3'b111) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0010_x_1_0_1;
    else if(func3 == 3'b110) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0100_x_1_0_1;
    else if(func3 == 3'b001) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b1000_x_1_0_1;
    else if(func3 == 3'b101) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0011_x_1_0_1;
    else if(func3 == 3'b010) {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'b0000_1_1_1_1;
    else {alu_ctrl,rw,RegWrite,MemToReg,AluSrc} = 8'bx;
end

endmodule
