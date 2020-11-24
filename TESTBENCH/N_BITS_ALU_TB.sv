module N_BITS_ALU_TB;

	logic [31:0] IN0, IN1, OUT;
	logic [1:0]  OP, FLAGS;
	
	N_BITS_ALU 
		ALU (IN0, IN1, OP, OUT, FLAGS);
	
	initial begin
	
		$display ("-----Starting addition testing-----");
		
		IN0 = 32'd37;
		IN1 = 32'd83;
		OP  = 2'b00; #10
		
		assert (OUT === 32'd120) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");
			
		$display ("-----Starting subtraction testing-----");
		
		IN0 = 32'd37;
		IN1 = 32'd83;
		OP  = 2'b01; #10
		
		assert (OUT === -32'd46) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
			
		$display ("-----Starting multiplication testing-----");
		
		IN0 = 32'd37;
		IN1 = 32'd83;
		OP  = 2'b10; #10
		
		assert (OUT === 32'd3071) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
			
		$display ("-----Starting division testing-----");
		
		IN0 = 32'd2045;
		IN1 = 32'd83;
		OP  = 2'b11; #10
		
		assert (OUT === 32'd24) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		$display ("-----Starting Z flag testing-----");
		
		IN0 = 32'd83;
		IN1 = 32'd83;
		OP  = 2'b01; #10
		
		assert (FLAGS[1] === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		$display ("-----Starting N flag testing-----");
		
		IN0 = 32'd157;
		IN1 = 32'd8752;
		OP  = 2'b01; #10
		
		assert (FLAGS[0] === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
	
	end

endmodule 