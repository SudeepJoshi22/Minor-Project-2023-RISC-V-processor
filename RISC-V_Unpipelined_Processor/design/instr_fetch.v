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
input jalr,
input wire [31:0]result,
input wire [31:0]immOut,
output [31:0] instrCode,
output reg [31:0] PC,
output wire [31:0] PC_4
);
wire [31:0] PC_imm,PC_branch_jump,PC_next;

assign PC_imm = PC + immOut;
assign PC_4 = PC + 32'd4;
assign PC_branch_jump = jalr? (result & ~1 ) : PC_imm;
assign PC_next = PC_src ? PC_branch_jump : PC_4;

instr_mem m(PC,rst,instrCode);

always @(posedge clk, negedge rst)
begin
    if(!rst)
        PC <= 32'd0;
    else
        PC <= PC_next;
end         
    /*    
    else if(opcode==7'b1100111)// checking for jalr condition
        PC<=result^~1;//making pc as even address
    else if(!PC_src)
        PC <= PC + 32'd4; //for next addres
   else
        PC<=immOut<<1;  //used for B_type &jal
*/

endmodule
