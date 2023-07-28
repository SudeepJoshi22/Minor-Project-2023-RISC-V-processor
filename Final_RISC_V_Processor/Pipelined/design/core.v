module core(
  // Input ports
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
  output wire [31:0] Data_write_MEM,
  output wire [31:0] result_EX,
  output wire [31:0] DataOut_WB
);

  // IF - stage
  wire PC_src;
  wire jalr;
  wire [31:0] immOut_EX;
  wire [31:0] instrCode;
  // PC forwards
  wire [31:0] PC_IF;
  wire [31:0] PC_4_IF;

  // IF_ID
  wire [31:0] instrCode_IF_ID;
  wire [31:0] PC_IF_ID;
  wire [31:0] PC_4_IF_ID;

  // ID - stage
  // Data forwards to the next stage
  wire [31:0] Read1;
  wire [31:0] Read2;
  wire [31:0] immOut;
  // Instruction forwards to the next stage
  wire [6:0] opcode;
  wire [2:0] func3;
  // Control signals
  wire su;
  wire [1:0] whb;
  wire [1:0] wos;
  wire [3:0] alu_ctrl;
  // Pipeline forwards
  wire [31:0] PC_ID;
  wire [31:0] PC_4_ID;

  // ID_EX
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

  // EX - stage
 // wire [31:0] result_EX;
  wire [31:0] Data_store;
  // Flags out
  wire lt;
  wire ltu;
  // Control signals out
  wire su_EX;
  wire [1:0] whb_EX;
  wire [1:0] wos_EX;
  // Instruction forward
  wire [6:0] opcode_EX;
  // PC forwards
  wire [31:0] PC_4_EX;

  // EX_MEM
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

  // MEM - stage
  //wire [31:0] Data_write_MEM;
  wire [31:0] Data_out_MEM;
  // Control signals forwarding
  wire su_MEM;
  wire [1:0] whb_MEM;
  wire [1:0] wos_MEM;
  // Flags forwarding
  wire lt_MEM;
  wire ltu_MEM;
  // Pipeline forwarding
  wire [6:0] opcode_MEM;
  wire [31:0] result_MEM;
  wire [31:0] PC_4_MEM;

  // MEM_WB
  wire [31:0] Data_out_MEM_MEM_WB;
  wire su_MEM_MEM_WB;
  wire [1:0] whb_MEM_MEM_WB;
  wire [1:0] wos_MEM_MEM_WB;
  wire lt_MEM_MEM_WB;
  wire [1:0] ltu_MEM_MEM_WB;
  wire [6:0] opcode_MEM_MEM_WB;
  wire [31:0] result_MEM_MEM_WB;
  wire [31:0] PC_4_MEM_MEM_WB;

  // WB - stage
  wire RegWrite;
