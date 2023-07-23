`timescale 1ns / 1ps

module data_mem_tb;
reg clk;
reg rst;
reg rd;
reg wr;
reg cs_n;
reg [31:0] addr;
reg [31:0] write_data;
wire [31:0] read_data;

data_mem DUT(
clk,
rst,
rd,
wr,
cs_n,
addr,
write_data,
read_data
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    rd <= 1;
    cs_n <= 1;
    addr <= 0;
    write_data <= 0;
    #8
    rst <= 1;
    cs_n <= 0;
    #25
    rd <= 0;
    wr <= 1;
    addr <= 10;
    write_data <= 32'd20;
    #20
    rd <= 1;
    wr <= 0;
    addr <= 10;
 
end

endmodule
