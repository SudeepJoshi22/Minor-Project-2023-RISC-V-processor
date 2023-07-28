`timescale 1ns / 1ps
module csr#(
  
  parameter     [31:0]  BOOT_ADDRESS = 32'h00000000

  ) (
      input wire  clock,            // Clock input
      input wire reset_n,            // Reset input
      input  wire   [31:0]  instruction,
      //input wire [11:0] csr_in,  // Input data for CSR register
      //input wire csr_write,      // Write enable for CSR register
      //input wire [11:0] csr_addr, // Address of the CSR register being accessed
      //output reg [11:0] csr_out, // Output data from the CSR register
      input  wire           irq_external,
      //output wire           irq_external_ack,
      input  wire           irq_timer,
      //output wire           irq_timer_ack,
      input  wire           irq_software,  
      //output wire           irq_software_ack,*/
      //output wire           instruction_address_valid,
      /// Exceptions ///
          //input wire i_is_inst_illegal, //illegal instruction
          //input wire i_is_ecall, //ecall instruction
          //input wire i_is_ebreak, //ebreak instruction
          //input wire i_is_mret, //mret (return from trap) instruction
          /// Instruction/Load/Store Misaligned Exception///
          //input wire[`OPCODE_WIDTH-1:0] i_opcode, //opcode types
          //input wire[31:0] i_y, //y value from ALU (address used in load/store/jump/branch)
          /// CSR instruction ///
          //input wire[2:0] i_funct3, // CSR instruction operation
          //input wire[11:0] i_csr_index, // immediate value from decoder
          //input wire[31:0] i_imm, //unsigned immediate for immediate type of CSR instruction (new value to be stored to CSR)
         // input wire[31:0] i_rs1, //Source register 1 value (new value to be stored to CSR)
          //output reg[31:0] o_csr_out, //CSR value to be loaded to basereg
          // Trap-Handler 
          //input wire[31:0] i_pc, //Program Counter 
          //input wire writeback_change_pc, //high if writeback will issue change_pc (which will override this stage)
          //output reg[31:0] o_return_address, //mepc CSR
          input wire clock_enable,
          //input  wire  instruction_in_valid,
          output reg[31:0] csr_data_out,
          output wire ebreak,ecall,
          output reg   [31:0]  mcause,
          output reg   [3:0 ]  mcause_cause_code,
          output wire[31:0] trap_address,
          output reg[31:0]  program_counter,
          output reg[1:0 ]  program_counter_source,
          output reg   [31:0]  next_program_counter,
          output wire   [31:0]  instruction_address,
          output reg   [31:0]  prev_instruction_address,
          output wire [31:0]  next_address,
          output wire take_trap,
          output reg [3:0]current_state,
          output reg [3:0]next_state
          ///output wire[31:0] trap_address //mtvec CSR
          //output reg o_go_to_trap_q, //high before going to trap (if exception/interrupt detected)
          //output reg o_return_from_trap_q, //high before returning from trap (via mret)
          //input wire i_minstret_inc, //increment minstret after executing an instruction
          /// Pipeline Control ///
          //input wire i_ce, // input clk enable for pipeline stalling of this stage
          //input wire i_stall //informs this stage to stall
);
wire system_type;
wire csrxxx;
wire load_type;
wire store_type;
wire illegal_system;
wire interrupt_pending;
wire base_address_offset;
//wire           irq_external;
wire           irq_external_ack;
//wire           irq_timer;
wire           irq_timer_ack;
//wire           irq_software;
 wire           irq_software_ack;
