`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2023 23:16:50
// Design Name: 
// Module Name: imm_gen_tb
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


module imm_gen_tb;
reg [31:0] instr;
wire [31:0] immOut;

imm_gen DUT(
instr,
immOut
);

initial
begin
instr <= 32'hf9c30293;
#10
instr <= 32'h06430293;
#10
instr <= 32'h0c832283;
#10
instr <= 32'hf3832283;
#10
instr <= 32'h02528063;
#10
instr <= 32'h008002ef;
#10
instr <= 32'h100302e7;
#10
instr <= 32'h800ff337;
#10
instr <= 32'h00230313;  
#10
instr <= 32'h00305397;   
end

endmodule
