`timescale 1ns / 1ps
`default_nettype none

module WB_tb;

// Inputs
reg clk;
reg rst;
reg [4:0] rd;
reg [2:0] func3;
reg [6:0] opcode;
reg [31:0] Data_out;
reg lt;
reg ltu;
reg [31:0] result;
reg [31:0] PC;

// Outputs
wire [4:0] rd_WB;
wire RegWrite;
wire [31:0] DataOut_WB;

// Instantiate the DUT
WB dut(
    .clk(clk),
    .rst(rst),
    .rd(rd),
    .func3(func3),
    .opcode(opcode),
    .read_data(Data_out),
    .lt(lt),
    .ltu(ltu),
    .result(result),
    .PC(PC),
    .rd_WB(rd_WB),
    .RegWrite(RegWrite),
    .DataOut_WB(DataOut_WB)
);

// Clock generation
always #5 clk = ~clk;

// Testbench code here
initial begin
    clk = 0;
    rst = 1;
    #10 rst = 0;
    #10 rst = 0;

    // Initialize inputs
    rd = 5'd0;
    func3 = 3'b000;
    opcode = 7'b0000000;
    Data_out = 32'hdeadbeef;
    lt = 1'b0;
    ltu = 1'b0;
    result = 32'habcdef01;
    PC = 32'h10000000;

    // Wait for a few clock cycles
    #20;

    // Test case for I1 opcode (ADDI)
    rd = 1'b1;
    func3 = 3'b000; // ADDI
    opcode = 7'b0010011;
    Data_out = 32'hbadc0de;
    lt = 1'b1;
    ltu = 1'b0;
    result = 32'h98765432;
    PC = 32'h20000000;
    #20;

    // Test case for I2 opcode (LW)
    rd = 1'b1;
    func3 = 3'b010; // LW
    opcode = 7'b0000011;
    Data_out = 32'hbadc0de;
    lt = 1'b0;
    ltu = 1'b0;
    result = 32'h98765432;
    PC = 32'h30000000;
    #20;

    // Test case for S opcode (SW)
    rd = 1'b1;
    func3 = 3'b010; // SW
    opcode = 7'b0100011;
    Data_out = 32'hbadc0de;
    lt = 1'b0;
    ltu = 1'b1;
    result = 32'h98765432;
    PC = 32'h40000000;
    #20;

    // Test case for R opcode (ADD)
    rd = 1'b1;
    func3 = 3'b000; // ADD
    opcode = 7'b0110011;
    Data_out = 32'hbadc0de;
    lt = 1'b1;
    ltu = 1'b1;
    result = 32'h98765432;
    PC = 32'h50000000;
    #20;

    // Test case for BR opcode (BEQ)
    rd = 1'b1;
    func3 = 3'b000; // BEQ
    opcode = 7'b1100011;
    Data_out = 32'hbadc0de;
    lt = 1'b0;
    ltu = 1'b0;
    result = 32'h98765432;
    PC = 32'h60000000;
    #20;

    // Test case for J opcode (JAL)
    rd = 1'b1;
    func3 = 3'b000; // JAL
    opcode = 7'b1101111;
    Data_out = 32'hbadc0de;
    lt = 1'b1;
    ltu = 1'b0;
    result = 32'h98765432;
    PC = 32'h70000000;
    #20;

    // Test case for JR opcode (JALR)
    rd = 1'b1;
    func3 = 3'b000; // JALR
    opcode = 7'b1100111;
    Data_out = 32'hbadc0de;
    lt = 1'b0;
    ltu = 1'b1;
    result = 32'h98765432;
    PC = 32'h80000000;
    #20;

    // Test case for U opcode (LUI)
    rd = 1'b1;
    func3 = 3'b000; // LUI
    opcode = 7'b0110111;
    Data_out = 32'hbadc0de;
    lt = 1'b1;
    ltu = 1'b1;
    result = 32'h98765432;
    PC = 32'h90000000;
    #20;

    // Test case for UPC opcode (AUIPC)
    rd = 1'b1;
    func3 = 3'b000; // AUIPC
    opcode = 7'b0010111;
    Data_out = 32'hbadc0de;
    lt = 1'b0;
    ltu = 1'b0;
    result = 32'h98765432;
    PC = 32'hA0000000;
    #20;

    // End simulation
    #10 $finish;
end

endmodule
