`timescale 1ns / 1ps
`default_nettype none

module WB(
input wire clk,
input wire rst,
input wire [31:0] read_data,
input wire [31:0] result,
input wire [5:0] opcode,
input wire [31:0] PC_4,
input wire su,
input wire [1:0] whb,
input wire [1:0] wos,
input wire lt,
input wire ltu,
output wire [31:0] DataOut_WB
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;
wire [31:0] WriteBackData,WriteData_ext_set,WriteData_ext;
wire set;

signext SIGNEXT(
WriteBackData,
whb,
su,
WriteData_ext
);

 
assign WriteBackData = (opcode == I2)? read_data : result;
assign set = (lt | ltu) ? 32'd1: 32'd0;
assign WriteData_ext_set = wos[1]? (wos[0]? 32'dz : PC_4) : (wos[0]? WriteData_ext : set);

endmodule