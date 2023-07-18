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
output reg [31:0 ] instrCode;

reg [7:0] Mem[2048:0];

always @(*)
begin
    if(~rst)
    begin
        $readmemh("/home/sudeep/Documents/Project-GITHUB/Minor-Project-2023-RISC-V-processor/RIS_Complete_Processor/Instructions/ris_complete_instructions.mem",Mem);
        instrCode <= 32'd0;
    end
    else
        instrCode <= {Mem[PC+3],Mem[PC+2],Mem[PC+1],Mem[PC]};

end
//assign instrCode = {Mem[PC],Mem[PC+1],Mem[PC+2],Mem[PC+3]};

endmodule
