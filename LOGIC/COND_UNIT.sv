module COND_UNIT (CLK, COND, BRANCH, NO_REG_WR, FLAGS, PC_SRC);

	input 		 CLK, BRANCH, NO_REG_WR;
	input  [1:0] COND, FLAGS;
	output 		 PC_SRC;
	
	logic        W_CMP, W_OR, W_AND_B;
	logic  [1:0] W_REG;
 	
	N_BITS_REGISTER #(2) 
		REGISTER (~CLK, NO_REG_WR, 1'b0, FLAGS, W_REG);
		
	N_BITS_EQU_COMPARATOR #(2) 
		COMPARATOR (W_REG, COND, W_CMP);
		
	_AND
		AND_EN (W_OR, BRANCH, PC_SRC),
		AND_B  (COND[0], COND[1], W_AND_B);
		
	_OR
		OR (W_AND_B, W_CMP, W_OR);

endmodule 