module INSTRUCTION_MEMORY_TB;

	logic [31:0] PC, INSTRUCTION;
	logic        CLK;

	INSTRUCTION_MEMORY #("C:/Users/Lenovo/Desktop/ASIVP/ASIVP/TESTBENCH/testbench.hex")
		INS_MEM (CLK, PC, INSTRUCTION);
		
		
	initial begin
	
		for (int i = 0; i < 8; i++) begin
		
			PC = i;
			
			CLK = 1'b1; #10;
			CLK = 1'b0; #10;
			
			assert (INSTRUCTION === i) $display ("OK! Test passed.");
			else $display ("ERROR! Test failed.");
			
		end
	
	end

endmodule 