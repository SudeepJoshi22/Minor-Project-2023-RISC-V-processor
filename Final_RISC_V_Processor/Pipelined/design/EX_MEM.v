module EX_MEM (
    input wire clk,
    input wire rst,
    input wire [31:0] result,
    input wire [31:0] Data_store,
    input wire lt,
    input wire ltu,
    input wire su_EX,
    input wire [1:0] whb_EX,
    input wire [1:0] wos_EX,
    input wire [6:0] opcode_EX,
    input wire [31:0] immOut_EX,
    input wire [31:0] PC_4_EX,
    output reg [31:0] result_EX_MEM,
    output reg [31:0] Data_store_EX_MEM,
    output reg lt_EX_MEM,
    output reg ltu_EX_MEM,
    output reg su_EX_EX_MEM,
    output reg [1:0] whb_EX_EX_MEM,
    output reg [1:0] wos_EX_EX_MEM,
    output reg [6:0] opcode_EX_EX_MEM,
    output reg [31:0] immOut_EX_EX_MEM,
    output reg [31:0] PC_4_EX_EX_MEM
);

always @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        result_EX_MEM <= 32'd0;
        Data_store_EX_MEM <= 32'd0;
        lt_EX_MEM <= 1'd0;
        ltu_EX_MEM <= 1'd0;
        su_EX_EX_MEM <= 1'd0;
        whb_EX_EX_MEM <= 2'd0;
        wos_EX_EX_MEM <= 2'd0;
        opcode_EX_EX_MEM <= 7'd0;
        immOut_EX_EX_MEM <= 32'd0;
        PC_4_EX_EX_MEM <= 32'd0;
    end
    else
    begin
        result_EX_MEM <= result;
        Data_store_EX_MEM <= Data_store;
        lt_EX_MEM <= lt;
        ltu_EX_MEM <= ltu;
        su_EX_EX_MEM <= su_EX;
        whb_EX_EX_MEM <= whb_EX;
        wos_EX_EX_MEM <= wos_EX;
        opcode_EX_EX_MEM <= opcode_EX;
        immOut_EX_EX_MEM <= immOut_EX;
        PC_4_EX_EX_MEM <= PC_4_EX;
    end
end

endmodule
