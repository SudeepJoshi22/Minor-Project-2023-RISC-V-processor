`timescale 1ns / 1ps


module instr_mem_tb;
reg [31:0] PC;
reg rst;
reg cs_n;
reg clk;
wire [31:0] instrCode;

instr_mem DUT(clk,PC,rst,cs_n,instrCode);

initial 
begin
	clk<= 0;
//	$dumpfile("waveform.vcd");
//	$dumpvars(0, instr_mem_tb);
	$monitor("Instruction = %h\n",instrCode);
end


always #10 clk <= ~clk;

always @(posedge clk) PC <= PC + 32'h4;
 
initial
begin
    rst <= 0;
    cs_n <= 1;
    PC <= 0;
    #10 
    rst = 1;
    cs_n <= 0;
    #200 $finish;
end

endmodule
