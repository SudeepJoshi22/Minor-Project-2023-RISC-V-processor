

module signext(
input [31:0]  data,
input [1:0] whb,
output wire [31:0] data_op
);

parameter byte  = 2'b00, half_word = 2'b01, word = 2'b10;
 
/*
always @(*)
begin
	case(whb)
		byte:
			data_op <= {{24{data[7]}},data[7:0]};
		half_word:
			data_op <= {{16{data[15]}},data[15:0]};	
		word:
			data_op <= data;
		default:
			data_op <= 32'dx; 
			
    endcase
    
end
*/

assign data_op = ( ( whb== word )? data : ( (whb == half_word )? ({{16{data[15]}},data[15:0]}) : ( (whb == byte)? ( {{24{data[7]}},data[7:0]} ) : 32'dz ) ) );

endmodule
