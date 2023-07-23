module IF_ID (
    input clk, rst,
    input [31:0] instrCode_ID_EX,
    output reg clk, rst,
    output reg [31:0] instrCode_ID_WB
);

always @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        instrCode_ID_WB <= 32'd0;
    end
    else
    begin
        instrCode_ID_WB <= instrCode_ID_EX;
    end
end

endmodule
