`timescale 1ns / 1ps
`default_nettype none

module top_module_tb;
reg clk;
reg rst_n;
wire [31:0] i_addr;
wire [31:0] result;
wire [31:0] DataOut_WB;

top_module DUT(
clk,
rst_n,
i_addr,
result,
DataOut_WB
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