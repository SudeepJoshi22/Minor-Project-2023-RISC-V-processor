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
wire [6:0] opcode;
parameter I = 7'b0010011, S = 7'b0000011;

assign opcode = instr[6:0];

always @(*)
begin
    case(opcode)
        I: imm <= instr[31:20];
        S: imm <= {instr[31:25],instr[11:7]};
        default: imm <= 12'd0;
    endcase
        
end

assign immOut = {{20{imm[11]}}, imm[11:0]};

endmodule