//wire          clock_enable;
wire  [31:0]  csr_data_mask;
//reg   [31:0]  csr_data_out;
wire          csr_file_write_enable;
wire          csr_file_write_request;
//reg           csr_file_write_request_stage3;
wire  [2:0 ]  csr_operation;
//reg   [2:0 ]  csr_operation_stage3;
wire  [31:0]  csr_type_immediate;
reg   [31:0]  csr_write_data;  
//reg   [3:0 ]  current_state;
reg           prev_instruction_address_valid;
//wire          ebreak;
//wire          ecall;
wire  [31:0]  exception_program_counter;
wire          flush_pipeline;
reg   [31:0]  immediate_stage3;
wire  [2:0 ]  instruction_funct3;
wire  [6:0 ]  instruction_funct7;
wire  [6:0 ]  instruction_opcode;
wire  [11:0]  instruction_csr_address;
//reg   [11:0]  instruction_csr_address_stage3;  
wire  [4:0 ]  instruction_rd_address;
//reg   [4:0 ]  instruction_rd_address_stage3;  
wire  [4:0 ]  instruction_rs1_address;
wire  [4:0 ]  instruction_rs2_address;
//wire          illegal_instruction;
//reg   [31:0]  mcause;
//reg   [3:0 ]  mcause_cause_code;
reg           mcause_interrupt_flag;
reg   [31:0]  mepc;
wire  [31:0]  mie;  
reg           mie_meie;
reg           mie_msie;
reg           mie_mtie;  
wire  [31:0]  mip;
reg           mip_mtip;
reg           mip_meip;  
reg           mip_msip;
//reg           misaligned_address_exception;
//wire          misaligned_instruction_address;
//wire          misaligned_load;
//wire          misaligned_store;
wire          mret;
wire  [31:0]  mstatus;
reg           mstatus_mie;
reg           mstatus_mpie;
reg   [31:0]  mtvec;
reg   [31:0]  mtval;  
//reg  [31:0]  next_address;
//reg   [3:0 ]  next_state;
//reg   [31:0]  next_program_counter;
//reg   [31:0]  prev_instruction_address;
//reg   [31:0]  program_counter;
//reg   [1:0 ]  program_counter_source; 
reg   [31:0]  rs1_data_stage3;  
reg   [31:0]  rs2_data_stage3;
wire reset;
// Address of Machine Information CSRs

  localparam MARCHID              = 12'hF12;
  localparam MIMPID               = 12'hF13;

  // Address of Performance Counters CSRs

  localparam CYCLE                = 12'hC00;
  localparam TIME                 = 12'hC01;
  localparam INSTRET              = 12'hC02;
  localparam CYCLEH               = 12'hC80;
  localparam TIMEH                = 12'hC81;
  localparam INSTRETH             = 12'hC82;

  // Address of Machine Trap Setup CSRs

  localparam MSTATUS              = 12'h300;
  localparam MSTATUSH             = 12'h310;
  localparam MISA                 = 12'h301;
  localparam MIE                  = 12'h304;
  localparam MTVEC                = 12'h305;

  // Address of Machine Trap Handling CSRs

  //localparam MSCRATCH             = 12'h340;
  localparam MEPC                 = 12'h341;
  localparam MCAUSE               = 12'h342;
  //localparam MTVAL                = 12'h343;
  localparam MIP                  = 12'h344;

  /*// Address of Machine Performance Counters CSRs

  localparam MCYCLE               = 12'hB00;
  localparam MINSTRET             = 12'hB02;
  localparam MCYCLEH              = 12'hB80;
  localparam MINSTRETH            = 12'hB82;*/

// CSR File operation encoding

  localparam CSR_RWX              = 2'b01;
  localparam CSR_RSX              = 2'b10;
  localparam CSR_RCX              = 2'b11;

// Opcodes
  localparam OPCODE_SYSTEM        = 7'b1110011;
  localparam OPCODE_LOAD          = 7'b0000011;
  localparam OPCODE_STORE         = 7'b0100011;
  
 // Funct3
   localparam FUNCT3_CSRRW         = 3'b001;
   localparam FUNCT3_CSRRS         = 3'b010;
   localparam FUNCT3_CSRRC         = 3'b011;
   localparam FUNCT3_CSRRWI        = 3'b101;
   localparam FUNCT3_CSRRSI        = 3'b110;
   localparam FUNCT3_CSRRCI        = 3'b111;
   localparam FUNCT3_FENCE         = 3'b000;
   localparam FUNCT3_ECALL         = 3'b000;
   localparam FUNCT3_EBREAK        = 3'b000;
   localparam FUNCT3_MRET          = 3'b000;
   
 // Funct7
   localparam FUNCT7_ECALL         = 7'b0000000;
   localparam FUNCT7_EBREAK        = 7'b0000000;
   localparam FUNCT7_MRET          = 7'b0011000;
   
 // RS1, RS2 and RD encodings for SYSTEM instructions
   localparam RS1_ECALL            = 5'b00000;
   localparam RS1_EBREAK           = 5'b00000;
   localparam RS1_MRET             = 5'b00000;
   localparam RS2_ECALL            = 5'b00000;
   localparam RS2_EBREAK           = 5'b00001;
   localparam RS2_MRET             = 5'b00010;
   localparam RD_ECALL             = 5'b00000;
   localparam RD_EBREAK            = 5'b00000;
   localparam RD_MRET              = 5'b00000;

