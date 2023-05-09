`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2023 16:24:49
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
input clk,rst,
input [31:0] instrCode,
output reg [31:0] instrCode_IF_ID
);

always @(posedge clk,negedge rst)
begin
    if(!rst) instrCode_IF_ID <= 32'd0;
    else instrCode_IF_ID <= instrCode;
end
  
endmodule
