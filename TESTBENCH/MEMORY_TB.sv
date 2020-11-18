`timescale 1 ps / 1 ps
module MEMORY_TB;

	// vsim -L altera_mf_ver -L lpm_ver work.SCALAR_MEMORY_TB

	logic 		 CLK, WE, E, S;
	logic [1:0]  POS;
	logic [16:0] A;
	logic [31:0] WDV, WDS, RD;
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
	MEMORY 
		MEM (CLK, A, WDV, WDS, POS, WE, E, S, RD);

	initial begin

		WE  = 1'b0;
		E   = 1'b0;
		S   = 1'b0;
		A   = 17'd0;
		WDS = 32'd0;
		WDV = 32'd0;
		POS = 2'd0;
		
		for (int i = 5; i < 10; i++) begin
			
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
 
		$display ("-----Starting str data testing-----");

		WE  = 1'b1;
		
		for (int i = 5; i < 10; i++) begin

			A = i;
			WDV = i * 10;
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
		end
		
		WE  = 1'b0;
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;

		$display ("-----Starting load data testing-----");
		
		for (int i = 5; i < 10; i++) begin
 
			A = i;
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;

			assert (RD === i * 10) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");

		end
		
		$display ("-----Starting store one element at one positon in  a vector data testing-----");
		
		A   = 17'd1;
		WE  = 1'b1;
		WDS = 32'hA;
		WDV = 32'h03020100;
		POS = 2'd0;
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		E   = 1'b1;
		
		for (int i = 0; i < 4; i++) begin
 
			POS = i; 
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;

		end
		
		E   = 1'b0;
		WE  = 1'b0;
		POS = 2'd0;
		WDS = 32'h0;
		WDV = 32'h0;
		POS = 2'd0;
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD === 32'h0a020100) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
 
		$display ("-----Starting first load extra function testing-----");
		
		S   = 1'b1;
		POS = 2'd0;
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD === 32'h01010000) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		POS = 2'd1;
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD === 32'h0a0a0202) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		$display ("-----Starting second load extra function testing-----");
		
		E   = 1'b1;
		S   = 1'b1;
		POS = 2'd0;
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD === 32'h00000000) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		POS = 2'd1;
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD === 32'h00000001) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		POS = 2'd2;
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD === 32'h00000002) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		POS = 2'd3;
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD === 32'h0000000a) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
	end 

endmodule 