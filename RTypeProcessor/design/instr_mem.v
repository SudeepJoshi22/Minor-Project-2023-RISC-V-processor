`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2023 12:16:11
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(PC,rst,instrCode);
input [31:0] PC;
input rst;
output [31:0 ] instrCode;

reg [7:0] Mem[(2^30):0];

always @(*)
begin
    if(!rst)
    begin
        $readmemh("/home/sudeep/Documents/Project-GITHUB/Minor-Project-2023-RISC-V-processor/RTypeProcessor/Instructions/r_type_test_instructios.mem",Mem);
        /*
        Mem[3]<=8'h01;
        Mem[2]<=8'h49;
        Mem[1]<=8'h83;
        Mem[0]<=8'h33;
        Mem[7]<=8'h00;
        Mem[6]<=8'h6e;
        Mem[5]<=8'h83;
        Mem[4]<=8'h93;
        Mem[11]<=8'h40;
        Mem[10]<=8'hc5;
        Mem[9]<=8'h85;
        Mem[8]<=8'h33;
        Mem[15]<=8'h00;
        Mem[14]<=8'hc9;
        Mem[13]<=8'h24;
        Mem[12]<=8'h83;
        */
    end
end
assign instrCode = {Mem[PC],Mem[PC+1],Mem[PC+2],Mem[PC+3]};

endmodule
