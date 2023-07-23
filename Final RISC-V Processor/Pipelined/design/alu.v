`timescale 1ns / 1ps
`default_nettype none

module alu(
<<<<<<< HEAD
input signed [31:0] A,
input signed [31:0] B,
input [3:0] alu_ctrl,

output reg  signed [31:0] result,


output zero,
output lt,
output ltu
=======
input wire signed [31:0] A,
input wire signed [31:0] B,
input wire [3:0] alu_ctrl,
output reg signed [31:0] result,
output wire zero,
output wire lt,
output wire ltu
>>>>>>> 4e0830f4901d8bbec00a03eb2adbf3ff9098ca97
);
parameter ADD = 4'b0000,SUB = 4'b0001,AND = 4'b0010,OR = 4'b0100,XOR = 4'b1000,SRL = 4'b1001,SLL = 4'b1010, SRA = 4'b1100, BUF = 4'b1101;

reg signed [32:0] AU,BU,resultu;

assign zero = (result == 0)? 1 : 0;
assign lt = (result < 0 )? 1 : 0;
assign ltu = (resultu < 0 )? 1 : 0;

always @(*) //FOR UNSIGNED TYPE INSTRUCTIONS
begin
    AU <= {1'b0, A};
    BU <= {1'b0, B};
end

always @(*)
begin
    case(alu_ctrl)        
        ADD:
            result <= A + B;
        SUB:
        begin
            result <= A - B;
            resultu <= AU - BU;
        end
        AND:
            result <= A & B;
        OR:
            result <= A | B;
        XOR:
            result <= A ^ B;
        SRL:
            result <= A >> B[4:0]; //Shift is only define by the lower order 5-bits of B
        SLL:
            result <= A << B[4:0]; //Same here
        SRA:
            result <= A >>> B[4:0];
        BUF:
            result <= B;  
        default:
            result <= 32'bz;
    endcase
end

endmodule
