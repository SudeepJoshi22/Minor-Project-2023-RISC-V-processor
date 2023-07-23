`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2023 06:44:06
// Design Name: 
// Module Name: branch_pred_unit
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


module branch_pred_unit(
    input clk,rst,
    input [31:0]PC_IF,
    input [31:0]ADDR_EX,
    input [31:0]Pred_EX,
    input btb_enable,
    input state_change,
    input state_write,
    input branch, //to indicate whether branch was taken or not
    output hit,
    output [31:0]predicted_addr,
    output  taken
 );
    
    
    reg [3:0]global_history; //global history predictor
    
    parameter ST=2'b11,WT=2'b10,WNT=2'b01,SNT=2'b00;//ST=strongly taken  WT= weakly taken SNT=strongly not taken  WT= weakly not taken\
    
    reg [31:0] branchPC[31:0][3:0];
    reg [31:0] predictedPC[31:0][3:0];
    reg [1:0] predictionState[31:0][3:0];
    
    
    assign hit = (PC_IF == branchPC[PC_IF[31:0]][global_history]);
    assign predicted_addr= predictedPC[PC_IF[31:0]][global_history];
    assign taken= (predictionState[PC_IF[31:0]][global_history] < 2'b10) ? 1 : 0;
    
    
    
    nteger i, j;
    
    always@(posedge clk) 
    begin
        //reset 
     if(!rst) 
          begin
             for(j = 0; j < 4; j=j+1) 
            begin
                for(i = 0; i < 31; i = i+1) 
                  begin
                    branchPC[i][j] <= 1; //will never match because instructions are words
                    predictedPC[i][j] <= 1;
                    predictionState[i][j] <= SNT;
                  end
             end
             global_history = SNT; 
       
              end 
      else 
       
       begin
                //writing a new entry to BTB
                if(btb_enable)
                 begin
                    branchPC[ADDR_EX[31:0]][global_history] <=  ADDR_EX;
                    predictedPC[ADDR_EX[31:0]][global_history] <= Pred_EX;
                    predictionState[ADDR_EX[31:0]][global_history] <= WT;
                end
                //changing the state of an entry
             if(state_write) begin
                    if(state_change== 1) 
                    begin
                    //taken
                        if(predictionState[ADDR_EX[31:0]][global_history] != ST)
                            predictionState[ADDR_EX[31:0]][global_history] = predictionState[ADDR_EX[31:0]][global_history]  + 1;
                    end 
                 else 
                  begin
                    //not taken
                        if(predictionState[ADDR_EX[31:0]][global_history] != SNT)
                            predictionState[ADDR_EX[31:0]][global_history] = predictionState[ADDR_EX[31:0]][global_history]- 1;
                    end
                    
                    //after state change, update entry
                     case(predictionState[ADDR_EX[31:0]][global_history])
                        ST: predictedPC[ADDR_EX[31:0]][global_history] =Pred_EX;
                        
                        WT: predictedPC[ADDR_EX[31:0]][global_history] = Pred_EX;
                        
                        WNT: predictedPC[ADDR_EX[31:0]][global_history] =ADDR_EX + 4;
                        
                        SNT: predictedPCs[ADDR_EX[31:0]][global_history] =ADDR_EX + 4;
                    endcase
                end
       
       
       
       if(branch) 
           begin
                    if(state_change == 1) 
                            
                            begin
                            //taken
                                if(global_history != ST)
                                    global_history = global_history + 1;
                             end 
                      else 
                            begin
                            //not taken
                                if(global_history != SNT)
                                    global_history = global_history - 1;
                            end
           end
      end 
    end
     
    
endmodule


