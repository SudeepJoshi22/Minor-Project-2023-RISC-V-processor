`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2023 16:25:10
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
input clk,rst,RegWrite,
input [31:0] data1,data2,
input [3:0] alu_ctrl,
input [4:0] rd,
output reg RegWrite_ID_EX,
output reg [31:0] data1_ID_EX,data2_ID_EX,
output reg [3:0] alu_ctrl_ID_EX,
output reg [4:0] rd_ID_EX
);

always @(posedge clk, negedge rst)
begin
if(!rst)
    begin
        RegWrite_ID_EX <= 1'd0;
        data1_ID_EX <=  32'd0;
        data2_ID_EX <= 32'd0;
        alu_ctrl_ID_EX <= 4'd0;
        rd_ID_EX <= 5'd0;
    end
else
    begin
        RegWrite_ID_EX <= RegWrite;
        data1_ID_EX <= data1;
        data2_ID_EX <= data2;
        alu_ctrl_ID_EX <= alu_ctrl;
        rd_ID_EX <= rd;
    end
end

endmodule
