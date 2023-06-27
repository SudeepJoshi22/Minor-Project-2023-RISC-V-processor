`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2023 23:09:41
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(
input [31:0] instr,
output wire [31:0] immOut
);
reg [11:0] imm;
reg [20:0] imm_j_u; //20 bit immediate for both u type and j type

wire [6:0] opcode;
wire [2:0] func3;
//reg [31:0]immOut_t;

parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011 ,B=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

assign  func3 = instr[14:12];
assign opcode = instr[6:0];

always @(*)
begin
    case(opcode)
        I1:
        begin 
            if( func3 == 3'b001 || func3 == 3'b101)
                imm <= {{7{instr[24]}},instr[24:20]}; //for I-type shift instructions shift amount is encoded in the instructions only
            else
                imm <= instr[31:20];
           // immOut_t<= {{20{imm[11]}}, imm[11:0]};
        end
        I2:  begin 
              imm <= instr[31:20]; 
             // immOut_t<= {{20{imm[11]}}, imm[11:0]};
              end
        S: begin 
            imm <= {instr[31:25],instr[11:7]};
            //immOut_t<= {{20{imm[11]}}, imm[11:0]};
            end
        B: begin 
           imm<={instr[31],instr[7],instr[30:25],instr[11:8]};
           //immOut_t<= {{19{imm[12]}}, imm[12:0]};
           end
        J: begin 
           imm_j_u<={instr[31],instr[19:12],instr[20],instr[30:21]};
           //immOut_t<={{11{imm_j_u[20]}},imm_j_u[20:0]};
           end 
        JR:begin
           imm<={instr[31:20]};
           //immOut_t<= {{20{imm[11]}}, imm[11:0]};
           end   
        U:begin
           imm_j_u<={instr[31:12]};
           end   
        UPC:begin
            imm_j_u<={instr[31:12]};
            end   
        
        default: imm <= 12'd0;
    endcase
        
end
   //if(opcode==7'b1101111)
     //      assign immout<={{11{imm_j_u[20]}},imm_j_u[20:0]};
    //else if(opcode==7'b1100111)  
      //      assign immout<={{20{imm[11]}}, imm[11:0]};
      //else if(opcode==7'b0110111 ||opcode==7'b0010111)  
        //          assign immout<={imm_j_u,12'b0};
         assign immOut = (opcode== U ||opcode==UPC)? {imm_j_u,12'b0}:(opcode==J)? {{11{imm_j_u[20]}},imm_j_u[20:0]}:{{20{imm[11]}}, imm[11:0]};
//assign immOut = (opcode == J)? {{11{imm_j_u[20]}},imm_j_u[20:0]} : {{20{imm[11]}}, imm[11:0]}; 

endmodule