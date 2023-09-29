module ID_EX (
    input wire clk,
    input wire rst,
    input wire read_data_valid,
    input wire [3:0] alu_ctrl,
    input wire [31:0] immOut,
    input wire [31:0] Read1,
    input wire [31:0] Read2,
    input wire [4:0] rd,
    input wire [2:0] func3,
    input wire [6:0] opcode,
    input wire [31:0] PC_ID,
    output reg read_data_valid_ID_EX,
    output reg [3:0] alu_ctrl_ID_EX,
    output reg [31:0] immOut_ID_EX,
    output reg [31:0] Read1_ID_EX,
    output reg [31:0] Read2_ID_EX,
    output reg [4:0] rd_ID_EX,
    output reg [2:0] func3_ID_EX,
    output reg [6:0] opcode_ID_EX,
    output reg [31:0] PC_ID_ID_EX
);

always @(posedge clk)
begin
    if (!rst)
    begin
        read_data_valid_ID_EX <= 1'd0;
        alu_ctrl_ID_EX <= 4'd0;
        immOut_ID_EX <= 32'd0;
        Read1_ID_EX <= 32'd0;
        Read2_ID_EX <= 32'd0;
        rd_ID_EX <= 5'd0;
        func3_ID_EX <= 3'd0;
        opcode_ID_EX <= 7'd0;
        PC_ID_ID_EX <= 32'd0;
    end
    else
    begin
        read_data_valid_ID_EX <= read_data_valid;
        alu_ctrl_ID_EX <= alu_ctrl;
        immOut_ID_EX <= immOut;
        Read1_ID_EX <= Read1;
        Read2_ID_EX <= Read2;
        rd_ID_EX <= rd;
        func3_ID_EX <= func3;
        opcode_ID_EX <= opcode;
        PC_ID_ID_EX <= PC_ID;
    end
end

endmodule
