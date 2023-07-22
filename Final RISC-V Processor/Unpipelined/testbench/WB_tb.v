`timescale 1ns / 1ps
`default_nettype none

module WB_tb;
reg clk;
reg rst;
reg [31:0] read_data;
reg [31:0] result;
reg [6:0] opcode;
reg [31:0] PC_4;
reg su;
reg [1:0] whb;
reg [1:0] wos;
reg lt;
reg ltu;
wire [31:0] DataOut_WB;

WB DUT(
clk,
rst,
read_data,
result,
opcode,
PC_4,
su,
whb,
wos,
lt,
 ltu,
DataOut_WB
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    read_data <= 32'd100;
    result <= 32'd200;
    opcode <= 7'b0010011;
    PC_4 <= 32'h8;
    su <= 1;
    whb <= 2'b10;
    wos <= 2'b01;
    lt <= 0;
    ltu <= 1;
    #8
    rst <= 1;
    #10
    whb <= 2'b00;
    wos <= 2'b00;
    #10
    wos <= 2'b01;
    #10
    opcode <= 7'b0000011;
end

endmodule