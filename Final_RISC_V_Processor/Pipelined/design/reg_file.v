`timescale 1ns / 1ps
`default_nettype none

module reg_file(
    input wire clk,
    input wire RegWrite,
    input wire rst,
    input wire [4:0] ReadAddr1, 
    input wire [4:0] ReadAddr2, 
    input wire [4:0] WriteAddr,
    input wire [31:0] WriteData,
    output wire [31:0] ReadData1,
    output wire [31:0] ReadData2,
    output wire read_data_valid
);

reg [31:0] reg_file[31:0];
reg [31:0] Read1,Read2;
reg read_data1_valid;
reg read_data2_valid;
reg clk2;
integer i;

//Clock-Dividing the Reset Logic
always @(posedge clk, negedge rst)
begin
    if(!rst)
    begin
        clk2 <= 1'b0;
        for (i = 0; i < 32; i = i + 1) begin
                    reg_file[i] <= 32'd0;
        end
    end
    else
        clk2 <= ~clk2;
end

always @(*)
begin
    //At the positive edge of the clk2, if RegWrite is active then do the write operation
    if(RegWrite && clk2)
    begin
        if(WriteAddr != 5'b00000) begin
            reg_file[WriteAddr] = WriteData;
            read_data1_valid = 1'b0;
            read_data2_valid = 1'b0; 
        end
    end
    else
    begin
        Read1 = reg_file[ReadAddr1];
        read_data1_valid = 1'b1;
        Read2 = reg_file[ReadAddr2];
        read_data2_valid = 1'b1;
    end
end

assign {ReadData1,ReadData2} = (read_data1_valid && read_data2_valid)? {Read1,Read2} : 64'dz;
assign read_data_valid = (read_data1_valid && read_data2_valid); 


endmodule
