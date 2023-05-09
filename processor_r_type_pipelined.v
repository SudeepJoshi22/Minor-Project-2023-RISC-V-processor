`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2023 16:36:50
// Design Name: 
// Module Name: processor_r_type_pipelined
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


module processor_r_type_pipelined(
input clk,rst,
output [31:0] result,
output zero
);

wire [31:0] instrCode,instrCode_IF_ID;
wire [3:0] alu_ctrl;
wire RegWrite,RegWrite_ID_EX,RegWrite_EX_WB;
wire [4:0] ReadAddr1,ReadAddr2,WriteAddr;
wire [31:0]  ReadData1,ReadData2;
wire [4:0] rs1,rs2,rd;
wire [31:0] data1_ID_EX,data2_ID_EX;
wire [3:0] alu_ctrl_ID_EX;
wire [4:0] rd_ID_EX;
wire [4:0] rd_EX_WB;
wire [31:0] result_EX_WB;

assign rs1 = instrCode_IF_ID[19:15];
assign rs2 = instrCode_IF_ID[24:20];
assign rd = instrCode_IF_ID[11:7];

instr_fetch IF(
clk,rst,
instrCode
);

IF_ID IF_ID(
clk,rst,
instrCode,
instrCode_IF_ID
);

control_unitr ID(
instrCode_IF_ID,
alu_ctrl,
RegWrite
);

reg_file REG_FILE(
clk,RegWrite_EX_WB,rst,
rs1,rs2,rd,
result_EX_WB,
ReadData1,ReadData2
);

ID_EX ID_EX(
clk,rst,RegWrite,
ReadData1,ReadData2,
alu_ctrl,
rd,
RegWrite_ID_EX,
data1_ID_EX,data2_ID_EX,
alu_ctrl_ID_EX,
rd_ID_EX
);

alu_r EX(
data1_ID_EX,
data2_ID_EX,
alu_ctrl_ID_EX,
result,
zero
);

EX_WB EX_WB(
clk,rst,RegWrite_ID_EX,
rd_ID_EX,
result,
RegWrite_EX_WB,
rd_EX_WB,
result_EX_WB
);

endmodule
