module VECTOR_MEMORY (CLK, RE, WE, BA, VO, WD, SP, RD);
	 
	input 	     CLK, RE, WE; // Clock, Read enable, Write enable
	input  [31:0] BA, VO, WD;  // Base address, Vector offset, Write data
	output 		  SP;          // Stop pipeline
	output [31:0] RD;			   // Read data
	
	logic 		 W_EN, W_NOR, W_CLK_COUNTER;
	logic [1:0]  W_COUNTER, W_ADD_COUNTER;
	logic [7:0]  W_MUX_ADDRESS, W_WD, W_RD, W_LANE_0, W_LANE_1, W_LANE_2;
	logic [18:0] W_ADDRESS;
	
	MEMORY_8BIT 
		MEM (W_ADDRESS, W_WD, CLK, ~CLK, WE, W_RD);
		
	FOUR_INPUTS_N_BITS_MUX
		MUX_ADDRESS (VO[7:0], VO[15:8], VO[23:16], VO[31:24], W_COUNTER, W_MUX_ADDRESS),
		MUX_DATA    (WD[7:0], WD[15:8], WD[23:16], WD[31:24], W_COUNTER, W_WD);

	N_BITS_ADDER #(19)
		ADDER_ADDRESS (BA[18:0], {{11'd0},W_MUX_ADDRESS}, W_ADDRESS);
	N_BITS_ADDER #(2)
		ADDER_COUNT   (2'b01, W_COUNTER, W_ADD_COUNTER);
	
	_OR
		OR_E (RE, WE, W_EN);
	
	_AND
		AND_EN (CLK, W_EN, W_CLK_COUNTER),
		AND_SP (W_EN, W_NOR, SP);
	
	_NOR
		NOR_COUNT (W_COUNTER[0], W_COUNTER[1], W_NOR);
		
	N_BITS_REGISTER #(2) 
		REG_COUNT (W_CLK_COUNTER, W_CLK_COUNTER, W_ADD_COUNTER, W_COUNTER);
	N_BITS_REGISTER #(8)
		REG_VEC_3 (CLK, CLK, W_RD, W_LANE_0),
		REG_VEC_2 (CLK, CLK, W_LANE_0, W_LANE_1),
		REG_VEC_1 (CLK, CLK, W_LANE_1, W_LANE_2),
		REG_VEC_0 (CLK, CLK, W_LANE_2, RD[7:0]);
	
	assign RD[31:24] = W_LANE_0;
	assign RD[23:16] = W_LANE_1;
	assign RD[15:8]  = W_LANE_2;
	
endmodule
