`timescale 1ns / 1ps
`default_nettype none

module IF_tb;
reg clk;
reg rst;
reg PC_src;
reg jalr;
reg [31:0]result_EX;
reg [31:0]immOut_EX;
reg [31:0] instr_read;
wire cs_i_n;
wire [31:0] i_addr;
wire [31:0] instrCode;
//PC forwards
wire [31:0] PC_IF;
wire [31:0] PC_4_IF;

IF DUT(
clk,
rst,
PC_src,
jalr,
result_EX,
immOut_EX,
instr_read,
cs_i_n,
i_addr,
instrCode,
//PC forwards
PC_IF,
PC_4_IF
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    PC_src <= 0;
    jalr <= 0;
    result_EX <= 32'd100;
    immOut_EX <= 32'd20;
    instr_read <= 32'd1000;
    #18
    rst <= 1;
    #40
    PC_src <= 1;
    #20
    jalr <= 1;
end


endmodule