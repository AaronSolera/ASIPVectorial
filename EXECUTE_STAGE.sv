module EXECUTE_STAGE (CLK, PIPELINE_D, PIPELINE_E);

	input  			CLK;
	input  [188:0] PIPELINE_D;
	output [115:0] PIPELINE_E;
	
	logic  		  W_COND_UNIT;
	logic	 [1:0]  W_FLAGS;
	logic  [31:0] W_IMM_MUX, W_S_ALU, W_S_ALU_MUX, W_SV_MUX, W_V_ALU, W_V_ALU_MUX;
	
	N_BITS_REGISTER #(116) 
		PIPELINE (CLK, CLK, 1'b0, 
					 {W_COND_UNIT, PIPELINE_D[184:179], PIPELINE_D[172:170], PIPELINE_D[169:162], PIPELINE_D[129:98], W_S_ALU_MUX, PIPELINE_D[97:96], W_V_ALU_MUX}, 
					 PIPELINE_E);
	
	TWO_INPUTS_N_BITS_MUX #(32) 
		IMM_MUX   (PIPELINE_D[129:98], PIPELINE_D[95:64], PIPELINE_D[173], W_IMM_MUX),
		S_ALU_MUX (W_S_ALU, W_IMM_MUX, PIPELINE_D[177], W_S_ALU_MUX),
		SV_MUX    ({PIPELINE_D[105:98],PIPELINE_D[105:98],PIPELINE_D[105:98],PIPELINE_D[105:98]}, PIPELINE_D[63:32], PIPELINE_D[174], W_SV_MUX),
		V_ALU_MUX (W_V_ALU, PIPELINE_D[31:0], PIPELINE_D[178], W_V_ALU_MUX);

	N_BITS_ALU 
		S_ALU (PIPELINE_D[161:130], W_IMM_MUX, PIPELINE_D[176:175], W_S_ALU, W_FLAGS);
		
	VECTOR_ALU
		V_ALU (PIPELINE_D[31:0], W_SV_MUX, PIPELINE_D[176:175], W_V_ALU);
		
	COND_UNIT 
		CND_UNIT (CLK, PIPELINE_D[188:187], PIPELINE_D[186], PIPELINE_D[185], W_FLAGS, W_COND_UNIT);

endmodule 