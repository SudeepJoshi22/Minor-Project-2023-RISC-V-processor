module MEM_WB (
    input wire clk,
    input wire rst,
    input wire [4:0] rd_MEM,
    input wire [2:0] func3_MEM,
    input wire [6:0] opcode_MEM,
    input wire [31:0] Data_out_MEM,
    input wire lt_MEM,
    input wire ltu_MEM,
    input wire [31:0] result_MEM,
    input wire [31:0] PC_MEM,
    output reg [4:0] rd_MEM_MEM_WB,
    output reg [2:0] func3_MEM_MEM_WB,
    output reg [6:0] opcode_MEM_MEM_WB,
    output reg [31:0] Data_out_MEM_MEM_WB,
    output reg lt_MEM_MEM_WB,
    output reg ltu_MEM_MEM_WB,
    output reg [31:0] result_MEM_MEM_WB,
    output reg [31:0] PC_MEM_MEM_WB
);

always @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        rd_MEM_MEM_WB <= 5'd0;
        func3_MEM_MEM_WB <= 3'd0;
        opcode_MEM_MEM_WB <= 7'd0;
        Data_out_MEM_MEM_WB <= 32'd0;
        lt_MEM_MEM_WB <= 1'd0;
        ltu_MEM_MEM_WB <= 1'd0;
        result_MEM_MEM_WB <= 32'd0;
        PC_MEM_MEM_WB <= 32'd0;
    end
    else
    begin
        rd_MEM_MEM_WB <= rd_MEM;
        func3_MEM_MEM_WB <= func3_MEM;
        opcode_MEM_MEM_WB <= opcode_MEM;
        Data_out_MEM_MEM_WB <= Data_out_MEM;
        lt_MEM_MEM_WB <= lt_MEM;
        ltu_MEM_MEM_WB <= ltu_MEM;
        result_MEM_MEM_WB <= result_MEM;
        PC_MEM_MEM_WB <= PC_MEM;
    end
end

endmodule
