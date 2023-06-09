`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2023 12:24:57
// Design Name: 
// Module Name: instr_fetch
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


module instr_fetch(
input clk,
input rst,
output [31:0] instrCode
);
reg [31:0] PC;

instr_mem m(PC,rst,instrCode);

always @(posedge clk,negedge rst)
begin
    if(!rst)
        PC <= 0;
    else
        PC <= PC + 32'd4;

end

endmodule
