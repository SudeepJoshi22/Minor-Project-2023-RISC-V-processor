`timescale 1ns / 1ps
`default_nettype none
<<<<<<< HEAD
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
=======

/*module instr_fetch(
>>>>>>> 4e0830f4901d8bbec00a03eb2adbf3ff9098ca97
input wire clk,
input wire rst,
input wire PC_src,
input wire jalr,
input wire [31:0]result,
input wire [31:0]immOut,
output wire [31:0] instrCode,
output reg [31:0] PC,
output wire [31:0] PC_4
);
<<<<<<< HEAD
wire [31:0] PC_imm,/*PC_branch_jump,*/PC_next;


//assign PC_imm = immOut<<1; 
//for branch conditions
assign PC_imm = PC + (immOut<<1);  //for jal type
//assign PC_imm = immOut<<1;
assign PC_imm = PC + (immOut<<1);
assign PC_4 = PC + 32'd4;

//assign PC_branch_jump = jalr? (result & ~1 ) : PC_imm;
//assign PC_next = PC_src ? PC_branch_jump : PC_4;
assign PC_next= PC_src? (jalr ? result & ~1 : PC_imm): PC_4;

=======
wire [31:0] PC_imm;
wire [31:0] PC_next;

assign PC_imm = PC + (immOut<<1);
assign PC_4 = PC + 32'd4;
assign PC_next= PC_src? (jalr ? result & ~1 : PC_imm): PC_4;
 //PC_next= hit? PC_addr: PC_4; 

//branch_prediction BP(clk,rst,PC,opcode,hit,PC_addr);
>>>>>>> 4e0830f4901d8bbec00a03eb2adbf3ff9098ca97

instr_mem m(PC,rst,instrCode);

always @(posedge clk, negedge rst)
begin
    if(!rst)
        PC <= 32'd0;
    else 
        PC <= PC_next;
end         

endmodule
*/



module instr_fetch(
input wire clk,
input wire rst,
input wire hit,
input wire taken,
input wire [31:0]pred_PC,
output wire [31:0] instrCode,
output reg [31:0] PC,
output wire [31:0] PC_4
);
wire [31:0] PC_next;
assign PC_4 = PC + 32'd4;
assign PC_next=hit&taken?pred_PC: PC_4;
 //PC_next= hit? PC_addr: PC_4; 

//branch_prediction BP(clk,rst,PC,opcode,hit,PC_addr);

instr_mem m(PC,rst,instrCode);

always @(posedge clk, negedge rst)
begin
    if(!rst)
        PC <= 32'd0;
    else 
        PC <= PC_next;
end         

endmodule
