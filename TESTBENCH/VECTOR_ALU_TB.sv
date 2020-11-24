module VECTOR_ALU_TB;

	logic [31:0] IN0, IN1, OUT;
	logic [1:0]  OP;
	
	VECTOR_ALU 
		VALU (IN0, IN1, OP, OUT);
	
	initial begin
	
		$display ("-----Starting addition testing-----");
		
		IN0 = 32'h05060708;
		IN1 = 32'h01020304;
		OP  = 2'b00; #10
		
		assert (OUT === 32'h06080a0c) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");
			
		$display ("-----Starting subtraction testing-----");
		
		IN0 = 32'h05060708;
		IN1 = 32'h01020304;
		OP  = 2'b01; #10
		
		assert (OUT === 32'h04040404) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
			
		$display ("-----Starting multiplication testing-----");
		
		IN0 = 32'h05060708;
		IN1 = 32'h01020304;
		OP  = 2'b10; #10
		
		assert (OUT === 32'h050c1520) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
			
		$display ("-----Starting division testing-----");
		
		IN0 = 32'h05060708;
		IN1 = 32'h01020304;
		OP  = 2'b11; #10
		
		assert (OUT === 32'h05030202) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
	
	end

endmodule 