`timescale 1ns / 1ps
`default_nettype none

module processor_ris_type_tb;
reg clk,rst;
wire [31:0] result;
wire [31:0] WriteData_ext_set;
wire zero;
wire lt;
wire ltu;
wire [31:0] PC;

processor_unpipelined DUT(
clk,
rst,
result,
WriteData_ext_set,
zero,
lt,
ltu,
PC
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    #7
    rst <= 1;

end

endmodule
