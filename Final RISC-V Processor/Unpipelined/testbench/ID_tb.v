`timescale 1ns / 1ps
`default_nettype none

module ID_tb;
reg clk;
reg rst;
reg [31:0] instrCode;
reg [31:0] Data_WB;
reg [31:0] PC;
reg [31:0] PC_4;
//Data forwards to next stage
wire [31:0] Read1;
wire [31:0] Read2;
wire [31:0] immOut;
//instruction forwards to next stage
wire [6:0] opcode;
wire [2:0] func3;
//control signlas
wire su;
wire [1:0] whb;
wire [1:0] wos;
wire [3:0] alu_ctrl;
//pipeline forwards
wire [31:0] PC_ID;
wire [31:0] PC_4_ID;

ID DUT(
clk,
rst,
instrCode,
Data_WB,
PC,
PC_4,
//Data forwards to next stage
Read1,
Read2,
immOut,
//instruction forwards to next stage
opcode,
func3,
//control signlas
su,
whb,
wos,
alu_ctrl,
//pipeline forwards
PC_ID,
PC_4_ID
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    #8
    rst <= 1;
    instrCode <= 32'h100302e7;
    Data_WB <= 32'd100;
    PC <= 32'hc;
    PC_4 <= 32'h10;

end

endmodule