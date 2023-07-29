`timescale 1ns / 1ps
`default_nettype none

module ID(
    input wire clk,
    input wire rst,
    input wire RegWrite, //RegWrite signal from the WB stage, required for register file
    input wire [4:0] rd_WB, //write address taken from the WB stage
    input wire [31:0] instrCode, //instr code from the IF stage
    input wire [31:0] Data_WB, //Data from the write back stage, to write into Register File
    input wire [31:0] PC, //PC from the IF stage
    output wire read_data_valid, //tells if the data read from the Register file is valid or not
    output wire [3:0] alu_ctrl, //alu_control to EX stage, tells the operation to ALU
    output wire [31:0] immOut, //Signextended immediate value to EX stage
    //Data forwards to next stage
    output wire [31:0] Read1, //Data read from register file rs1
    output wire [31:0] Read2, //Data read from register file rs2
    //pipeline forwards
    output wire [4:0] rd, //write address forward to next stage
    output wire [2:0] func3, //func3 forward
    output wire [6:0] opcode, //opcode forward
    output wire [31:0] PC_ID //PC forward to next stage
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011, BR = 7'b1100011, J = 7'b1101111, JR = 7'b1100111, U = 7'b0110111, UPC = 7'b0010111;

wire [31:0] A, B;
wire [4:0] rs1, rs2;

//decoding of the instr code
assign rs1 = instrCode[19:15];
assign rs2 = instrCode[24:20];
assign rd = instrCode[11:7];
assign opcode = instrCode[6:0];
assign func3 = instrCode[14:12];

assign PC_ID = PC;

assign Read1 = A;
assign Read2 = B;


reg_file REG_FILE(
    clk,
    RegWrite,
    rst,
    opcode,
    rs1,
    rs2,
    rd_WB,
    Data_WB,
    A,
    B,
    read_data_valid
);

control_unit CONTROL_UNIT(
    instrCode,
    alu_ctrl
);

imm_gen IMM_GEN(
instrCode,
immOut
);

endmodule
