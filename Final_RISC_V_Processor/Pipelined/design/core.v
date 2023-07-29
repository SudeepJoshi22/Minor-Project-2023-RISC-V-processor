module core(
  // Input ports
  input wire clk,
  input wire rst,
  input wire [31:0] i_data,
  input wire [31:0] d_data,
  // Output ports
  output wire cs_i_n,
  output wire cs_d_n,
  output wire rd,
  output wire wr,
  output wire [31:0] i_addr,
  output wire [31:0] d_addr,
  output wire [31:0] Data_write_MEM,
  output wire [31:0] result_EX,
  output wire [31:0] DataOut_WB
);

/////IF
wire [31:0] instrCode;
wire [31:0] PC_IF;

// IF_ID stage outputs (wires)
wire [31:0] instrCode_IF_ID;
wire [31:0] PC_IF_IF_ID;

// ID - stage
wire [31:0] PC;
wire read_data_valid;
wire [3:0] alu_ctrl;
wire [31:0] immOut;
wire [31:0] Read1;
wire [31:0] Read2;
wire [2:0] func3;
wire [6:0] opcode;
wire [31:0] PC_ID;
wire [4:0] rd_ID;

// ID_EX
wire read_data_valid_ID_EX;
wire [3:0] alu_ctrl_ID_EX;
wire [31:0] immOut_ID_EX;
wire [31:0] Read1_ID_EX;
wire [31:0] Read2_ID_EX;
wire [4:0] rd_ID_EX;
wire [2:0] func3_ID_EX;
wire [6:0] opcode_ID_EX;
wire [31:0] PC_ID_ID_EX;

// EX - stage
wire [2:0] func3_EX;
wire [4:0] rd_EX;
wire [6:0] opcode_EX;
//wire [31:0] result;
wire [31:0] DataStore;
wire PC_src;
wire jalr;
wire lt;
wire ltu;
wire [31:0] immOut_EX;
wire [31:0] PC_EX;

  // EX_MEM
wire [2:0] func3_EX_EX_MEM;
wire [4:0] rd_EX_EX_MEM;
wire [6:0] opcode_EX_EX_MEM;
wire [31:0] result_EX_MEM;
wire [31:0] DataStore_EX_MEM;
wire lt_EX_MEM;
wire ltu_EX_MEM;
wire [31:0] PC_EX_EX_MEM;

  // MEM - stage
wire [4:0] rd_MEM;
wire [2:0] func3_MEM;
wire [6:0] opcode_MEM;
wire [31:0] Data_write;
wire [31:0] Data_out_MEM;
wire lt_MEM;
wire ltu_MEM;
wire [31:0] result_MEM;
wire [31:0] PC_MEM;
  // MEM_WB
wire [4:0] rd_MEM_MEM_WB;
wire [2:0] func3_MEM_MEM_WB;
wire [6:0] opcode_MEM_MEM_WB;
wire [31:0] Data_out_MEM_MEM_WB;
wire lt_MEM_MEM_WB;
wire ltu_MEM_MEM_WB;
wire [31:0] result_MEM_MEM_WB;
wire [31:0] PC_MEM_MEM_WB;

  // WB - stage
wire [4:0] rd_WB;
wire RegWrite;
//wire [31:0] DataOut_WB;
//  wire [31:0] DataOut_WB_MEM;

// Instantiate the IF stage (M0)
IF IF_inst (
    .clk(clk),
    .rst(rst),
    .PC_src(PC_src),
    .jalr(jalr),
    .result_EX(result_EX),
    .immOut_EX(immOut_EX),
    .instr_read(i_data),
    .cs_i_n(cs_i_n),
    .i_addr(i_addr),
    .instrCode(instrCode),
    .PC_IF(PC_IF)
);

// Instantiate IF_ID register
IF_ID IF_ID_inst (
    .clk(clk),
    .rst(rst),
    .instrCode(instrCode),
    .PC_IF(PC_IF),
    .instrCode_IF_ID(instrCode_IF_ID),
    .PC_IF_IF_ID(PC_IF_IF_ID)
);

  // Instantiate the ID stage (M1)
ID ID_inst (
    .clk(clk),
    .rst(rst),
    .RegWrite(RegWrite),
    .rd_WB(rd_WB),
    .instrCode(instrCode_IF_ID),
    .Data_WB(DataOut_WB),
    .PC(PC_IF_IF_ID),
    .read_data_valid(read_data_valid),
    .alu_ctrl(alu_ctrl),
    .immOut(immOut),
    .Read1(Read1),
    .Read2(Read2),
    .rd(rd_ID),
    .func3(func3),
    .opcode(opcode),
    .PC_ID(PC_ID)
);

  // Instantiate the ID_EX module
