

module signext_tb();
reg [31:0]  data;
reg [1:0] whb;
reg su;
wire [31:0] data_op;

signext DUT(
data,
whb,
su,
data_op);

initial
begin
	data <= 32'h1234abcd;
	whb <= 2'b00;
	su <= 1'b1;
	#10
	whb <= 2'b01;
	#10
	whb <= 2'b10;
	#10 
	whb <= 2'b11;
	#10
	whb <= 2'bxx;
	#10
	whb <= 2'b00;
    su <= 1'b0;
    #10
    whb <= 2'b01;
    #10
    whb <= 2'b10;
    #10 
    whb <= 2'b11;
end

endmodule
