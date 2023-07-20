`timescale 1ns / 1ps
`default_nettype none

module top_module(
input wire clk,
input wire rst_n,
input wire [31:0] i_data,
input wire [31:0] d_data,
output wire cs_i_n,
output wire cs_d_n,
output wire rd,
output wire wr,
output wire [31:0] i_addr,
output wire [31:0] d_addr
);

core(
input wire clk,
input wire rst_n,
input wire [31:0] i_data,
input wire [31:0] d_data,
output wire cs_i_n,
output wire cs_d_n,
output wire [31:0] i_addr,
output wire [31:0] d_addr
);

instr_mem(
input wire [31:0] iaddr,
input wire rst,
input wire cs_n,
output reg [31:0] instrCode
);

data_mem(
input wire clk,
input wire rst,
input wire rd,
input wire wr,
input wire [31:0] addr,
input wire [31:0] write_data,
output wire [31:0] read_data
);

endmodule