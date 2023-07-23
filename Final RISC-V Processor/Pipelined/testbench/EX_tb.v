`timescale 1ns / 1ps
`default_nettype none

module EX_tb;
reg clk;
reg  rst;
reg  [31:0] Read1;
reg  [31:0] Read2;
reg  [31:0] immOut;
reg  [31:0] PC;
reg  [31:0] PC_4;
reg  [3:0] alu_ctrl;
reg  [2:0] func3;
reg  [5:0] opcode;
//control signals to forward
reg  su;
reg  [1:0] whb;
reg  [1:0] wos;
//output;
wire [31:0] result;
wire [31:0] Data_store;
wire PC_src;
wire jalr;
//flags out
wire lt;
wire ltu;
//control signals out
wire su_EX;
wire [1:0] whb_EX;
wire [1:0] wos_EX;
//intruction forward
wire [5:0] opcode_EX;
//immOut for IF stage
wire [31:0] immOut_EX;
//PC forwards
wire [31:0] PC_4_EX;

EX DUT(
clk,
rst,
Read1,
Read2,
immOut,
PC,
PC_4,
alu_ctrl,
func3,
opcode,
//control signals to forward
su,
whb,
wos,
//outputs
result,
Data_store,
PC_src,
jalr,
//flags out
lt,
ltu,
//control signals out
su_EX,
whb_EX,
wos_EX,
//intruction forward
opcode_EX,
//immOut for IF stage
immOut_EX,
//PC forwards
PC_4_EX
);

initial clk <=0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    Read1 <= 32'h100;
    Read2 <= 32'hff0;
    immOut <= 32'h200;
    PC <= 32'hc;
    PC_4 <= 32'h10;
    alu_ctrl <= 4'b0000;
    opcode <= 7'b0110011;
    func3 <= 3'b000;
    su <= 1;
    whb <= 2'b01;
    wos <= 2'b11;
    #8
    rst <= 1;
    #10
    opcode <= 7'b0010011;
    #10
    opcode <= 7'b1100011;
    func3 <= 3'b001;
    #10
    alu_ctrl <= 4'b0001;
    

end

endmodule