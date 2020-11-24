module COND_UNIT_TB;

	logic 		CLK, BRANCH, NO_REG_WR, PC_SRC;
	logic [1:0] COND, FLAGS;

	COND_UNIT 
		CU (CLK, COND, BRANCH, NO_REG_WR, FLAGS, PC_SRC);
		
	initial begin
		
		CLK       = 1'b0;
		NO_REG_WR = 1'b0;
		BRANCH    = 1'b0;
		FLAGS		 = 2'b00;
		COND      = 2'b00;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		$display ("----- Starting BEQ instruction testing -----");
		
		NO_REG_WR = 1'b1;
		FLAGS		 = 2'b10;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		NO_REG_WR = 1'b0;
		FLAGS		 = 2'b00;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		BRANCH    = 1'b1;
		COND      = 2'b10;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		assert (PC_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		$display ("----- Starting BLT instruction testing -----");
		
		NO_REG_WR = 1'b1;
		FLAGS		 = 2'b01;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		NO_REG_WR = 1'b0;
		FLAGS		 = 2'b00;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		BRANCH    = 1'b1;
		COND      = 2'b01;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100

		assert (PC_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		$display ("----- Starting BGT instruction testing -----");
		
		NO_REG_WR = 1'b1;
		FLAGS		 = 2'b00;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		NO_REG_WR = 1'b0;
		FLAGS		 = 2'b00;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		BRANCH    = 1'b1;
		COND      = 2'b00;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		assert (PC_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
		$display ("----- Starting B instruction testing -----");
		
		NO_REG_WR = 1'b1;
		FLAGS		 = 2'b11;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		NO_REG_WR = 1'b0;
		FLAGS		 = 2'b00;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		BRANCH    = 1'b1;
		COND      = 2'b11;
		
		CLK       = 1'b1; #100
		CLK       = 1'b0; #100
		
		assert (PC_SRC === 1'b1) $display ("OK! Test passed.");
		else $display ("ERROR! Test failed.");
		
	end

endmodule 