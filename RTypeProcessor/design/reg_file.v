`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2023 23:37:00
// Design Name: 
// Module Name: reg_file
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


module reg_file(
input clk,RegWrite,rst,
input [4:0] ReadAddr1,ReadAddr2,WriteAddr,
input [31:0] WriteData,
output reg [31:0]  ReadData1,ReadData2
);

reg [31:0] reg_file[31:0];

always @(posedge clk, negedge rst)
begin
    if(!rst)
    begin
        reg_file[0] <=32'd1;
        reg_file[1] <=32'd2;
        reg_file[2] <=32'd3;
        reg_file[3] <=32'd4;
        reg_file[4] <=32'd5;
        reg_file[5] <=32'd6;
        reg_file[6] <=32'd7;
        reg_file[7] <=32'd8;
        reg_file[8] <=32'd9;
        reg_file[9] <=32'd10;
        reg_file[10] <=32'd11;
        reg_file[11] <=32'd12;
        reg_file[12] <=32'd13;
        reg_file[13] <=32'd14;
        reg_file[14] <=32'd15;
        reg_file[15] <=32'd16;
        reg_file[16] <=32'd17;
        reg_file[17] <=32'd18;
        reg_file[18] <=32'd19;
        reg_file[19] <=32'd20;
        reg_file[20] <=32'd21;
        reg_file[21] <=32'd22;
        reg_file[22] <=32'd23;
        reg_file[23] <=32'd24;
        reg_file[24] <=32'd25;
        reg_file[25] <=32'd26;
        reg_file[26] <=32'd27;
        reg_file[27] <=32'd28;
        reg_file[28] <=32'd29;
        reg_file[29] <=32'd30;
        reg_file[30] <=32'd31;
        reg_file[31] <=32'd32;
    end
    
    else if(RegWrite) reg_file[WriteAddr] <= WriteData;
    
    ReadData1 <= reg_file[ReadAddr1]; 
    ReadData2 <= reg_file[ReadAddr2];

end

endmodule
