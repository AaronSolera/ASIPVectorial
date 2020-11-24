module EXTEND (IN, OUT);

	input  [12:0] IN;
	output [31:0] OUT;
	
	assign OUT = $signed({IN, 19'd0}) >>> 19;
 
endmodule 