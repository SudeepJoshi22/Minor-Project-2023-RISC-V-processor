`timescale 1ns / 1ps
`default_nettype none

module instr_mem(
input wire [31:0] PC,
input wire rst,
output reg [31:0] instrCode
);
reg [7:0] Mem[2**20:0];

always @(*)
begin
    if(~rst)
    begin
<<<<<<< HEAD
        $readmemh("/home/ishita/Documents/minor_project/Minor-Project-2023-RISC-V-processor/RISC-V_Unpipelined_Processor/Instructions/dump.mem",Mem);
=======
        $readmemh("/home/sudeep/Documents/Project-GITHUB/Minor-Project-2023-RISC-V-processor/RISC-V_Unpipelined_Processor/Instructions/dump1.mem",Mem);
>>>>>>> 4e0830f4901d8bbec00a03eb2adbf3ff9098ca97
        instrCode <= 32'd0;
    end
    else
        instrCode <= {Mem[PC+3],Mem[PC+2],Mem[PC+1],Mem[PC]};
end

endmodule
