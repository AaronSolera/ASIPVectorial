`timescale 1 ps / 1 ps
module VECTOR_MEMORY_TB;

	// vsim -L altera_mf_ver -L lpm_ver work.VECTOR_MEMORY_TB

	logic CLK, RE, WE, SP, SO;
	logic [31:0] BA, VO, WD, RD;
	/*
	VECTOR_MEMORY 
		VM (CLK, RE, WE, BA, VO, SO, WD, SP, RD);
	*/
	initial begin
		
		CLK = 1'b0;
		RE = 1'b0;
		WE = 1'b0;
		SO = 1'b1;
		BA = 32'd9;
		VO = 32'h04030201;
		WD = 32'h04030201;
		
		for (int i = 0; i < 4; i++) begin
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
		
		WE = 1'b1;
		
		for (int i = 0; i < 4; i++) begin
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
		
		WE = 1'b0;
		VO = 32'h02020101;
		
		for (int i = 0; i < 4; i++) begin
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;

		end
		
		RE = 1'b1;

		for (int i = 0; i < 5; i++) begin
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
		
		RE = 1'b0;
		SO = 1'b0;
		
		for (int i = 0; i < 4; i++) begin
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;

		end
		
		RE = 1'b1;
		
		for (int i = 10; i < 14; i++) begin
			BA = i;
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;

		end

	end

endmodule
