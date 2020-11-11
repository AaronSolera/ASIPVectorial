`timescale 1 ps / 1 ps
module VECTOR_MEMORY_TB;

	logic CLK, RE, WE, SP;
	logic [31:0] BA, VO, WD, RD;
	
	VECTOR_MEMORY 
		VM (CLK, RE, WE, BA, VO, WD, SP, RD);

	initial begin
		
		CLK = 1'b0;
		RE = 1'b0;
		WE = 1'b0;
		BA = 32'd0;
		VO = 32'h03020100;
		WD = 32'h04030201;
		
		for (int i = 0; i < 5; i++) begin
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
		
		WE = 1'b1;
	
		for (int i = 0; i < 5; i++) begin
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
		
	end

endmodule
