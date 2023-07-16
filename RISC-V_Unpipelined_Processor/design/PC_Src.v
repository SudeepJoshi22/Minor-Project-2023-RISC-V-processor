`timescale 1ns / 1ps
`default_nettype none
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


module PC_src(
input wire boj,
input wire zero,
input wire lt,
input wire ltu,
input wire [31:0] instr,
output reg PC_src);

parameter BEQ=3'b000, BNE=3'b001,BLT=3'b100, BGE=3'b101, BLTU=3'b110, BGEU=3'b111;
parameter J=7'b1101111,JR=7'b1100111;

wire [2:0] func3;
wire [6:0] opcode;    

assign func3 = instr[14:12];
assign opcode = instr[6:0];

    always @(*)
    begin
      if(boj == 1)
        begin
        if(opcode == J || opcode == JR)
            PC_src <= 1;
        else begin
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
        default:PC_src<=1;
         endcase
         end
        end
      else 
           PC_src<=0;
       
     end





  
endmodule
