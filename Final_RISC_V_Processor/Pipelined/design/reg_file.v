`timescale 1ns / 1ps
`default_nettype none

module reg_file(
    input wire clk,
    input wire RegWrite,
    input wire rst,
    input wire [6:0] opcode,
    input wire [4:0] ReadAddr1, 
    input wire [4:0] ReadAddr2, 
    input wire [4:0] WriteAddr,
    input wire [31:0] WriteData,
    output wire [31:0] ReadData1,
    output wire [31:0] ReadData2,
    output reg read_data_valid
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011, BR = 7'b1100011, J = 7'b1101111, JR = 7'b1100111, U = 7'b0110111, UPC = 7'b0010111;

reg [31:0] reg_file[31:0];
reg [31:0] Read1,Read2;
reg clk2;
wire s_hazard;
integer i;

assign s_hazard = (~((opcode==BR)||(opcode==S)))&&( (WriteAddr==ReadAddr1)||(WriteAddr==ReadAddr2)) && (~(WriteAddr == 5'd0));

assign {ReadData1,ReadData2} = (read_data_valid)? {Read1,Read2} : 64'dz;

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

always @(posedge clk)
begin
    /*
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
    */
    if(~s_hazard)
    begin
        read_data_valid <= 1'b1;
        Read1 <= reg_file[ReadAddr1];
        Read2 <= reg_file[ReadAddr2];
        if(WriteAddr != 5'b00000)
            reg_file[WriteAddr] = WriteData;
    end
end

always @(clk2)
begin
    if(s_hazard)
    begin
        if(RegWrite && clk2)
        begin
            if(WriteAddr != 5'b00000) begin
                reg_file[WriteAddr] = WriteData;
                read_data_valid = 1'b0;
            end
        end
        else
        begin
            Read1 = reg_file[ReadAddr1];
            Read2 = reg_file[ReadAddr2];
            read_data_valid = 1'b1;
        end
    end
end

endmodule
