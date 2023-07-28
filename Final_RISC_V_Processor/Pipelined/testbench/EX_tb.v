`timescale 1ns / 1ps
`default_nettype none

module EX_tb;

  // Parameters
  parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011, BR = 7'b1100011, J = 7'b1101111, JR = 7'b1100111, U = 7'b0110111, UPC = 7'b0010111;
  
  // Inputs
  reg clk;
  reg rst;
  reg read_data_valid;
  reg [3:0] alu_ctrl;
  reg [31:0] immOut;
  reg [31:0] Read1;
  reg [31:0] Read2;
  reg [4:0] rd;
  reg [2:0] func3;
  reg [6:0] opcode;
  reg [31:0] PC;
  
  // Outputs
  wire [31:0] result;
  wire [31:0] DataStore;
  wire PC_src;
  wire jalr;
  wire lt;
  wire ltu;
  wire [31:0] immOut_EX;
  wire [31:0] PC_EX;
  
  // Instantiate the EX module
  EX ex_inst (
    // Inputs
    .clk(clk),
    .rst(rst),
    .read_data_valid(read_data_valid),
    .alu_ctrl(alu_ctrl),
    .immOut(immOut),
    .Read1(Read1),
    .Read2(Read2),
    .rd(rd),
    .func3(func3),
    .opcode(opcode),
    .PC(PC),
    // Outputs
    .result(result),
    .DataStore(DataStore),
    .PC_src(PC_src),
    .jalr(jalr),
    .lt(lt),
    .ltu(ltu),
    .immOut_EX(immOut_EX),
    .PC_EX(PC_EX)
  );
initial clk <=0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    read_data_valid <= 1;
    Read1 <= 32'h100;
    Read2 <= 32'hff0;
    immOut <= 32'h200;
    PC <= 32'hc;
    alu_ctrl <= 4'b0000;
    opcode <= 7'b0110011;
    func3 <= 3'b000;
    rd <= 5'b00011;
    #8
    rst <= 1;
    #10
    opcode <= 7'b0010011;
    #10
    opcode <= 7'b1100011;
    func3 <= 3'b001;
    #10
    alu_ctrl <= 4'b0001;
    

end

endmodule