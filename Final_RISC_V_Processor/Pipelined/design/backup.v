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
output wire [31:0] d_addr,
output wire [31:0] Data_write,
output wire [31:0] result,
output wire [31:0] DataOut_WB
);

////IF
wire PC_src;
wire jalr;
wire [31:0]immOut_EX;
wire [31:0] instrCode;
//PC forwards
wire [31:0] PC_IF;
wire [31:0] PC_4_IF;


/////IF_ID
wire [31:0] instrCode_IF_ID;
wire [31:0] PC_IF_ID;
wire [31:0] PC_4_IF_ID;

/////ID
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


/////ID_EX
wire [31:0] Read1_ID_EX;
wire [31:0] Read2_ID_EX;
wire [31:0] immOut_ID_EX;
wire [6:0] opcode_ID_EX;
wire [2:0] func3_ID_EX;
wire su_ID_EX;
wire [1:0] whb_ID_EX;
wire [1:0] wos_ID_EX;
wire [3:0] alu_ctrl_ID_EX;
wire [31:0] PC_ID_ID_EX;
wire [31:0] PC_4_ID_ID_EX;

////EX
//wire [31:0] result;
wire [31:0] Data_store;
//flags out
wire lt;
wire ltu;
//control signals out
wire su_EX;
wire [1:0] whb_EX;
wire [1:0] wos_EX;
//intruction forward
wire [6:0] opcode_EX;
//PC forwards
wire [31:0] PC_4_EX;

/////EX_MEM
wire [31:0] result_EX_MEM;
wire [31:0] Data_store_EX_MEM;
wire lt_EX_MEM;
wire ltu_EX_MEM;
wire su_EX_EX_MEM;
wire [1:0] whb_EX_EX_MEM;
wire [1:0] wos_EX_EX_MEM;
wire [6:0] opcode_EX_EX_MEM;
wire [31:0] immOut_EX_EX_MEM;
wire [31:0] PC_4_EX_EX_MEM;

////MEM
//wire [31:0] Data_write; //data to write into data mem
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

/////MEM_WB
wire [31:0] Data_out_MEM_MEM_WB;
wire su_MEM_MEM_WB;
wire [1:0] whb_MEM_MEM_WB;
wire [1:0] wos_MEM_MEM_WB;
wire lt_MEM_MEM_WB;
wire [1:0] ltu_MEM_MEM_WB;
wire [6:0] opcode_MEM_MEM_WB;
wire [31:0] result_MEM_MEM_WB;
wire [31:0] PC_4_MEM_MEM_WB;

////WB
//wire [31:0] DataOut_WB;


////////////////IF - stage //////////////////
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

////////////////IF_ID //////////////////
  IF_ID IF_ID_inst (
  .clk(clk),
  .rst(rst),
  .instrCode(instrCode),
  .PC(PC),
  .PC_4(PC_4),
  .instrCode_IF_ID(instrCode_IF_ID),
  .PC_IF_ID(PC_IF_ID),
  .PC_4_IF_ID(PC_4_IF_ID)
);

////////////////ID - stage //////////////////
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

////////////////ID-EX//////////////////
  ID_EX ID_EX_inst (
  .clk(clk),
  .rst(rst),
  .Read1(Read1),
  .Read2(Read2),
  .immOut(immOut),
  .opcode(opcode),
  .func3(func3),
  .su(su),
  .whb(whb),
  .wos(wos),
  .alu_ctrl(alu_ctrl),
  .PC_ID(PC_ID),
  .PC_4_ID(PC_4_ID),
  .Read1_ID_EX(Read1_ID_EX),
  .Read2_ID_EX(Read2_ID_EX),
  .immOut_ID_EX(immOut_ID_EX),
  .opcode_ID_EX(opcode_ID_EX),
  .func3_ID_EX(func3_ID_EX),
  .su_ID_EX(su_ID_EX),
  .whb_ID_EX(whb_ID_EX),
  .wos_ID_EX(wos_ID_EX),
  .alu_ctrl_ID_EX(alu_ctrl_ID_EX),
  .PC_ID_ID_EX(PC_ID_ID_EX),
  .PC_4_ID_ID_EX(PC_4_ID_ID_EX)
);

////////////////EX - stage //////////////////
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


////////////////EX-MEM//////////////////
  EX_MEM EX_MEM_inst (
  .clk(clk),
  .rst(rst),
  .result(result),
  .Data_store(Data_store),
  .lt(lt),
  .ltu(ltu),
  .su_EX(su_EX),
  .whb_EX(whb_EX),
  .wos_EX(wos_EX),
  .opcode_EX(opcode_EX),
  .immOut_EX(immOut_EX),
  .PC_4_EX(PC_4_EX),
  .result_EX_MEM(result_EX_MEM),
  .Data_store_EX_MEM(Data_store_EX_MEM),
  .lt_EX_MEM(lt_EX_MEM),
  .ltu_EX_MEM(ltu_EX_MEM),
  .su_EX_EX_MEM(su_EX_EX_MEM),
  .whb_EX_EX_MEM(whb_EX_EX_MEM),
  .wos_EX_EX_MEM(wos_EX_EX_MEM),
  .opcode_EX_EX_MEM(opcode_EX_EX_MEM),
  .immOut_EX_EX_MEM(immOut_EX_EX_MEM),
  .PC_4_EX_EX_MEM(PC_4_EX_EX_MEM)
);


////////////////MEM - stage //////////////////
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

////////////////MEM_WB//////////////////
  MEM_WB MEM_WB_inst (
  .clk(clk),
  .rst(rst),
  .Data_out_MEM(Data_out_MEM),
  .su_MEM(su_MEM),
  .whb_MEM(whb_MEM),
  .wos_MEM(wos_MEM),
  .lt_MEM(lt_MEM),
  .ltu_MEM(ltu_MEM),
  .opcode_MEM(opcode_MEM),
  .result_MEM(result_MEM),
  .PC_4_MEM(PC_4_MEM),
  .Data_out_MEM_MEM_WB(Data_out_MEM_MEM_WB),
  .su_MEM_MEM_WB(su_MEM_MEM_WB),
  .whb_MEM_MEM_WB(whb_MEM_MEM_WB),
  .wos_MEM_MEM_WB(wos_MEM_MEM_WB),
  .lt_MEM_MEM_WB(lt_MEM_MEM_WB),
  .ltu_MEM_MEM_WB(ltu_MEM_MEM_WB),
  .opcode_MEM_MEM_WB(opcode_MEM_MEM_WB),
  .result_MEM_MEM_WB(result_MEM_MEM_WB),
  .PC_4_MEM_MEM_WB(PC_4_MEM_MEM_WB)
);


////////////////WB - stage //////////////////
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
