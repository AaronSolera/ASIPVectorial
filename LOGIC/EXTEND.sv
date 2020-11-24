module EXTEND (IN, OUT);

	input  [8:0]  IN;
	output [31:0] OUT;
	
	assign OUT = $signed({IN, 23'd0}) >>> 23;
 
endmodule 