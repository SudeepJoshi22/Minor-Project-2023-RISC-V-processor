`timescale 1ns / 1ps
`default_nettype none

module ID(
    input wire clk,
    input wire rst,
    input wire [31:0] instrCode,
    input wire [31:0] Data_WB,
    input wire [31:0] PC,
    input wire [31:0] PC_4,
    input wire RegWrite,
    //Data forwards to next stage
    output wire [31:0] Read1,
    output wire [31:0] Read2,
    //pipeline forwards
    output wire [31:0] PC_ID,
    output wire read_data_valid 
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011, BR = 7'b1100011, J = 7'b1101111, JR = 7'b1100111, U = 7'b0110111, UPC = 7'b0010111;

wire [31:0] A, B, B_ext;
wire [4:0] rs1, rs2, rd;

assign rs1 = instrCode[19:15];
assign rs2 = instrCode[24:20];
//assign rd = instrCode[11:7];
assign PC_ID = PC;

assign Read2 = B_ext;
assign Read1 = A;


reg_file REG_FILE(
    clk,
    RegWrite,
    rst,
    rs1,
    rs2,
    rd,
    Data_WB,
    A,
    B,
    read_data_valid
);

control_unit CONTROL_UNIT(
    instrCode,
    alu_ctrl
);

endmodule
