`timescale 1ns / 1ps
`default_nettype none


module MEM_tb;

// Inputs
reg clk;
reg rst;
reg [2:0] func3;
reg [6:0] opcode;
reg [31:0] result;
reg [31:0] DataStore;
reg lt;
reg ltu;
reg [31:0] PC;
reg [31:0] Data_read;

// Outputs
wire cs_d_n;
wire rd;
wire wr;
wire [2:0] func3_MEM;
wire [6:0] opcode_MEM;
wire [31:0] d_addr;
wire [31:0] Data_write;
wire [31:0] Data_out_MEM;
wire lt_MEM;
wire ltu_MEM;
wire [31:0] result_MEM;
wire [31:0] PC_MEM;

// Instantiate the DUT
MEM dut (
    .clk(clk),
    .rst(rst),
    .func3(func3),
    .opcode(opcode),
    .result(result),
    .DataStore(DataStore),
    .lt(lt),
    .ltu(ltu),
    .Data_read(Data_read),
    .PC(PC),
    .cs_d_n(cs_d_n),
    .rd(rd),
    .wr(wr),
    .func3_MEM(func3_MEM),
    .opcode_MEM(opcode_MEM),
    .d_addr(d_addr),
    .Data_write(Data_write),
    .Data_out_MEM(Data_out_MEM),
    .lt_MEM(lt_MEM),
    .ltu_MEM(ltu_MEM),
    .result_MEM(result_MEM),
    .PC_MEM(PC_MEM)
);

// Clock generator
always #5 clk = ~clk;

// Initialize inputs
initial begin
    clk = 0;
    rst = 0;
    func3 = 0;
    opcode = 0;
    result = 0;
    DataStore = 0;
    lt = 0;
    ltu = 0;
    PC = 0;
    Data_read = 32'd1234;

    #10 rst = 1; // Deassert reset after 10 time units
end

// Monitor outputs
always @(posedge clk) begin
    $display("cs_d_n=%b, rd=%b, wr=%b, func3_MEM=%b, opcode_MEM=%b, d_addr=%h, Data_write=%h, Data_out_MEM=%h, lt_MEM=%b, ltu_MEM=%b, result_MEM=%h, PC_MEM=%h",
             cs_d_n, rd, wr, func3_MEM, opcode_MEM, d_addr, Data_write, Data_out_MEM, lt_MEM, ltu_MEM, result_MEM, PC_MEM);
end

// Stimulus
initial begin
    #20;
    func3 = 3'b001; // Example value for func3
    opcode = 7'b1100011; // Example value for opcode
    result = 32'hAABBCCDD; // Example value for result
    DataStore = 32'h11223344; // Example value for DataStore
    lt = 1; // Example value for lt
    ltu = 0; // Example value for ltu
    PC = 32'h80000000; // Example value for PC
    #20
    opcode = 7'b0000011;
    #20
    opcode = 7'b0100011;
    #100 $finish;
end

endmodule
