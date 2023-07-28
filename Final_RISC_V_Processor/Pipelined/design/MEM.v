`timescale 1ns / 1ps
`default_nettype none

module MEM(
input wire clk,
input wire rst,
input wire [31:0] result,
input wire [31:0] Data_store,
input wire [31:0] Data_read,
input wire [31:0] PC,
input wire lt,
input wire ltu,
output wire cs_d_n,
output wire rd,
output wire wr,
output wire [31:0] d_addr, //address for data mem
output wire [31:0] Data_write, //data to write into data mem
output wire [31:0] Data_out_MEM, //data read from the data mem
//flags forwarding
output wire lt_MEM,
output wire ltu_MEM,
//pipeline forwarding
output wire [31:0] result_MEM,
output wire [31:0] PC_MEM
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

wire [6:0] opcode;

assign opcode = PC[6:0];

assign lt_MEM = lt;
assign ltu_MEM = ltu;
assign PC_MEM = PC;
assign result_MEM = result;
assign Data_out_MEM = Data_read;

assign d_addr = ~cs_d_n ? result : 32'dz;
assign Data_write = ~cs_d_n ? Data_store : 32'dz;

assign rd = (opcode == I2)? 1'b1: 1'bz;
assign wr = (opcode == S)? 1'b1 : 1'bz;
assign cs_d_n = ((rd == 1) || (wr == 1))? 1'b0 : 1'b1; //activate chip select only if read and write is activated

endmodule