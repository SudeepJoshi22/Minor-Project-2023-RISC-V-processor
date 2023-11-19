`timescale 1ns / 1ps
module alu_tb;

  // Constants
  localparam PERIOD = 10; // Simulation time period
  
  // Signals
  reg signed [31:0] A, B;
  reg [3:0] alu_ctrl;
  wire signed [31:0] result;
  wire zero, lt, ltu;
  
  // Instantiate the module under test
  alu alu_inst (
    .A(A),
    .B(B),
    .alu_ctrl(alu_ctrl),
    .result(result),
    .zero(zero),
    .lt(lt),
    .ltu(ltu)
  );
  
  // Test stimulus generation
  initial begin
    $dumpfile("waveform.vcd"); // Change the dumpfile name here
    $dumpvars(0, alu_tb);
    
    // Test case 1: Addition
    A = 10; B = 20; alu_ctrl = 4'b0000;
    #PERIOD;
    
    // Test case 2: Subtraction
    A = 30; B = 15; alu_ctrl = 4'b0001;
    #PERIOD;
    
    // Add more test cases here
    
    // End simulation
    $finish;
  end

endmodule

