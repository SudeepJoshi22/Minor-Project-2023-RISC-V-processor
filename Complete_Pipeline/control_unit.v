`timescale 1ns / 1ps
`default_nettype none

module control_unit(
    input wire [31:0] instr,
    output reg [3:0] alu_ctrl
);

parameter I1 = 7'b0010011, I2 = 7'b0000011, S = 7'b0100011, R = 7'b0110011, B = 7'b1100011, J = 7'b1101111, JR = 7'b1100111, U = 7'b0110111, UPC = 7'b0010111;

wire [2:0] func3;
wire [6:0] func7;
wire [6:0] opcode;

assign func3 = instr[14:12];
assign func7 = instr[31:25];
assign opcode = instr[6:0];

always @(*)
begin
    case(opcode)
        R:   
            if(func3 == 3'b000 && func7 == 7'b0000000) 
                alu_ctrl <= 4'b0000; // ADD 
            else if(func3 == 3'b000 && func7 == 7'b0100000)
                alu_ctrl <= 4'b0001; // SUB 
            else if(func3 == 3'b001 && func7 == 7'b0000000)
                alu_ctrl <= 4'b1010; // SLL 
            else if(func3 == 3'b101 && func7 == 7'b0000000)
                alu_ctrl <= 4'b1001; // SRL 
            else if(func3 == 3'b100 && func7 == 7'b0000000)
                alu_ctrl <= 4'b1000; // XOR 
            else if(func3 == 3'b111 && func7 == 7'b0000000)
                alu_ctrl <= 4'b0010; // AND 
            else if(func3 == 3'b110 && func7 == 7'b0000000)
                alu_ctrl <= 4'b0100; // OR 
            else if(func3 == 3'b101 && func7 == 7'b0100000)
                alu_ctrl <= 4'b1100; // SRA  
            else if(func3 == 3'b010 && func7 == 7'b0000000)
                alu_ctrl <= 4'b0001; // SLT  
            else if(func3 == 3'b011 && func7 == 7'b0000000)
                alu_ctrl <= 4'b0001; // SLTU  
            else 
                alu_ctrl <= 4'bx;
        
        I1:
            if(func3 == 3'b000) 
                alu_ctrl <= 4'b0000; // ADDI 
            else if(func3 == 3'b001 && func7 == 7'b0000000)
                alu_ctrl <= 4'b1010; // SLLI 
            else if(func3 == 3'b101 && func7 == 7'b0000000)
                alu_ctrl <= 4'b1001; // SRLI 
            else if(func3 == 3'b100)
                alu_ctrl <= 4'b1000; // XORI 
            else if(func3 == 3'b111)
                alu_ctrl <= 4'b0010; // ANDI 
            else if(func3 == 3'b110)
                alu_ctrl <= 4'b0100; // ORI 
            else if(func3 == 3'b010)
                alu_ctrl <= 4'b0001; // SLTI 
            else if(func3 == 3'b011)
                alu_ctrl <= 4'b0001; // SLTIU 
            else if(func3 == 3'b101 && func7 == 7'b0100000)
                alu_ctrl <= 4'b1100; // SRAI 
            else
                alu_ctrl <= 4'bx;
        
        I2:
            alu_ctrl <= 4'b0000; // LW LH LB LBU LHU
        
        S:
            alu_ctrl <= 4'b0000; // SW SH SB
        
        B:
            alu_ctrl <= 4'b0001; // BEQ, BNE, BLT, BGE, BLTU, BGEU
        
        JR:
            alu_ctrl <= 4'b0000; // JALR
        
        J:
            alu_ctrl <= 4'b0000; // JAL 
        
        U:
            alu_ctrl <= 4'b1101; // LUI 
        
        UPC:
            alu_ctrl <= 4'b0000; // AUIPC 
        
        default:
            alu_ctrl <= 4'dz;
    endcase
end

endmodule
