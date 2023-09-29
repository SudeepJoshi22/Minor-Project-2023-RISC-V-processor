`timescale 1ns / 1ps
`default_nettype none

module IF(
input wire clk, 
input wire rst,
input wire PC_src, //from EX stage for PC change in branch and jump instructions
input wire jalr, //from EX stage only for jalr instruction
input wire [31:0]result_EX, //result from the EX for jalr instructions
input wire [31:0]immOut_EX, //immediate value from the EX stage, which tells the offset in Branch and Jumps
input wire [31:0] instr_read, //instruction read from the Instruction Memory
output reg cs_i_n, //chip select signal for instruction memory
output wire [31:0] i_addr, //address for instr memory
output wire [31:0] instrCode, //instruction code to ID stage
//PC forwards
output wire [31:0] PC_IF //PC forward to ID stage
);
wire [31:0] PC_imm,PC_next;
reg [31:0] PC,addr;
wire [31:0] PC_4;

assign PC_IF = PC;
assign instrCode = instr_read;
assign i_addr = cs_i_n? PC : 32'dz;

//assign cs_i_n = rst? 1'b0 : 'b1;

assign PC_imm = PC + (immOut_EX<<1);
assign PC_4 = PC + 32'd4;
assign PC_next= cs_i_n? (PC_src? ( jalr ? (result_EX & ~1) : PC_imm): PC_4) : PC;

always @(posedge clk)
begin
    if(!rst) begin
        PC <= 32'd0;
        cs_i_n <= 0;
    end
    else begin
        PC <= PC_next;
        cs_i_n <= 1;
    end
end       

endmodule
