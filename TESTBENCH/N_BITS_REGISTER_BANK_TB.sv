module N_BITS_REGISTER_BANK_TB;

	logic 			  CLK, WE3;
	logic [3:0] 	  A1, A2, A3;
	logic [31:0] WD3, RD1, RD2;
	
	N_BITS_REGISTER_BANK 
		REG_BANK (CLK, WE3, A1, A2, A3, WD3, RD1, RD2);
		
	initial begin
	
		CLK = 1'b0; 
		WE3 = 1'b1;
		A1  = 4'd0;
		A2  = 4'd0;
		A3  = 4'd0;
		WD3 = 32'd0;
		
		$display ("-----Starting writing data testing-----");
		
		for (int i = 1; i < 15; i++) begin

			A3  = i;
			WD3 = i;
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
		end
		
		$display ("-----Starting reading data testing-----");
		
		WE3 = 1'b0;
		
		A1  = 4'd0;
		A2  = 4'd0;
	
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD1 === 32'd65536) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		assert (RD2 === 32'd65536) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		
		for (int i = 1; i < 15; i++) begin

			A1  = i;
			A2  = i;
		
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
			assert (RD1 === i) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");
			assert (RD2 === i) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");
		
		end
	
		A1  = 4'd15;
		A2  = 4'd15;
	
		CLK = 1'b1; #10;
		CLK = 1'b0; #10;
		
		assert (RD1 === 32'd81928) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		assert (RD2 === 32'd81928) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
	end

endmodule 