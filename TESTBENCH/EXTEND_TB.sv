module EXTEND_TB;

	logic [12:0] IN;
	logic [31:0] OUT;
	
	EXTEND 
		EX (IN, OUT);
		
	initial begin
	
		IN = 13'd224; #10
		
		assert (OUT === 32'd224) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		IN = -13'd224; #10
		
		assert (OUT === -32'd224) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
	
	end

endmodule 