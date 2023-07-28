`timescale 1ns / 1ps
`default_nettype none

module WB(
input wire clk,
input wire rst,
input wire [31:0] read_data,
input wire [31:0] result,
input wire [31:0] PC,
input wire lt,
input wire ltu,
output wire [4:0] rd,
output wire RegWrite,
output wire [31:0] DataOut_WB
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;
wire [31:0] WriteBackData,WriteData_ext_set,WriteData_ext;
wire [31:0] set;
wire [6:0] opcode;

assign RegWrite = (opcode == S || opcode == BR)? 1'b0:1'b1;

signext SIGNEXT(
WriteBackData,
whb,
su,
WriteData_ext
);

assign rd = instrCode[11:7];
assign opcode = PC[6:0];

assign DataOut_WB =  WriteData_ext_set ;
 
assign WriteBackData = (opcode == I2)? read_data : result;
assign set = (lt | ltu) ? 32'd1: 32'd0;
assign WriteData_ext_set = wos[1]? (wos[0]? 32'dz : PC_4) : (wos[0]? WriteData_ext : set);

endmodule