ID_EX ID_EX_inst (
    .clk(clk),
    .rst(rst),
    .read_data_valid(read_data_valid),
    .alu_ctrl(alu_ctrl),
    .immOut(immOut),
    .Read1(Read1),
    .Read2(Read2),
    .rd(rd_ID),
    .func3(func3),
    .opcode(opcode),
    .PC_ID(PC_ID),
    .read_data_valid_ID_EX(read_data_valid_ID_EX),
    .alu_ctrl_ID_EX(alu_ctrl_ID_EX),
    .immOut_ID_EX(immOut_ID_EX),
    .Read1_ID_EX(Read1_ID_EX),
    .Read2_ID_EX(Read2_ID_EX),
    .rd_ID_EX(rd_ID_EX),
    .func3_ID_EX(func3_ID_EX),
    .opcode_ID_EX(opcode_ID_EX),
    .PC_ID_ID_EX(PC_ID_ID_EX)
);

  // Instantiate the EX stage (M2)
EX EX_inst (
    .clk(clk),
    .rst(rst),
    .read_data_valid(read_data_valid_ID_EX),
    .alu_ctrl(alu_ctrl_ID_EX),
    .immOut(immOut_ID_EX),
    .Read1(Read1_ID_EX),
    .Read2(Read2_ID_EX),
    .rd(rd_ID_EX),
    .func3(func3_ID_EX),
    .opcode(opcode_ID_EX),
    .PC(PC_ID_ID_EX),
    .func3_EX(func3_EX),
    .rd_EX(rd_EX),
    .opcode_EX(opcode_EX),
    .result(result_EX),
    .DataStore(DataStore),
    .PC_src(PC_src),
    .jalr(jalr),
    .lt(lt),
    .ltu(ltu),
    .immOut_EX(immOut_EX),
    .PC_EX(PC_EX)
);

// Instantiate the EX_MEM module
    EX_MEM ex_mem_inst (
      .clk(clk),
      .rst(rst),
      .func3_EX(func3_EX),
      .rd_EX(rd_EX),
      .opcode_EX(opcode_EX),
      .result(result_EX),
      .DataStore(DataStore),
      .lt(lt),
      .ltu(ltu),
      .PC_EX(PC_EX),
      .func3_EX_EX_MEM(func3_EX_EX_MEM),
      .rd_EX_EX_MEM(rd_EX_EX_MEM),
      .opcode_EX_EX_MEM(opcode_EX_EX_MEM),
      .result_EX_MEM(result_EX_MEM),
      .DataStore_EX_MEM(DataStore_EX_MEM),
      .lt_EX_MEM(lt_EX_MEM),
      .ltu_EX_MEM(ltu_EX_MEM),
      .PC_EX_EX_MEM(PC_EX_EX_MEM)
  );

// Instantiate the MEM stage (M3)
    MEM mem_inst (
      .clk(clk),
      .rst(rst),
      .rd_r(rd_EX_EX_MEM),
      .func3(func3_EX_EX_MEM),
      .opcode(opcode_EX_EX_MEM),
      .result(result_EX_MEM),
      .DataStore(DataStore_EX_MEM),
      .lt(lt_EX_MEM),
      .ltu(ltu_EX_MEM),
      .Data_read(d_data),
      .PC(PC_EX_EX_MEM),
      .cs_d_n(cs_d_n),
      .rd(rd),
      .wr(wr),
      .rd_MEM(rd_MEM),
      .func3_MEM(func3_MEM),
      .opcode_MEM(opcode_MEM),
      .d_addr(d_addr),
      .Data_write(Data_write),
      .Data_out_MEM(Data_out_MEM),
      .lt_MEM(lt_MEM),
      .ltu_MEM(ltu_MEM),
      .result_MEM(result_MEM),
      .PC_MEM(PC_MEM)
  );

  // Instantiate the MEM_WB module
    MEM_WB mem_wb_inst (
      .clk(clk),
      .rst(rst),
      .rd_MEM(rd_MEM),
      .func3_MEM(func3_MEM),
      .opcode_MEM(opcode_MEM),
      .Data_out_MEM(Data_out_MEM),
      .lt_MEM(lt_MEM),
      .ltu_MEM(ltu_MEM),
      .result_MEM(result_MEM),
      .PC_MEM(PC_MEM),
      .rd_MEM_MEM_WB(rd_MEM_MEM_WB),
      .func3_MEM_MEM_WB(func3_MEM_MEM_WB),
      .opcode_MEM_MEM_WB(opcode_MEM_MEM_WB),
      .Data_out_MEM_MEM_WB(Data_out_MEM_MEM_WB),
      .lt_MEM_MEM_WB(lt_MEM_MEM_WB),
      .ltu_MEM_MEM_WB(ltu_MEM_MEM_WB),
      .result_MEM_MEM_WB(result_MEM_MEM_WB),
      .PC_MEM_MEM_WB(PC_MEM_MEM_WB)
  );

  // Instantiate the WB stage (M4)
    WB wb_inst (
      .clk(clk),
      .rst(rst),
      .rd(rd_MEM_MEM_WB),
      .func3(func3_MEM_MEM_WB),
      .opcode(opcode_MEM_MEM_WB),
      .read_data(Data_out_MEM_MEM_WB),
      .lt(lt),
      .ltu(ltu),
      .result(result_MEM_MEM_WB),
      .PC(PC),
      .rd_WB(rd_WB),
      .RegWrite(RegWrite),
      .DataOut_WB(DataOut_WB)
  );

endmodule
