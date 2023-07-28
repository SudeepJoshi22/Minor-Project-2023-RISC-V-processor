`timescale 1ns / 1ps
`default_nettype none

module imm_gen(
input wire [31:0] instr,
output wire [31:0] immOut
);
parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011 ,B=7'b1100011,J=7'b1101111,JR=7'b1100111,U=7'b0110111,UPC=7'b0010111;

reg [11:0] imm;
reg [19:0] imm_j_u; //20 bit immediate for both u type and j type
wire [6:0] opcode;
wire [2:0] func3;

assign func3 = instr[14:12];
assign opcode = instr[6:0];
assign immOut = (opcode== U ||opcode==UPC)? {imm_j_u,12'd0}:(opcode==J)? {{12{imm_j_u[19]}},imm_j_u[19:0]}:{{20{imm[11]}}, imm[11:0]};

always @(*)
begin
    case(opcode)
        I1:
        begin 
            if( func3 == 3'b001 || func3 == 3'b101)
                imm <= {{7{instr[24]}},instr[24:20]}; //for I-type shift instructions shift amount is encoded in the instructions only
            else
                imm <= instr[31:20];
           
        end
        I2:  
            imm <= instr[31:20]; 
        S:
            imm <= {instr[31:25],instr[11:7]};
        B: 
            imm<={instr[31],instr[7],instr[30:25],instr[11:8]};
        J: 
            imm_j_u<={instr[31],instr[19:12],instr[20],instr[30:21]};
        JR:
            imm<={instr[31:20]};   
        U:
            imm_j_u<={instr[31:12]};   
        UPC:
            imm_j_u<={instr[31:12]};        
        default:
        begin 
            imm <= 12'd0;
            imm_j_u <= 20'd0;
        end
    endcase
        
end

endmodule