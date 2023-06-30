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
input PC_src,
input result,
input [31:0]immOut,
output [31:0] instrCode
);
reg [31:0] PC;
wire [7:0]opcode;
instr_mem m(PC,rst,instrCode);
assign opcode=instrCode[6:0];
always @(posedge clk,negedge rst)
begin
    if(!rst)
        PC <= 0;
    else if(opcode==7'b1100111)// checking for jalr condition
        PC<=~(result||1);//making pc as even address
    else if(!PC_src)
        PC <= PC + 32'd4; //for next address
   else
        PC<=immOut<<1;  //used for B_type &jal
end

endmodule
