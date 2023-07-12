`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2023 21:13:04
// Design Name: 
// Module Name: PC_src_tb
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

module PC_src_tb;
reg branch,jump,zero,lt,ltu; 
reg [31:0] instr;
wire PC_src;

PC_src dut(branch,jump,zero,lt,ltu,instr,PC_src);

initial
begin
branch <= 1;
jump <= 0;
zero<= 0;
lt <= 0;
ltu <= 0;
#10
instr <= 32'h00628c63;
zero <= 0;
#10 
zero <= 1;
#10
instr <= 32'h00629a63;
zero <= 0;
#10 
zero <= 1;
#10
zero<=0;
instr <= 32'h0062c863;
lt <= 0;
#10 
lt <= 1;
#10
//zero <= 0;
instr <= 32'h00062d663;
lt <= 0;
#10 
lt <= 1;
#10
instr <= 32'h0052e863;
ltu <= 0;
#10 
ltu <= 1;
#10
instr <= 32'h0062f263;
ltu <= 0;
#10 
ltu <= 1;
#10
branch <= 0;
//jump <= 1;
//instr <= 32'h008002ef;
//#10
//instr <= 32'h100302e7;

end



endmodule
