`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2023 20:00:40
// Design Name: 
// Module Name: data_mem
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


module data_mem(
input clk,
input rst,
input rw,
input [31:0] addr,
input [31:0] write_data,
output wire [31:0] read_data
);

reg [7:0] memory[(2^32)-1:0]; //byte adressable
integer i;

always @(posedge clk, negedge rst)
begin
    if(~rst)
    begin
        for(i=0;i<(2^32);i=i+1) memory[i] <= i;
    end
    else
    begin
        if(~rw)
        begin
            memory[addr] <= write_data[7:0];
            memory[addr+1] <= write_data[15:8];
            memory[addr+2] <= write_data[23:16];
            memory[addr+3] <= write_data[31:24];
        end
    end
end

assign read_data = (rw)? {memory[addr+3], memory[addr+2], memory[addr+1], memory[addr]}:32'd0; 

endmodule