module IF_ID (
    input wire clk;
    input wire rst;
    input wire [31:0] instrCode,
    input wire [31:0] PC,
    input wire [31:0] PC_4,
    output reg [31:0] instrCode_IF_ID,
    output reg [31:0] PC_IF_ID,
    output reg [31:0] PC_4_IF_ID
);

always @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        instrCode_IF_ID <= 32'd0;
        PC_IF_ID <= 32'd0;
        PC_4_IF_ID <= 32'd0;
    end
    else
    begin
        instrCode_IF_ID <= instrCode;
        PC_IF_ID <= PC;
        PC_4_IF_ID <= PC_4;
    end
end

endmodule
