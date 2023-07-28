`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2023 17:08:06
// Design Name: 
// Module Name: csr_test
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


module csr_test;
reg clock,reset_n;
reg [31:0]instruction;//irq_external_ack,irq_timer_ack,irq_software_ack,
wire [1:0]  program_counter_source;
wire [3:0 ] current_state,next_state;
wire take_trap;
wire [31:0] program_counter,next_program_counter,instruction_address,prev_instruction_address,next_address,mcause,trap_address;
wire [3:0 ] mcause_cause_code;
wire [31:0] csr_data_out;
wire ebreak,ecall;
reg irq_external,irq_timer,irq_software,clock_enable;

csr dut(clock,reset_n,
        instruction,
        irq_external,
        irq_timer,
        irq_software,
        clock_enable,
        csr_data_out,
        ebreak,
        ecall,
        mcause,
        mcause_cause_code,
        trap_address,
        program_counter,
        program_counter_source,
        next_program_counter,
        instruction_address,
        prev_instruction_address,
        next_address,
        take_trap,
        current_state,
        next_state
        );

//assign clock_enable=1;
initial
begin 
reset_n<=0;
clock <= 0;
clock_enable<=0;
clock<=1;
#1
reset_n<=1;
end
always #5 clock <= ~clock;

initial
begin
//reset_n<=0;
clock_enable<=1;
irq_external<=0;
irq_timer<=0;
irq_software<=0;
instruction<=32'b00000000000000000000000001110011;//ecall
#20
instruction<=32'b00110000001000000000000001110011;//mret
//instruction<=32'b00000000000100000000000001110011;//ebreak
//#6
//reset_n<=1;



#60 $finish;
end

endmodule
