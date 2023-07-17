`timescale 1ns / 1ps
`default_nettype none

module data_mem(
input wire clk,
input wire rst,
input wire rw,
input wire [31:0] addr,
input wire [31:0] write_data,
output wire [31:0] read_data
);

reg [7:0] memory[1023:0]; //byte adressable
integer i;

assign read_data = (rw)? {memory[addr+3], memory[addr+2], memory[addr+1], memory[addr]}:32'd0; 

always @(posedge clk, negedge rst)
begin
    if(~rst)
        begin
            for(i=0;i<1024;i=i+1) memory[i] <= 8'd0;
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

endmodule