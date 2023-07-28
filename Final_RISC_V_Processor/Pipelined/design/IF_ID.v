module IF_ID (
    input wire clk,
    input wire rst,
    input wire [31:0] instrCode,
    input wire [31:0] PC_IF,
    output reg [31:0] instrCode_IF_ID,
    output reg [31:0] PC_IF_IF_ID
);

always @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        instrCode_IF_ID <= 32'd0;
        PC_IF_IF_ID <= 32'd0;
    end
    else
    begin
        instrCode_IF_ID <= instrCode;
        PC_IF_IF_ID <= PC_IF;
    end
end

endmodule
