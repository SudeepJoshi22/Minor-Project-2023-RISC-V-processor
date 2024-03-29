// MIT License
// 
// Copyright (c) 2023 Sudeep et al.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

`timescale 1ns / 1ps
`default_nettype none

module reg_file(
input wire clk,
input wire RegWrite,
input wire rst,
input wire [4:0] ReadAddr1,ReadAddr2,WriteAddr,
input wire [31:0] WriteData,
output wire [31:0]  ReadData1,ReadData2
);

reg [31:0] reg_file[31:0];

integer i,fd;

always @(posedge clk, negedge rst)
begin
    if(!rst)
    begin
        reg_file[0] <=32'd0;
        reg_file[1] <=32'd0;
        reg_file[2] <=32'd0;
        reg_file[3] <=32'd0;
        reg_file[4] <=32'd0;
        reg_file[5] <=32'd0;
        reg_file[6] <=32'd0;
        reg_file[7] <=32'd0;
        reg_file[8] <=32'd0;
        reg_file[9] <=32'd0;
        reg_file[10] <=32'd0;
        reg_file[11] <=32'd0;
        reg_file[12] <=32'd0;
        reg_file[13] <=32'd0;
        reg_file[14] <=32'd0;
        reg_file[15] <=32'd0;
        reg_file[16] <=32'd0;
        reg_file[17] <=32'd0;
        reg_file[18] <=32'd0;
        reg_file[19] <=32'd0;
        reg_file[20] <=32'd0;
        reg_file[21] <=32'd0;
        reg_file[22] <=32'd0;
        reg_file[23] <=32'd0;
        reg_file[24] <=32'd0;
        reg_file[25] <=32'd0;
        reg_file[26] <=32'd0;
        reg_file[27] <=32'd0;
        reg_file[28] <=32'd0;
        reg_file[29] <=32'd0;
        reg_file[30] <=32'd0;
        reg_file[31] <=32'd0;
    end
    
    else if(RegWrite) begin
        if(WriteAddr != 5'b00000) begin //x0 register must be always 0
            	reg_file[WriteAddr] <= WriteData;
    		fd = $fopen("register_file.log","ab+");
    		$fdisplay(fd,"At time: %t\n",$time);
    		for(i=0;i<32;i=i+1) begin
    			$fdisplay(fd,"\tRegister %d: %h\n",i,reg_file[i]);
    		end
    		$fclose(fd); 
    	end
    end
end

assign ReadData1 = reg_file[ReadAddr1]; 
assign ReadData2 = reg_file[ReadAddr2];



endmodule
