`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2023 18:05:00
// Design Name: 
// Module Name: PC_Src
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


module PC_src(input branch,
input jump,
input zero,
input lt,
input ltu,
input [31:0] instr,
output reg PC_src);

parameter BEQ=3'b000, BNE=3'b001,BLT=3'b100, BGE=3'b101, BLTU=3'b110, BGEU=3'b111;

wire [2:0] func3;
//wire [6:0] opcode;    

assign func3 = instr[14:12];

    always @(*)
    begin
      if(jump==1)
        PC_src <= 1;   //checking the jump condition
      else if(branch==1)
        begin
        case(func3)
        BEQ: begin
             if(zero==1)
             PC_src<=1;
             else
             PC_src<=0;
             end
        BNE:begin
            if(zero==0)
            PC_src<=1;
            else
            PC_src<=0;
            end
        BLT:begin
            if(lt==1)
            PC_src<=1;
            else
            PC_src<=0;
            end
        BGE:begin
            if(zero==1 || lt!=1)
            PC_src<=1;
            else
            PC_src<=0;
            end
        BLTU:begin
             if(ltu==1)
             PC_src<=1;
             else
             PC_src<=0;
             end
        BGEU:begin
             if(zero==1 || ltu!=1)
             PC_src<=1;
             else
             PC_src<=0;
             end
        default:PC_src<=0;
         endcase
        end
      else 
           PC_src<=0;
       
     end





  
endmodule
