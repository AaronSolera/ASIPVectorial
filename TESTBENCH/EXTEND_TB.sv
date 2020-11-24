module EXTEND_TB;

	logic [8:0]  IN;
	logic [31:0] OUT;
	
	EXTEND 
		EX (IN, OUT);
		
	initial begin
	
		IN = 9'd224; #10
		
		assert (OUT === 32'd224) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		IN = -9'd224; #10
		
		assert (OUT === -32'd224) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
	
	end

endmodule 