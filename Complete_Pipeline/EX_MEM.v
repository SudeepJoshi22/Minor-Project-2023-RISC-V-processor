module EX_MEM (
    input wire clk,
    input wire rst,
    input wire [2:0] func3_EX,
    input wire [4:0] rd_EX,
    input wire [6:0] opcode_EX,
    input wire [31:0] result,
    input wire [31:0] DataStore,
    input wire lt,
    input wire ltu,
    input wire [31:0] PC_EX,
    output reg [2:0] func3_EX_EX_MEM,
    output reg [4:0] rd_EX_EX_MEM,
    output reg [6:0] opcode_EX_EX_MEM,
    output reg [31:0] result_EX_MEM,
    output reg [31:0] DataStore_EX_MEM,
    output reg lt_EX_MEM,
    output reg ltu_EX_MEM,
    output reg [31:0] PC_EX_EX_MEM
);

always @(posedge clk)
begin
    if (!rst)
    begin
        func3_EX_EX_MEM <= 3'd0;
        rd_EX_EX_MEM <= 5'd0;
        opcode_EX_EX_MEM <= 7'd0;
        result_EX_MEM <= 32'd0;
        DataStore_EX_MEM <= 32'd0;
        lt_EX_MEM <= 1'd0;
        ltu_EX_MEM <= 1'd0;
        PC_EX_EX_MEM <= 32'd0;
    end
    else
    begin
        func3_EX_EX_MEM <= func3_EX;
        rd_EX_EX_MEM <= rd_EX;
        opcode_EX_EX_MEM <= opcode_EX;
        result_EX_MEM <= result;
        DataStore_EX_MEM <= DataStore;
        lt_EX_MEM <= lt;
        ltu_EX_MEM <= ltu;
        PC_EX_EX_MEM <= PC_EX;
    end
end

endmodule
