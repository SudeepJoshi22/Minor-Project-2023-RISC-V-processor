`timescale 1ns / 1ps

module signext(
input [31:0]  data,
input [1:0] whb,
input su, //1-signed, 0 - unsigned
output wire [31:0] data_op
);

parameter byte  = 2'b00, half_word = 2'b01, word = 2'b10;


//if su - 1, then sign extend, if su-1 then zero padding

assign data_op = su? ( ( whb== word )? data : ( (whb == half_word )? ({{16{data[15]}},data[15:0]}) : ( (whb == byte)? ( {{24{data[7]}},data[7:0]} ) : 32'dz ) ) ) : ( ( whb== word )? data : ( (whb == half_word )? ({{16{1'b0}},data[15:0]}) : ( (whb == byte)? ( {{24{1'b0}},data[7:0]} ) : 32'dz ) ) );

endmodule
