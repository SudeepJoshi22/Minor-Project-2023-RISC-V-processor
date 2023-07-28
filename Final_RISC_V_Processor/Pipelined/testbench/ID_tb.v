`default_nettype none
`timescale 1ns / 1ps

module ID_tb;

// Inputs
reg clk;
reg rst;
reg RegWrite;
reg [4:0] rd_WB;
reg [31:0] instrCode;
reg [31:0] Data_WB;
reg [31:0] PC;

// Outputs
wire read_data_valid;
wire [3:0] alu_ctrl;
wire [31:0] immOut;
wire [31:0] Read1;
wire [31:0] Read2;
wire [4:0] rd;
wire [2:0] func3;
wire [6:0] opcode;
wire [31:0] PC_ID;

// Instantiate the module under test
ID dut (
    .clk(clk),
    .rst(rst),
    .RegWrite(RegWrite),
    .rd_WB(rd_WB),
    .instrCode(instrCode),
    .Data_WB(Data_WB),
    .PC(PC),
    .read_data_valid(read_data_valid),
    .alu_ctrl(alu_ctrl),
    .immOut(immOut),
    .Read1(Read1),
    .Read2(Read2),
    .rd(rd),
    .func3(func3),
    .opcode(opcode),
    .PC_ID(PC_ID)
);

// Clock generation
always #5 clk = ~clk; // Assuming 50% duty cycle for simplicity

// Initial block to apply inputs
initial begin
    clk = 0;
    rst = 0;
    RegWrite = 0;
    rd_WB = 0;
    instrCode = 32'h00000000;
    Data_WB = 32'h00000000;
    PC = 32'h00000000;

    // Wait for a few clock cycles to release reset
    #10 rst = 1;

    // Test Case 1: No RegWrite, R-type instruction
    #50 RegWrite = 0;
    #50 rd_WB = 0;
    #50 instrCode = 32'h00A302B3; // ADD x5, x6, x7
    #50 PC = 32'h10000000;
    #50 Data_WB = 32'h00000000;

    // Test Case 2: RegWrite, I-type instruction
    #50 RegWrite = 1;
    #50 rd_WB = 2;
    #50 instrCode = 32'h00100113; // ADDI x1, x0, 1
    #50 PC = 32'h20000000;
    #50 Data_WB = 32'h00F0F0F0;

    // Add more test cases if needed...

    // End simulation
    #100 $finish;
end

// Monitor outputs
always @(posedge clk) begin
    $display("Time = %0t: PC_ID = %h, Read1 = %h, Read2 = %h, immOut = %h, read_data_valid = %b, alu_ctrl = %b, opcode = %b, func3 = %b, rd = %h",
             $time, PC_ID, Read1, Read2, immOut, read_data_valid, alu_ctrl, opcode, func3, rd);
end

endmodule
