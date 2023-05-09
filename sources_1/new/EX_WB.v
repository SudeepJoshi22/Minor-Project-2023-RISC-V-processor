`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2023 16:30:29
// Design Name: 
// Module Name: EX_WB
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


module EX_WB(
input clk,rst,RegWrite_ID_EX,
input [4:0] rd_ID_EX,
input [31:0] result,
output reg RegWrite_EX_WB,
output reg [4:0] rd_EX_WB,
output reg [31:0] result_EX_WB
);

always @(posedge clk,negedge rst)
begin
    if(!rst)
        begin
            RegWrite_EX_WB <= 1'd0;
            rd_EX_WB <= 5'd0;
            result_EX_WB <= 32'd0;
        end
    else
        begin
            RegWrite_EX_WB <= RegWrite_ID_EX;
            rd_EX_WB <= rd_ID_EX;
            result_EX_WB <= result;
        end
end

endmodule
