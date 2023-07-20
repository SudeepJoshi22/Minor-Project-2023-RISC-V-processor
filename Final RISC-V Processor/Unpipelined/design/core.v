`timescale 1ns / 1ps
`default_nettype none

module core(
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

////IF
wire PC_src;
wire jalr;
wire [31:0]immOut_EX;
wire [31:0] instrCode;
//PC forwards
wire [31:0] PC_IF;
wire [31:0] PC_4_IF;

////ID
//Data forwards to next stage
wire [31:0] Read1;
wire [31:0] Read2;
wire [31:0] immOut;
//instruction forwards to next stage
wire [5:0] opcode;
wire [2:0] func3;
//control signlas
wire su;
wire [1:0] whb;
wire [1:0] wos;
wire [3:0] alu_ctrl;
//pipeline forwards
wire [31:0] PC_ID;
wire [31:0] PC_4_ID;

////EX
wire [31:0] result;
wire [31:0] Data_store;
//flags out
wire lt;
wire ltu;
//control signals out
wire su_EX;
wire [1:0] whb_EX;
wire [1:0] wos_EX;
//intruction forward
wire [5:0] opcode_EX;
//PC forwards
wire [31:0] PC_4_EX;

////MEM
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
wire [5:0] opcode_MEM;
wire [31:0] result_MEM;
wire [31:0] PC_4_MEM;

////WB
wire [31:0] DataOut_WB;

IF M0(
clk,
rst_n,
PC_src,
jalr,
result,
immOut_EX,
i_data,
cs_i_n,
i_addr,
instrCode,
//PC forwards
PC_IF,
PC_4_IF
);

ID M1(
clk,
rst_n,
instrCode,
DataOut_WB,
PC_IF,
PC_4_IF,
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

EX M2(
clk,
rst_n,
Read1,
Read2,
immOut,
PC_ID,
PC_4_ID,
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

MEM M3(
clk,
rst_n,
result,
Data_store,
opcode_EX,
d_data,
PC_4_EX,
su_EX,
whb_EX,
wos_EX,
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

WB M4(
clk,
rst_n,
d_data,
result_MEM,
opcode_MEM,
PC_4_MEM,
su_MEM,
whb_MEM,
wos_MEM,
lt_MEM,
ltu_MEM,
DataOut_WB
);
endmodule