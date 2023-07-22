`timescale 1ns / 1ps
`default_nettype none

module top_module_tb;
reg clk;
reg rst_n;
wire cs_i_n;
wire cs_d_n;
wire [31:0] i_addr;
wire [31:0] result;
wire [31:0] DataOut_WB;
//wire [31:0] i_addr,
wire [31:0] d_addr;
wire [31:0] Data_write;
wire [31:0] i_data;
wire [31:0] d_data;
wire rd;
wire wr;

top_module DUT(
clk,
rst_n,
i_data,
d_data,
rd,
wr,
cs_i_n,
cs_d_n,
i_addr,
result,
DataOut_WB,
d_addr,
Data_write
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst_n <= 0;
    #15
    rst_n <= 1;
end

endmodule