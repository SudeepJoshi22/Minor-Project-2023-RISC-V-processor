`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2023 21:13:04
// Design Name: 
// Module Name: PC_src_tb
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

module PC_src_tb;
reg branch,jump,zero,lt,ltu; 
reg [31:0] instr;
reg PC_src;
module PC_src dut(branch,jump,zero,lt,ltu,instr,PC_src);

initial
begin
zero<=1;lt<=0;ltu<=0;
instr
jump<=1;branch<=0;    //JAL

#10 jump<=0;branch<=1; //BEQ

//#10 //jump<=0;branch<=1; //BNE
//#10 //jump<=0;branch<=1; //BLT
//#10 //jump<=0;branch<=1; //BGE
//#10 //jump<=0;branch<=1; 

#10 jump<=0;branch<=1;
    instr=32'b4f56;
    B <=  32'hfffffffd;
    alu_ctrl <= 4'b0001;

end



endmodule