// Program Counter source selection

  localparam PC_BOOT              = 2'b00;
  localparam PC_EPC               = 2'b01;
  localparam PC_TRAP              = 2'b10;
  localparam PC_NEXT              = 2'b11;
  
  // States in M-mode
 
   localparam STATE_RESET          = 4'b0001; 
   localparam STATE_OPERATING      = 4'b0010;
   localparam STATE_TRAP_TAKEN     = 4'b0100;    
   localparam STATE_TRAP_RETURN    = 4'b1000;
   
assign reset = !reset_n;

assign instruction_opcode =
    instruction[6:0];
    
assign instruction_funct3 =
        instruction[14:12];
        
assign instruction_funct7 =
            instruction[31:25];
        
assign instruction_rs1_address =
instruction[19:15];
        
assign instruction_rs2_address =
instruction[24:20];
        
assign instruction_rd_address =
instruction[11:7];
        
assign instruction_csr_address =
instruction[31:20]; 

assign csr_operation = instruction_funct3;
   
assign system_type =
    instruction_opcode == OPCODE_SYSTEM;
  assign csrxxx =
        system_type &
        instruction_funct3 != 3'b000 &
        instruction_funct3 != 3'b100;
    
      assign ecall =
        system_type &
        instruction_funct3 == FUNCT3_ECALL &
        instruction_funct7 == FUNCT7_ECALL &
        instruction_rs1_address == RS1_ECALL &
        instruction_rs2_address == RS2_ECALL &
        instruction_rd_address  == RD_ECALL;
    
      assign ebreak =
        system_type &
        instruction_funct3 == FUNCT3_EBREAK &
        instruction_funct7 == FUNCT7_EBREAK &
        instruction_rs1_address == RS1_EBREAK &
        instruction_rs2_address == RS2_EBREAK &
        instruction_rd_address  == RD_EBREAK;
    
      assign mret =
        system_type &
        instruction_funct3 == FUNCT3_MRET &
        instruction_funct7 == FUNCT7_MRET &
        instruction_rs1_address == RS1_MRET &
        instruction_rs2_address == RS2_MRET &
        instruction_rd_address  == RD_MRET;
        
        assign csr_type_immediate = {
            27'b0,
            instruction[19:15]
          };
          
      // Instruction type detection
        assign load_type =
          instruction_opcode == OPCODE_LOAD;
      
        assign store_type =
          instruction_opcode == OPCODE_STORE;
      // Illegal instruction detection
    /*
      assign illegal_store = 
        store_type &
        (instruction_funct3[2] == 1'b1 ||
        instruction_funct3[1:0] == 2'b11);
    
      assign illegal_load =
        load_type &
        (instruction_funct3 == 3'b011 ||
         instruction_funct3 == 3'b110 ||
         instruction_funct3 == 3'b111);*/
      assign illegal_system =
         system_type &
         ~(csrxxx | ecall | ebreak | mret);
      // Control signals generation
      assign csr_file_write_request =
          csrxxx;
 //-----------------------------------------------------------------------------------------------//
 // Instruction fetch and instruction address logic                                               //
 //-----------------------------------------------------------------------------------------------//       
       
              
  assign instruction_address =
                    reset ?
              BOOT_ADDRESS :
              (clock_enable ?
                next_program_counter :
                prev_instruction_address); 
                
assign next_address =program_counter + 32'h00000004;                
//assign clock_enable = !(prev_instruction_address_valid & !instruction_in_valid );