//  wire [31:0] DataOut_WB_MEM;

  // Instantiate the IF stage (M0)
  IF M0(
    clk,
    rst_n,
    PC_src,
    jalr,
    result_EX,
    immOut_EX,
    i_data,
    cs_i_n,
    i_addr,
    instrCode,
    // PC forwards
    PC_IF,
    PC_4_IF
  );

  // Instantiate the IF_ID module
  IF_ID IF_ID_inst (
    clk,
    rst_n,
    instrCode,
    PC_IF,
    PC_4_IF,
    instrCode_IF_ID,
    PC_IF_ID,
    PC_4_IF_ID
  );

  // Instantiate the ID stage (M1)
  ID M1(
    clk,
    rst_n,
    instrCode_IF_ID,
    DataOut_WB,
    PC_IF_ID,
    PC_4_IF_ID,
    RegWrite,
    // Data forwards to the next stage
    Read1,
    Read2,
    immOut,
    // Instruction forwards to the next stage
    opcode,
    func3,
    // Control signals
    su,
    whb,
    wos,
    alu_ctrl,
    // Pipeline forwards
    PC_ID,
    PC_4_ID
  );

  // Instantiate the ID_EX module
  ID_EX ID_EX_inst (
    clk,
    rst_n,
    Read1,
    Read2,
    immOut,
    opcode,
    func3,
    su,
    whb,
    wos,
    alu_ctrl,
    PC_ID,
    PC_4_ID,
    Read1_ID_EX,
    Read2_ID_EX,
    immOut_ID_EX,
    opcode_ID_EX,
    func3_ID_EX,
    su_ID_EX,
    whb_ID_EX,
    wos_ID_EX,
    alu_ctrl_ID_EX,
    PC_ID_ID_EX,
    PC_4_ID_ID_EX
  );

  // Instantiate the EX stage (M2)
  EX M2(
    clk,
    rst_n,
    Read1_ID_EX,
    Read2_ID_EX,
    immOut_ID_EX,
    PC_ID_ID_EX,
    PC_4_ID_ID_EX,
    alu_ctrl_ID_EX, 
    func3_ID_EX,
    opcode_ID_EX,
    su_ID_EX,
    whb_ID_EX,
    wos_ID_EX,
    result_EX,
    Data_store,
    PC_src,
    jalr,
    lt,
    ltu,
    su_EX,
    whb_EX,
    wos_EX,
    opcode_EX,
    immOut_EX,
    PC_4_EX
  );

  // Instantiate the EX_MEM module
  EX_MEM EX_MEM_inst (
    clk,
    rst_n,
    result_EX,
    Data_store,
    lt,
    ltu,
    su_EX,
    whb_EX,
    wos_EX,
    opcode_EX,
    immOut_EX,
    PC_4_EX,
    result_EX_MEM,
    Data_store_EX_MEM,
    lt_EX_MEM,
    ltu_EX_MEM,
    su_EX_EX_MEM,
    whb_EX_EX_MEM,
    wos_EX_EX_MEM,
    opcode_EX_EX_MEM,
    immOut_EX_EX_MEM,
    PC_4_EX_EX_MEM
  );

  // Instantiate the MEM stage (M3)
  MEM M3(
    clk,
    rst_n,
    result_EX_MEM,
    Data_store_EX_MEM,
    opcode_EX_EX_MEM,
    d_data,
    PC_4_EX_EX_MEM,
    su_EX_EX_MEM,
    whb_EX_EX_MEM,
    wos_EX_EX_MEM,
    lt_EX_MEM,
    ltu_EX_MEM,
    cs_d_n,
    rd,
    wr,
    d_addr, // address for data mem
    Data_write_MEM, // data to write into data mem
    Data_out_MEM, // data read from the data mem
    su_MEM,
    whb_MEM,
    wos_MEM,
    lt_MEM,
    ltu_MEM,
    opcode_MEM,
    result_MEM,
    PC_4_MEM
  );

  // Instantiate the MEM_WB module
  MEM_WB MEM_WB_inst (
    clk,
    rst_n,
    Data_out_MEM,
    su_MEM,
    whb_MEM,
    wos_MEM,
    lt_MEM,
    ltu_MEM,
    opcode_MEM,
    result_MEM,
    PC_4_MEM,
    Data_out_MEM_MEM_WB,
    su_MEM_MEM_WB,
    whb_MEM_MEM_WB,
    wos_MEM_MEM_WB,
    lt_MEM_MEM_WB,
    ltu_MEM_MEM_WB,
    opcode_MEM_MEM_WB,
    result_MEM_MEM_WB,
    PC_4_MEM_MEM_WB
  );

  // Instantiate the WB stage (M4)
  WB M4(
    clk,
    rst_n,
    Data_out_MEM_MEM_WB,
    result_MEM_MEM_WB,
    opcode_MEM_MEM_WB,
    PC_4_MEM_MEM_WB,
    su_MEM_MEM_WB,
    whb_MEM_MEM_WB,
    wos_MEM_MEM_WB,
    lt_MEM_MEM_WB,
    ltu_MEM_MEM_WB,
    RegWrite,
    DataOut_WB
  );

endmodule
