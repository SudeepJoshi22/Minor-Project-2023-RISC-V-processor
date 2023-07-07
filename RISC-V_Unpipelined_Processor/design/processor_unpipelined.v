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


module processor_unpipelined(   
input clk,
input rst,
output wire [31:0] result,
output wire [31:0] WriteData_ext_set,
output wire zero,
wire lt,
wire ltu
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
wire [31:0] Bi;
wire [31:0] read_data;
wire [1:0] whb;
wire [31:0] B_ext;
wire [31:0] WriteData_ext;
wire su;
wire [1:0]wos;
wire set;
wire branch;
wire jump;


assign imm = instrCode[31:20];
assign rs1 = instrCode[19:15];
assign rs2 = instrCode[24:20];
assign rd = instrCode[11:7];
assign opcode = instrCode[6:0];
//IF
instr_fetch IF(
clk,
rst,
PC_src,
result,
instrCode
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
control_unit CONTROL_UNIT(
instrCode,
RegWrite,
alu_ctrl,
rw,
MemToReg,
AluSrc,
whb,
su,
wos,
branch,
jump
);

// mux for ALU
assign Ai = (opcode==7'b1101111||opcode==7'b0010111)? instrCode:A;
assign Bi = (opcode==7'b0110011||opcode==7'b1100011)? B: immOut ;

//a = (opcode==jal || opcode==auipc)? pc:rs1;  // a can either be pc or rs1
//b = (opcode==R || opcode==branch)? rs2:imm; // b can either be rs2 or imm 
        
//assign Bi = (AluSrc)? immOut : B;
//assign Ai = (AluSrc)? instrCode:A;
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
PC_src PC(
branch,
jump,
zero,
lt,
ltu,
instr ,
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
assign WriteData = (MemToReg)? read_data : result;

 
signext SIGNEXT(
WriteData,
whb,
su,
WriteData_ext
);

assign WriteData_ext_set = wos[0]? (wos[1]? result: instrCode +4): (wos[1]? WriteData_ext:set);
assign set = (lt | ltu) ? 32'd1: 32'd0;

endmodule
