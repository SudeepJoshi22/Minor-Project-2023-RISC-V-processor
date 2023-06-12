module store_whb(
input [31:0]  data,
input [1:0] whb,
output wire [31:0] data_op
);

parameter byte  = 2'b00, half_word = 2'b01, word = 2'b10;


assign data_op = ( ( whb== word )? data : ( (whb == half_word )? ({{16'd0},data[15:0]}) : ( (whb == byte)? ( {{24'd0},data[7:0]} ) : 32'dz ) ) );

endmodule

