module MEM_WB (
    input wire clk,
    input wire rst,
    input wire [31:0] Data_out_MEM,
    input wire su_MEM,
    input wire [1:0] whb_MEM,
    input wire [1:0] wos_MEM,
    input wire lt_MEM,
    input wire ltu_MEM,
    input wire [6:0] opcode_MEM,
    input wire [31:0] result_MEM,
    input wire [31:0] PC_4_MEM,
    output reg [31:0] Data_out_MEM_MEM_WB,
    output reg su_MEM_MEM_WB,
    output reg [1:0] whb_MEM_MEM_WB,
    output reg [1:0] wos_MEM_MEM_WB,
    output reg lt_MEM_MEM_WB,
    output reg ltu_MEM_MEM_WB,
    output reg [6:0] opcode_MEM_MEM_WB,
    output reg [31:0] result_MEM_MEM_WB,
    output reg [31:0] PC_4_MEM_MEM_WB
);

always @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        Data_out_MEM_MEM_WB <= 32'd0;
        su_MEM_MEM_WB <= 1'd0;
        whb_MEM_MEM_WB <= 2'd0;
        wos_MEM_MEM_WB <= 2'd0;
        lt_MEM_MEM_WB <= 1'd0;
        ltu_MEM_MEM_WB <= 2'd0;
        opcode_MEM_MEM_WB <= 7'd0;
        result_MEM_MEM_WB <= 32'd0;
        PC_4_MEM_MEM_WB <= 32'd0;
    end
    else
    begin
        Data_out_MEM_MEM_WB <= Data_out_MEM;
        su_MEM_MEM_WB <= su_MEM;
        whb_MEM_MEM_WB <= whb_MEM;
        wos_MEM_MEM_WB <= wos_MEM;
        lt_MEM_MEM_WB <= lt_MEM;
        ltu_MEM_MEM_WB <= ltu_MEM;
        opcode_MEM_MEM_WB <= opcode_MEM;
        result_MEM_MEM_WB <= result_MEM;
        PC_4_MEM_MEM_WB <= PC_4_MEM;
    end
end

endmodule
