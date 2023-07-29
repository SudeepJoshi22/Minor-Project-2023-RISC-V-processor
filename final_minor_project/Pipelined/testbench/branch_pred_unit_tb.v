`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2023 16:00:35
// Design Name: 
// Module Name: branch_pred_unit_tb
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


module branch_pred_unit_tb;
  reg clk,rst;
  reg [31:0]PC_IF;
  reg [31:0]ADDR_EX;
  reg [31:0]Pred_EX;
  //reg btb_enable;
  reg state_change;
  reg state_write;
  reg branch; //to indicate whether branch was taken or not
  wire hit;
  wire [31:0] predicted_addr;
  wire  taken;
   wire [3:0]ghp;
branch_pred_unit DUT(
   clk,rst,
   PC_IF,
   ADDR_EX,
   Pred_EX,
   //btb_enable,
   state_change,
   state_write,
   branch, //to indicate whether branch was taken or not
   hit,
   predicted_addr,
   taken,
   ghp
);  




initial clk <= 0;
always #10 clk <= ~clk;

initial
begin
   rst <= 0;
      //btb_enable<=0;

      state_change<=0;
      state_write<=0;
      branch<=0; 
    #5
    rst <= 1;
    //btb_enable<=0;
    PC_IF<= 32'hfe941ee3;
    ADDR_EX <= 32'hfe941ee3;
    Pred_EX<= 32'h0x00140413;
    state_change<=0;
    state_write<=0;
    branch<=1; 
    
    #10
       PC_IF<= 32'hfe941ee3;
       ADDR_EX <= 32'hfe941ee3;
       Pred_EX<= 32'h0x00140413;
       state_change<=0;
       state_write<=0;
       branch<=1; 
       
         
  #10
             PC_IF<= 32'hfe941ee3;
             ADDR_EX <= 32'hfe941ee3;
             Pred_EX<= 32'h0x00140413;
             state_change<=0;
             state_write<=1;
             branch<=1; 
             
             
        
   #10
       PC_IF<= 32'hfe941ee3;
       ADDR_EX <= 32'hfe941ee3;
       Pred_EX<= 32'h0x00140413;
       state_change<=1;
       state_write<=1;
        branch<=1; 
    
     
       
     #10
          PC_IF<= 32'h00090463;
           ADDR_EX <= 32'h00090463;
           Pred_EX<= 32'hfff90913;
           state_change<=0;
           state_write<=1;
            branch<=0; 
        
        #10
   
                    PC_IF<= 32'h00090463;
                     ADDR_EX <= 32'h00090463;
                     Pred_EX<= 32'hfff90913;
                     state_change<=1;
                     state_write<=1;
                      branch<=0; 
                      
                      
                      
                                      
            #10
                               
                                                PC_IF<= 32'h00090463;
                                                 ADDR_EX <= 32'h00090463;
                                                 Pred_EX<= 32'hfff90913;
                                                 state_change<=0;
                                                 state_write<=0;
                                                  branch<=1; 
                                                                   
                                       #10
                                                          
                                                                           PC_IF<= 32'h00090463;
                                                                            ADDR_EX <= 32'h00090463;
                                                                            Pred_EX<= 32'hfff90913;
                                                                            state_change<=0;
                                                                            state_write<=0;
                                                                             branch<=0;              
                                         
                                         
                     
      #10
                         
                                          PC_IF<= 32'h00090463;
                                           ADDR_EX <= 32'h00090463;
                                           Pred_EX<= 32'hfff90913;
                                           state_change<=1;
                                           state_write<=1;
                                            branch<=1;              
        
     
  
     #50
   $finish;
end


endmodule