/*assign instruction_address_valid =
    reset ?
    1'b0 :
    (clock_enable ?    
      ((program_counter_source == PC_NEXT) |
       (program_counter_source == PC_BOOT)) :
      prev_instruction_address_valid);*/
      
always @(posedge clock) begin
if (reset) begin
  prev_instruction_address <= BOOT_ADDRESS;
  //prev_instruction_address_valid <= 1'b0;
  
end
else if(clock_enable) begin
  prev_instruction_address <= instruction_address;
  //prev_instruction_address_valid <= instruction_address_valid;    
  
end
end 

                                
always @* begin : next_program_counter_mux
        case (program_counter_source)
                PC_BOOT: next_program_counter = BOOT_ADDRESS;
                PC_EPC:  next_program_counter = exception_program_counter;
                PC_TRAP: next_program_counter = trap_address;
                PC_NEXT: next_program_counter = next_address;
              endcase
            end
 always @(posedge clock) begin : program_counter_reg_implementation
               if (reset)
                 program_counter <= BOOT_ADDRESS;
               else if (clock_enable)
                 program_counter <= next_program_counter;
             end 
      //---------------------------------------------------------------------------------------------//
      // M-mode logic and hart control                                                               //
      //---------------------------------------------------------------------------------------------//    
      assign flush_pipeline =
              current_state != STATE_OPERATING;
          
            assign interrupt_pending =
              (mie_meie & mip_meip) |
              (mie_mtie & mip_mtip) |
              (mie_msie & mip_msip);
            
           /* assign exception_pending =
              illegal_instruction |
              misaligned_load |
              misaligned_store |
              misaligned_instruction_address;*/
          
            assign take_trap =
              (mstatus_mie & interrupt_pending) |
              /*exception_pending |*/ 
              ecall |
              ebreak;
              

          
            always @* begin : m_mode_fsm_next_state_logic
              case (current_state)
                STATE_RESET:
                  next_state = STATE_OPERATING;
                STATE_OPERATING: 
                  if(take_trap)
                    next_state = STATE_TRAP_TAKEN;
                  else if(mret)
                    next_state = STATE_TRAP_RETURN;
                  else
                    next_state = STATE_OPERATING;
                STATE_TRAP_TAKEN:
                  next_state = STATE_OPERATING;
                STATE_TRAP_RETURN:
                  next_state = STATE_OPERATING;
                default:
                  next_state = STATE_OPERATING;
              endcase
            end
            
            always @(posedge clock) begin : m_mode_fsm_current_state_register
              if(reset)
                current_state <= STATE_RESET;
              else if (clock_enable)
                current_state <= next_state;
            end
          
            always @* begin : program_counter_source_mux
              case (current_state)
                STATE_RESET:
                  program_counter_source = PC_BOOT;
                STATE_OPERATING:
                  program_counter_source = PC_NEXT;
                STATE_TRAP_TAKEN:
                  program_counter_source = PC_TRAP;
                STATE_TRAP_RETURN:
                  program_counter_source = PC_EPC;
                default:
                  program_counter_source = PC_NEXT;
              endcase
            end
          
            assign irq_external_ack =
              (current_state      == STATE_TRAP_TAKEN) &&
              (mcause_cause_code  == 4'b1011);
            
            assign irq_timer_ack =
              (current_state      == STATE_TRAP_TAKEN) &&
              (mcause_cause_code  == 4'b0111);
          
            assign irq_software_ack =
              (current_state      == STATE_TRAP_TAKEN) &&
              (mcause_cause_code  == 4'b0011);

     //---------------------------------------------------------------------------------------------//
    // Control and Status Registers implementation                                                 //
   //---------------------------------------------------------------------------------------------//

  assign csr_data_mask =
    csr_operation[2] == 1'b1 ?
    {27'b0, csr_type_immediate[4:0]} :
    rs1_data_stage3;

  always @* begin : csr_write_data_mux
    case (csr_operation[1:0])
      CSR_RWX:
        csr_write_data = csr_data_mask;
      CSR_RSX:
        csr_write_data = csr_data_out |  csr_data_mask;
      CSR_RCX:
        csr_write_data = csr_data_out & ~csr_data_mask;
      default:
        csr_write_data = csr_data_out;
    endcase
  end

  always @* begin : csr_data_out_mux
    case (instruction_csr_address)
      MARCHID:       csr_data_out = 32'h00000018; // RISC-V Steel microarchitecture ID
      MIMPID:        csr_data_out = 32'h00000005; // Version 5 
      
      MSTATUS:       csr_data_out = mstatus;
      MSTATUSH:      csr_data_out = 32'h00000000;
      MISA:          csr_data_out = 32'h40000100; // RV32I base ISA only
      MIE:           csr_data_out = mie;
      MTVEC:         csr_data_out = mtvec;
      
      MEPC:          csr_data_out = mepc;
      MCAUSE:        csr_data_out = mcause;
      //MTVAL:         csr_data_out = mtval;
      MIP:           csr_data_out = mip;
      
      default:       csr_data_out = 32'h00000000;
    endcase
  end

  assign csr_file_write_enable =
    csr_file_write_request & !flush_pipeline;
    
    //---------------------------------------------------------------------------------------------//
    // mstatus : M-mode Status register                                                            //
    //---------------------------------------------------------------------------------------------//
    assign mstatus = {
        19'b0000000000000000000,
        2'b11,          // M-mode Prior Privilege (always M-mode)
        3'b000,
        mstatus_mpie,   // M-mode Prior Global Interrupt Enable
        3'b000,
        mstatus_mie,    // M-mode Global Interrupt Enable
        3'b000
      };
      
      always @(posedge clock) begin : mstatus_csr_fields_update
        if(reset) begin
          mstatus_mie   <= 1'b0;
          mstatus_mpie  <= 1'b1;
        end
        else if (clock_enable) begin
          if(current_state == STATE_TRAP_RETURN) begin
            mstatus_mie   <= mstatus_mpie;
            mstatus_mpie  <= 1'b1;
          end
          else if(current_state == STATE_TRAP_TAKEN) begin
            mstatus_mpie  <= mstatus_mie;
            mstatus_mie   <= 1'b0;
          end
          else if(current_state == STATE_OPERATING && instruction_csr_address == MSTATUS && csr_file_write_enable) begin
            mstatus_mie   <= csr_write_data[3];
            mstatus_mpie  <= csr_write_data[7];
          end    
        end
      end
      
     //---------------------------------------------------------------------------------------------//
     // mie : M-mode Interrupt Enable register                                                      //
     //---------------------------------------------------------------------------------------------//
     assign mie = {
         20'b0,
         mie_meie,   // M-mode External Interrupt Enable
         3'b0,
         mie_mtie,   // M-mode Timer Interrupt Enable
         3'b0,
         mie_msie,   // M-mode Software Interrupt Enable
         3'b0
       };
     
       always @(posedge clock) begin : mie_csr_fields_implementation
         if(reset) begin
           mie_meie <= 1'b0;
           mie_mtie <= 1'b0;
           mie_msie <= 1'b0;
         end
         else if(clock_enable & instruction_csr_address == MIE && csr_file_write_enable) begin            
           mie_meie <= csr_write_data[11];
           mie_mtie <= csr_write_data[7];
           mie_msie <= csr_write_data[3];
         end
       end
       
         //---------------------------------------------------------------------------------------------//
         // mip : M-mode Interrupt Pending                                                              //
         //---------------------------------------------------------------------------------------------//
       
         assign mip = {
           20'b0,
           mip_meip,
           3'b0,
           mip_mtip,
           3'b0,
           mip_msip,
           3'b0
         };
       
         always @(posedge clock) begin : mip_csr_fields_implementation
           if(reset) begin
             mip_meip <= 1'b0;
             mip_mtip <= 1'b0;
             mip_msip <= 1'b0;
           end
           else if (clock_enable) begin
             mip_meip <= irq_external;
             mip_mtip <= irq_timer;
             mip_msip <= irq_software;
           end
         end
         
         //---------------------------------------------------------------------------------------------//
         // mepc : M-mode Exception Program Counter register                                            //
         //---------------------------------------------------------------------------------------------//
                     
                       assign exception_program_counter = mepc;
                     
                       always @(posedge clock) begin : mepc_implementation
                         if(reset)
                           mepc <= 32'b0;
                         else if (clock_enable) begin
                           if(current_state == STATE_TRAP_TAKEN)
                             mepc <= program_counter;
                           else if(current_state == STATE_OPERATING && instruction_csr_address == MEPC && csr_file_write_enable)
                             mepc <= {csr_write_data[31:2], 2'b00};
                         end    
                       end
        //---------------------------------------------------------------------------------------------//
        // mcause : M-mode Trap Cause register                                                         //
        //---------------------------------------------------------------------------------------------//
            always @(posedge clock) begin : mcause_implementation
            if(reset) 
              mcause <= 32'h00000000;
            else if (clock_enable) begin
              if(current_state == STATE_TRAP_TAKEN)
                mcause <= {mcause_interrupt_flag, 27'b0, mcause_cause_code};
              else if(current_state == STATE_OPERATING && instruction_csr_address == MCAUSE && csr_file_write_enable) 
                mcause <= csr_write_data;
            end
          end
          
         //---------------------------------------------------------------------------------------------//
         // mtvec : M-mode Trap Vector Address register                                                 //
         //---------------------------------------------------------------------------------------------//
                     
                      assign base_address_offset =
                        mcause_cause_code << 2;
                    /* Volume 2 pg. 30: When MODE=Direct (0), all traps into machine mode cause the i_pc to be set to the address in the  
                                         BASE field. When MODE=Vectored (1), all synchronous exceptions into machine mode cause the i_pc to be set to the address 
                                         in the BASE field, whereas interrupts cause the i_pc to be set to the address in the BASE field plus four times the
                                         interrupt cause number */
                      assign trap_address = 
                        mtvec[1:0] == 2'b01 && mcause_interrupt_flag ?
                        {mtvec[31:2], 2'b00} + base_address_offset :
                        {mtvec[31:2], 2'b00};
                    
                      always @(posedge clock) begin : mtvec_implementation
                        if(reset)
                          mtvec <= 32'b0;
                        else if(clock_enable & instruction_csr_address == MTVEC && csr_file_write_enable)
                          mtvec <= {csr_write_data[31:2], 1'b0, csr_write_data[0]};
                      end  
        
          always @(posedge clock) begin : trap_cause_implementation
            if(reset) begin
              mcause_cause_code       <= 4'b0;
              mcause_interrupt_flag   <= 1'b0;
            end
            if(clock_enable & current_state == STATE_OPERATING) begin 
              
              /*if(illegal_instruction) begin
                mcause_cause_code     <= 4'b0010;
                mcause_interrupt_flag <= 1'b0;
              end
              else if(misaligned_instruction_address) begin
                mcause_cause_code     <= 4'b0000;
                mcause_interrupt_flag <= 1'b0;
              end*/
              if(ecall) begin
                mcause_cause_code     <= 4'b1011;
                mcause_interrupt_flag <= 1'b0;
              end
              else if(ebreak) begin
                mcause_cause_code     <= 4'b0011;
                mcause_interrupt_flag <= 1'b0;
              end
              /*else if(misaligned_store) begin
                mcause_cause_code     <= 4'b0110;
                mcause_interrupt_flag <= 1'b0;
              end
              else if(misaligned_load) begin
                mcause_cause_code     <= 4'b0100;
                mcause_interrupt_flag <= 1'b0;
              end*/
              else if(mstatus_mie & mie_meie & mip_meip) begin
                mcause_cause_code     <= 4'b1011;
                mcause_interrupt_flag <= 1'b1;
              end
              else if(mstatus_mie & mie_mtie & mip_mtip) begin
                mcause_cause_code     <= 4'b0111;
                mcause_interrupt_flag <= 1'b1;
              end
              else if(mstatus_mie & mie_msie & mip_msip) begin
                mcause_cause_code     <= 4'b0011;
                mcause_interrupt_flag <= 1'b1;
              end
           end       
          
              
          
     end     
             
endmodule