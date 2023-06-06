

module signext_tb();
reg [31:0]  data;
reg [1:0] whb;
wire [31:0] data_op;

signext DUT(
data,
whb,
data_op);

initial
begin
	data <= 32'h1234abcd;
	whb <= 2'b00;
	#10
	whb <= 2'b01;
	#10
	whb <= 2'b10;
	#10 
	whb <= 2'b11;
	#10
	whb <= 2'bxx;
end

endmodule
