module ID_EX (
    input wire clk,
    input wire rst,
    input wire [31:0] Read1,
    input wire [31:0] Read2,
    input wire [31:0] immOut,
    input wire [6:0] opcode,
    input wire [2:0] func3,
    input wire  su,
    input wire [1:0] whb,
    input wire [1:0] wos,
    input wire [3:0] alu_ctrl,
    input wire [31:0] PC_ID,
    input wire [31:0] PC_4_ID,
    output reg [31:0] Read1_ID_EX,
    output reg [31:0] Read2_ID_EX,
    output reg [31:0] immOut_ID_EX,
    output reg [6:0] opcode_ID_EX,
    output reg [2:0] func3_ID_EX,
    output reg su_ID_EX,
    output reg [1:0] whb_ID_EX,
    output reg [1:0] wos_ID_EX,
    output reg [3:0] alu_ctrl_ID_EX,
    output reg [31:0] PC_ID_ID_EX,
    output reg [31:0] PC_4_ID_ID_EX
);

always @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        Read1_ID_EX <= 32'd0;
        Read2_ID_EX <= 32'd0;
        immOut_ID_EX <= 32'd0;
        opcode_ID_EX <= 7'd0;
        func3_ID_EX <= 3'd0;
        su_ID_EX <= 1'd0;
        whb_ID_EX <= 2'd0;
        wos_ID_EX <= 2'd0;
        alu_ctrl_ID_EX <= 4'd0;
        PC_ID_ID_EX <= 32'd0;
        PC_4_ID_ID_EX <= 32'd0;
    end
    else
    begin
        Read1_ID_EX <= Read1;
        Read2_ID_EX <= Read2;
        immOut_ID_EX <= immOut;
        opcode_ID_EX <= opcode;
        func3_ID_EX <= func3;
        su_ID_EX <= su;
        whb_ID_EX <= whb;
        wos_ID_EX <= wos;
        alu_ctrl_ID_EX <= alu_ctrl;
        PC_ID_ID_EX <= PC_ID;
        PC_4_ID_ID_EX <= PC_4_ID;
    end
end

endmodule
