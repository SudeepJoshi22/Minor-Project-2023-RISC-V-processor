`timescale 1ns / 1ps
`default_nettype none

module processor_unpipelined(   
input wire clk,
input wire rst,
output wire [31:0] result,
output wire [31:0] WriteData_ext_set,
output wire zero,
output wire lt,
output wire ltu,
output wire [31:0] PC

);

wire [6:0] opcode;
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
wire [31:0] Bi,Ai;
wire [31:0] read_data;
wire [1:0] whb;
wire [31:0] B_ext;
wire [31:0] WriteData_ext;
wire su;
wire [1:0]wos;
wire set;
wire boj;
wire jalr;
wire PC_src;
wire [31:0] PC_4;

parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011,BR=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

assign imm = instrCode[31:20];
assign rs1 = instrCode[19:15];
assign rs2 = instrCode[24:20];
assign rd = instrCode[11:7];
assign opcode = instrCode[6:0];

assign Ai = (opcode==J || opcode==UPC)? PC:A;  // a can either be pc or rs1
assign Bi = (opcode==R || opcode==BR)? B:immOut; // b can either be rs2 or imm 

assign set = (lt | ltu) ? 32'd1: 32'd0;
assign WriteData_ext_set = wos[1]? (wos[0]? 32'dz : PC_4) : (wos[0]? WriteData_ext : set);
assign WriteData = (opcode == I2)? read_data : result;  

assign jalr = (opcode == JR)? 1'b1: 1'b0;
assign RegWrite = (opcode == S || opcode == BR)? 1'b0:1'b1;

assign boj = ((opcode == B) || (opcode == J) || (opcode == JR))? 1'b1:1'b0;

assign rw = (opcode == I2)? 1'b1:1'b0;

//IF
instr_fetch IF(
clk,
rst,
PC_src,
jalr,
result,
immOut,
instrCode,
PC,
PC_4
);

//ID
reg_file REG_FILE(
clk,
RegWrite,
rst,
rs1,
rs2,
rd,
WriteData_ext_set,
A,
B
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
control_unit CONTROL_UNIT(
instrCode,
alu_ctrl,
whb,
su,
wos
);

//EX
alu ALU(
Ai,
Bi,
alu_ctrl,
result,
zero,
lt,
ltu
);

//PC_SRC
PC_src BRANCH_JUMP(
boj,
zero,
lt,
ltu,
instrCode,
PC_src);

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
signext SIGNEXT(
WriteData,
whb,
su,
WriteData_ext
);


endmodule
