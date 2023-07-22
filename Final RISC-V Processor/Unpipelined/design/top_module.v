`timescale 1ns / 1ps
`default_nettype none

module top_module(
input wire clk,
input wire rst_n,
output wire [31:0] i_addr,
output wire [31:0] result,
output wire [31:0] DataOut_WB
);

wire [31:0] i_data;
wire [31:0] d_data;
wire cs_i_n;
wire cs_d_n;
wire rd;
wire wr;
//wire [31:0] i_addr,
wire [31:0] d_addr;
wire [31:0] Data_write;

core M0(
clk,
rst_n,
i_data,
d_data,
cs_i_n,
cs_d_n,
i_addr,
rd,
wr,
d_addr,
Data_write,
result,
DataOut_WB
);

instr_mem M1(
clk,
i_addr,
rst_n,
cs_i_n,
i_data
);

data_mem M2(
clk,
rst_n,
rd,
wr,
cs_d_n,
d_addr,
Data_write,
d_data
);

endmodule