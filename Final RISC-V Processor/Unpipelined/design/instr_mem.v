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
reg [31:0] raddr;

always @(posedge clk)
begin
    if(~cs_n)
        raddr <= iaddr;
end

always @(*)
begin
    if(~rst)
    begin
        $readmemh("/home/sudeep/Documents/Project-GITHUB/Minor-Project-2023-RISC-V-processor/RISC-V_Unpipelined_Processor/Instructions/dump2.mem",Mem);
        instrCode <= 32'dz;
    end
end

always @(raddr)
begin
    instrCode <= {Mem[raddr+3],Mem[raddr+2],Mem[raddr+1],Mem[raddr]};
end

endmodule
        