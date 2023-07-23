`timescale 1ns / 1ps

module alu_tb;
reg signed [31:0] A;
reg signed [31:0] B;
reg [3:0] alu_ctrl;
wire [31:0] result;
wire zero;
wire lt;
wire ltu;

alu DUT(
A,
B,
alu_ctrl,
result,
zero,
lt,
ltu
);

initial
begin
    A <= 32'h00000005;
    B <=  32'hfffffffd;
    alu_ctrl <= 4'b0001;

end



endmodule
