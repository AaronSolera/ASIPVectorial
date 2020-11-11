`timescale 1 ps / 1 ps
module SCALAR_MEMORY_TB;

	logic 		CLK, WE;
	logic [31:0] A, WD, RD;
	//logic [7:0] WD, RD;
	
/*
	N_BITS_REGISTER #(8) 
		REG (CLK, WE, WD, RD);
		
	initial begin

		CLK = 1'b0;
		WE = 1'b1;
		WD = 8'd0;
		
		for (int i = 0; i < 10; i++) begin

			WD = i;
			CLK = 1'b1; #10;
			CLK = 1'b0; #10; 

			assert (RD === i) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");
			
		end
	
		WE = 1'b0;
		
		for (int i = 0; i < 10; i++) begin

			WD = i;
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
		
	end
*/

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

			assert (RD === i * 10) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");
			
		end
		
	end

endmodule
