module CONTROL_UNIT_TB;

	logic [6:0] FUNCT;
	logic [1:0] OP;
	logic [1:0] ALU_CONTROL;
	logic 		REG_UPDATE, REG_S_WRITE, REG_V_WRITE, ALU_S_SRC, ALU_V_SRC, ALU_S_PASS, ALU_V_PASS, ALU_RESULT_SRC, MEM_SRC, MEM_WRITE, MEM_S, MEM_E, MEM_TO_REG, NO_REG_WRITE, BRANCH;

	
	CONTROL_UNIT 
		CU (FUNCT, OP, REG_UPDATE, REG_S_WRITE, REG_V_WRITE, ALU_S_SRC, ALU_V_SRC, ALU_CONTROL, ALU_S_PASS, 
			 ALU_V_PASS, ALU_RESULT_SRC, MEM_SRC, MEM_WRITE, MEM_S, MEM_E, MEM_TO_REG, NO_REG_WRITE, BRANCH);
			 
	initial begin
		
		OP		= 2'b00;
		FUNCT = 7'b0000000; #10; 
		
		// DP -> VCTR[6:5]I[4]F[3]CMD[2:0] 
		// MI -> VCTR[6:5]U[4]L[3]S[2]E[1]
		//---------------------------------------------------------------------------------------
		// Branch signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- Branch signal testing -----");
		
		OP		= 2'b10; #10;
		
		assert (BRANCH === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// RegVWrite signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- RegVWrite signal testing -----");
		
		OP		= 2'b00;
		FUNCT = 7'b1000000; #10;
		
		assert (REG_V_WRITE === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b1000000; #10;
		
		assert (REG_V_WRITE === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b10;
		FUNCT = 7'b0000000; #10;
		
		assert (REG_V_WRITE === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// ALUSSrc signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- ALUSSrc signal testing -----");
		
		OP		= 2'b00;
		FUNCT = 7'b0000000; #10;
		
		assert (ALU_S_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b00;
		FUNCT = 7'b0010000; #10;
		
		assert (ALU_S_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b0000000; #10;
		
		assert (ALU_S_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b10;
		FUNCT = 7'b0000000; #10;
		
		assert (ALU_S_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// ALUVSrc signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- ALUVSrc signal testing -----");
		
		OP		= 2'b00;
		FUNCT = 7'b1100000; #10;
		
		assert (ALU_V_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b00;
		FUNCT = 7'b1000000; #10;
		
		assert (ALU_V_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// ALUResultSrc signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- ALUResultSrc signal testing -----");
		
		OP		= 2'b00;
		FUNCT = 7'b0000000; #10;
		
		assert (ALU_RESULT_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b00;
		FUNCT = 7'b1000000; #10;
		
		assert (ALU_RESULT_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b0000000; #10;
		
		assert (ALU_RESULT_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b1000000; #10;
		
		assert (ALU_RESULT_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b10;
		FUNCT = 7'b0000000; #10;
		
		assert (ALU_RESULT_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
	   //---------------------------------------------------------------------------------------
		// MemSrc signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- MemSrc signal testing -----");
		
		OP		= 2'b01;
		FUNCT = 7'b0001000; #10;
		
		assert (MEM_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b0000000; #10;
		
		assert (MEM_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b1001000; #10;
		
		assert (MEM_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b1000000; #10;
		
		assert (MEM_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// MemWrite signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- MemWrite signal testing -----");
		
		OP		= 2'b00;
		FUNCT = 7'b0000000; #10;
		
		assert (MEM_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b0000000; #10;
		
		assert (MEM_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b10;
		FUNCT = 7'b0000000; #10;
		
		assert (MEM_SRC === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");

		//---------------------------------------------------------------------------------------
		// MemToReg signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- MemToReg signal testing -----");
		
		OP		= 2'b00;
		FUNCT = 7'b0000000; #10;
		
		assert (MEM_TO_REG === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b0001000; #10;
		
		assert (MEM_TO_REG === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b01;
		FUNCT = 7'b0000000; #10;
		
		assert (MEM_TO_REG === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		OP		= 2'b10;
		FUNCT = 7'b0000000; #10;
		
		assert (MEM_TO_REG === 1'b0) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// RegUpdate signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- RegUpdate signal testing -----");
		
		OP		= 2'b01;
		FUNCT = 7'b0010000; #10;
		
		assert (REG_UPDATE === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// MemS signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- MemS signal testing -----");
		
		OP		= 2'b01;
		FUNCT = 7'b0000100; #10;
		
		assert (MEM_S === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// MemE signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- MemE signal testing -----");
		
		OP		= 2'b01;
		FUNCT = 7'b0000010; #10;
		
		assert (MEM_E === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		//---------------------------------------------------------------------------------------
		// NoRegWrite signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- NoRegWrite signal testing -----");
		
		OP		= 2'b00;
		FUNCT = 7'b0000101; #10;
		
		assert (NO_REG_WRITE === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
	
		//---------------------------------------------------------------------------------------
		// RegSWrite signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- RegSWrite signal testing -----");
		
		//---------------------------------------------------------------------------------------
		// ALUSPass signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- ALUSPass signal testing -----");
		
		//---------------------------------------------------------------------------------------
		// ALUVPass signal testing
		//---------------------------------------------------------------------------------------
		$display ("----- ALUVPass signal testing -----");
		
	end

endmodule 