`timescale 1ns / 1ps
`default_nettype none

module IF(
input wire clk,
input wire rst,
//input wire PC_src,
//input wire jalr,
input wire hit,taken,//for BPU
input wire [31:0]pred_PC,//for BPU
//input wire [31:0]result_EX,
//input wire [31:0]immOut_EX,
input wire [31:0] instr_read,
output wire cs_i_n,
output wire [31:0] i_addr,
output wire [31:0] instrCode,
//PC forwards
output wire [31:0] PC_IF,
output wire [31:0] PC_4_IF
);
//wire [31:0] PC_imm;
wire [31:0] PC_next;
reg [31:0] PC/*,addr*/;
wire [31:0] PC_4;

assign PC_IF = PC;
assign PC_4_IF = PC_4;
assign i_addr = rst? PC : 32'dz;
assign instrCode = instr_read;

assign cs_i_n = rst? 1'b0 : 'b1;
/*
assign PC_imm = PC + (immOut_EX<<1);
assign PC_4 = PC + 32'd4;
assign PC_next= PC_src? ( jalr ? (result_EX & ~1) : PC_imm): PC_4;*/


assign PC_4 = PC + 32'd4;
assign PC_next= hit&taken ? pred_PC:PC_4;

/*

//ce logic for fetch stage
always @(posedge clk, negedge rst) 
begin
     if(!rst) 
         ce <= 1'b0; 
     else if(PC_src) 
         ce<=1'b0;
     else 
         ce <= 1'b1; 
end
*/

always @(posedge clk)
begin
    if(!rst)
        PC <= 32'd0;
    else begin
        PC <= PC_next;
    end
end       

endmodule
