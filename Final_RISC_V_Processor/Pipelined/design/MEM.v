`timescale 1ns / 1ps
`default_nettype none

module MEM(
input wire clk,
input wire rst,
input wire [4:0] rd_r,
input wire [2:0] func3, //func3, to be forwarded
input wire [6:0] opcode, //opcode, to be forwarded
input wire [31:0] result, //result  from the ALU
input wire [31:0] DataStore, //data  to store into Data  memory
// flags out
input wire lt, //lt flag, to be forwarded
input wire ltu, //ltu flag, to be  forwarded
input wire [31:0] Data_read, //Data read from the Data memory 
// PC forward
input wire [31:0] PC, //PC to be forwarded
output wire cs_d_n, //chip select  signal for Data Memoruy
output wire rd, //read signal for data mem
output wire wr, //write signal for data mem
output wire [4:0] rd_MEM,
output wire [2:0] func3_MEM, //func3 forward
output wire [6:0] opcode_MEM, //opcode forward
output wire [31:0] d_addr, //address for data mem
output wire [31:0] Data_write, //data to write into data mem
output wire [31:0] Data_out_MEM, //data read from the data mem
//flags forwarding
output wire lt_MEM, //lt forward
output wire ltu_MEM, //ltu forward
//pipeline forwarding
output wire [31:0] result_MEM, //result forward
output wire [31:0] PC_MEM //PC forward
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

assign lt_MEM = lt;
assign ltu_MEM = ltu;
assign PC_MEM = PC;
assign result_MEM = result;
assign Data_out_MEM = Data_read;
assign opcode_MEM = opcode;
assign func3_MEM = func3;
assign rd_MEM = rd_r;

assign d_addr = ~cs_d_n ? result : 32'dz;
assign Data_write = ~cs_d_n ? DataStore : 32'dz;

assign rd = (opcode == I2)? 1'b1: 1'bz;
assign wr = (opcode == S)? 1'b1 : 1'bz;
assign cs_d_n = ((rd == 1) || (wr == 1))? 1'b0 : 1'b1; //activate chip select only if read and write is activated

endmodule