`timescale 1 ps / 1 ps
module SCALAR_MEMORY_TB;

	logic 		 CLK, WE;
	logic [31:0] A, WD, RD;
	
	SACALAR_MEMORY 
		SM (CLK, WE, A, WD, RD);
	
	initial begin
		
		WE = 1'b1;
		A  = 32'd0;
		WD = 32'd0;
		CLK = 1'b0;
		
		$display ("-----Starting str data testing-----");
		
		for (int i = 0; i < 10; i++) begin

			A = i;
			WD = i * 10;
			
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
		
		WE = 1'b0;
		
		$display ("-----Starting load data testing-----");
		
		for (int i = 0; i < 10; i++) begin

			A = i;
			CLK = 1'b1; #10;
			CLK = 1'b0; #10; 

			assert (A == i * 10) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");
			
		end
		
	end



endmodule
