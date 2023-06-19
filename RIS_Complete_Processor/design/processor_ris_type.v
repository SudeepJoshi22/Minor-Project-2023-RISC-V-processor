`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2023 00:14:10
// Design Name: 
// Module Name: processor_i_type
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module processor_ris_type(
input clk,
input rst,
output wire [31:0] result,
output wire zero
);

wire [31:0] instrCode;
wire RegWrite;
wire [31:0] A,B;
wire [4:0] rs1,rs2,rd;
wire [11:0] imm;
wire [31:0] WriteData;
wire [31:0] immOut;
wire [3:0] alu_ctrl;
wire rw;
wire MemToReg;
wire AluSrc;
wire [31:0] Bi;
wire [31:0] read_data;
wire [1:0] whb;
wire [31:0] B_ext;
wire [31:0] WriteData_ext;
wire su;
wire wos;
wire lt,ltu;
wire [31:0] WriteData_ext_set,set;

assign imm = instrCode[31:20];
assign rs1 = instrCode[19:15];
assign rs2 = instrCode[24:20];
assign rd = instrCode[11:7];

//IF
instr_fetch IF(
clk,
rst,
instrCode
);

//ID
reg_file_i REG_FILE(
clk,RegWrite,rst,
rs1,rs2,rd,
WriteData_ext_set,
A,B
);

store_whb STORE_WHB(
B,
whb,
B_ext
);

//Imm Gen
imm_gen IMM_GEN(
instrCode,
immOut
);

//Control Unit
control_unit_i CONTROL_UNIT(
instrCode,
RegWrite,
alu_ctrl,
rw,
MemToReg,
AluSrc,
whb,
su,
wos
);


assign Bi = (AluSrc)? immOut : B;
//EX
alu ALU(
A,
Bi,
alu_ctrl,
result,
zero,
lt,
ltu
);

//MEM
data_mem MEM(
clk,
rst,
rw,
result,
B_ext,
read_data
);

//WB
assign WriteData = (MemToReg)? read_data : result;

signext SIGNEXT(
WriteData,
whb,
su,
WriteData_ext
);

assign WriteData_ext_set = (wos) ? WriteData_ext : set;
assign set = (lt | ltu) ? 32'd1: 32'd0;

endmodule
