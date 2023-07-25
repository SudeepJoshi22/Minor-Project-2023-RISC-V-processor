`timescale 1ns / 1ps
`default_nettype none

module instr_mem(
input wire clk,
input wire [31:0] iaddr,
input wire rst,
input wire cs_n,
output reg [31:0] instrCode
);

reg [7:0] Mem[2**20:0];

always @(*)
begin
    if(~rst)
    begin
        $readmemh("/home/sudeep/Documents/Project-GITHUB/Minor-Project-2023-RISC-V-processor/Final RISC-V Processor/Pipelined/instructions/hazard.mem",Mem);
        instrCode <= 32'dz;
    end
end

always @(*)
begin
    instrCode <= {Mem[iaddr+3],Mem[iaddr+2],Mem[iaddr+1],Mem[iaddr]};
end

endmodule
        