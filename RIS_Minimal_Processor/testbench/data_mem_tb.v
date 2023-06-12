`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2023 20:11:06
// Design Name: 
// Module Name: data_mem_tb
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


module data_mem_tb;
reg clk;
reg rst;
reg rw;
reg [31:0] addr;
reg [31:0] write_data;
wire [31:0] read_data;

data_mem DUT(
clk,
rst,
rw,
addr,
write_data,
read_data
);

initial clk <= 0;

always #10 clk <= ~clk;

initial
begin
    rst <= 0;
    rw <= 0;
    addr <= 0;
    write_data <= 0;
    #25
    rw <= 0;
    rst <= 1;
    addr <= 10;
    write_data <= 32'd20;
    #10
    rw <= 1;
end

endmodule
