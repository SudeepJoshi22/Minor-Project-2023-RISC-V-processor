`define N 32
`define INSTR_MEM_SIZE 4000

// Opcodes
`define I1 7'b0010011
`define I2 7'b0000011
`define S  7'b0100011
`define R  7'b0110011
`define BR 7'b1100011
`define J  7'b1101111
`define JR 7'b1100111
`define U  7'b0110111
`define UPC 7'b0010111

// ALU Control Signals
`define ADD 4'b0000
`define SUB 4'b0001
`define AND 4'b0010
`define OR  4'b0100
`define XOR 4'b1000
`define SRL 4'b1001
`define SLL 4'b1010
`define SRA 4'b1100
`define BUF 4'b1101

//func3 for Branch Instructions
`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101
`define BLTU 3'b110
`define BGEU 3'b111

