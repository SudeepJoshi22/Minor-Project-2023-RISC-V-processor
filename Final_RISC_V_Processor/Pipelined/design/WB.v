`timescale 1ns / 1ps
`default_nettype none

module WB(
input wire clk,
input wire rst,
input wire [4:0] rd, //read address for register  file, to be forwarded to ID
input wire [2:0] func3, //func3 for decoding
input wire [6:0] opcode, //opcode for decoding
input wire [31:0] read_data, //Data read from the MEM
input wire lt, //lt flag
input wire ltu, //ltu flag
input wire [31:0] result, //result from EX->MEM->
input wire [31:0] PC, //PC forwarded
output wire [4:0] rd_WB, //rd to goto ID
output wire RegWrite, //RegWrite signal for reg  file, goto ID
output wire [31:0] DataOut_WB //Data write back to ID stage
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;
parameter SLT = 3'b010,SLTU = 3'b011;
wire [31:0] WriteBackData,WriteData_ext_set,WriteData_ext;
wire [31:0] set;
wire [1:0] whb;
wire su;


assign rd_WB = rd;
assign whb = func3[1:0];
assign su = func3[2];

assign RegWrite = (opcode == S || opcode == BR)? 1'b0:1'b1;

assign WriteBackData = (opcode == I2)? read_data : result;
assign set = (lt | ltu) ? 32'd1: 32'd0;

assign DataOut_WB = ((opcode==R)||(opcode==I1)||(opcode==I2)||(opcode==U)||(opcode==UPC)) ? ( ((((func3==SLT)||(func3==SLTU)) && ~(opcode == I2)))? set : WriteBackData ) : (((opcode==J)||(opcode==JR))? (PC+32'd4) : 32'dz);

signext SIGNEXT(
WriteBackData,
whb,
su,
WriteData_ext
);


endmodule