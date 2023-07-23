`timescale 1ns / 1ps
`default_nettype none

module MEM_tb;

reg clk;
reg rst;
reg [31:0] result;
reg [31:0] Data_store;
reg [6:0] opcode;
reg [31:0] Data_read;
reg [31:0] PC_4;
reg su;
reg [1:0] whb;
reg [1:0] wos;
reg lt;
reg ltu;

wire cs_d_n;
wire rd;
 wire wr;
 wire [31:0] d_addr; //address for data mem
 wire [31:0] Data_write; //data to write into data mem
 wire [31:0] Data_out_MEM; //data read from the data mem
//control signals forwarding
 wire su_MEM;
 wire [1:0] whb_MEM;
 wire [1:0] wos_MEM;
//flags forwarding
wire lt_MEM;
 wire ltu_MEM;
//pipeline forwarding
 wire [6:0] opcode_MEM;
 wire [31:0] result_MEM;
 wire [31:0] PC_4_MEM;

MEM DUT(
clk,
rst,
 result,
 Data_store,
 opcode,
 Data_read,
 PC_4,
su,
 whb,
 wos,
 lt,
ltu,
cs_d_n,
rd,
wr,
 d_addr, //address for data mem
Data_write, //data to write into data mem
Data_out_MEM, //data read from the data mem
//control signals forwarding
su_MEM,
whb_MEM,
 wos_MEM,
//flags forwarding
 lt_MEM,
ltu_MEM,
//pipeline forwarding
 opcode_MEM,
result_MEM,
 PC_4_MEM
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    result <= 32'd300;
    Data_store <= 32'h200;
    opcode <= 7'b0000011;
    Data_read <= 32'd400;
    PC_4 <= 32'h8;
    su <= 1;
    whb <= 2'b01;
    wos <= 2'b11;
    lt <= 1;
    ltu <= 0;
    #8
    rst <= 1;
    #10 
    opcode <= 7'b0100011;
end

endmodule