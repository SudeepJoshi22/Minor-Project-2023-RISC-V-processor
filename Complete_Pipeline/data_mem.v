`timescale 1ns / 1ps
`default_nettype none

module data_mem(
input wire clk,
input wire rst,
input wire rd,
input wire wr,
input wire cs_n,
input wire [31:0] addr,
input wire [31:0] write_data,
output wire [31:0] read_data
);

reg [7:0] memory[2**20:0]; //byte adressable
integer i,fd;

assign read_data = (rd && ~cs_n)? {memory[addr+3], memory[addr+2], memory[addr+1], memory[addr]}:32'dz; 

always @(posedge clk, negedge rst)
begin
    if(~rst)
        begin
		for(i=0;i<2**20;i=i+1) memory[i] <= 8'd0;
        end	
    else
        begin
            if(wr && ~cs_n)
                begin
			fd = $fopen("data_memory.log","ab+");
			memory[addr] <= write_data[7:0];
			memory[addr+1] <= write_data[15:8];
			memory[addr+2] <= write_data[23:16];
			memory[addr+3] <= write_data[31:24];
			$fdisplay(fd, "Data 0x%h Written at address 0x%h", write_data, addr);
$fclose(fd);
                end
            else if( rd && ~cs_n)
            	begin
            		fd = $fopen("data_memory.log","ab+");	
            		$fdisplay(fd, "Data 0x%h Read from address 0x%h", read_data, addr);
    			$fclose(fd);
    		end
        end
end

endmodule
