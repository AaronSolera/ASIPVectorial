module VECTOR_MEMORY (CLK, RE, WE, BA, VO, SO, WD, SP, RD);
	 
	input 	     CLK, RE, WE, SO; // Clock, Read enable, Write enable, Scalar operation
	input  [31:0] BA, VO, WD;   	 // Base address, Vector offset, Write data
	output 		  SP;              // Stop pipeline
	output [31:0] RD;			   	 // Read data
	
	logic 		 W_EN, W_RST, W_EQU, W_CLK_COUNTER;
	logic [2:0]  W_COUNTER, W_ADD_COUNTER;
	logic [7:0]  W_MUX_ADDRESS, W_WD, W_RD, W_LANE_0, W_LANE_1;
	logic [18:0] W_ADDER, W_ADDRESS;
	logic [31:0] W_LANE;
	
	MEMORY_8BIT 
		MEM (W_ADDRESS, W_WD, W_CLK_COUNTER, ~W_CLK_COUNTER, WE, W_RD);

	TWO_INPUTS_N_BITS_MUX #(19)
		MUX_ADDRESS ( BA[18:0], W_ADDER, SO, W_ADDRESS);
	TWO_INPUTS_N_BITS_MUX #(32)
		MUX_RD		({{24'd0},W_RD}, W_LANE, SO, RD);
	FOUR_INPUTS_N_BITS_MUX
		MUX_ADDER (VO[7:0], VO[15:8], VO[23:16], VO[31:24], W_COUNTER[1:0], W_MUX_ADDRESS),
		MUX_DATA  (WD[7:0], WD[15:8], WD[23:16], WD[31:24], W_COUNTER[1:0], W_WD);
 
	N_BITS_ADDER #(19)
		ADDER_ADDRESS (BA[18:0], {{11'd0},W_MUX_ADDRESS}, W_ADDER);
	N_BITS_ADDER #(3)
		ADDER_COUNT   (3'd1, W_COUNTER, W_ADD_COUNTER);

	_OR
		OR_E (RE, WE, W_EN);

	_AND
		AND_EN  (CLK, W_EN, W_CLK_COUNTER),
		AND_SP  (W_EN, W_EQU, SP),
		AND_RST (~W_EN, SO, W_RST);
 
	_NAND
		NAND_COUNT (W_COUNTER[2], W_COUNTER[0], W_EQU);

	N_BITS_REGISTER #(3)
		REG_COUNT (W_CLK_COUNTER, W_CLK_COUNTER, W_RST, W_ADD_COUNTER, W_COUNTER);
	N_BITS_REGISTER #(8)
		REG_VEC_2 (W_CLK_COUNTER, W_EN, ~W_EN, W_RD,     W_LANE_0),
		REG_VEC_1 (W_CLK_COUNTER, W_EN, ~W_EN, W_LANE_0, W_LANE_1),
		REG_VEC_0 (W_CLK_COUNTER, W_EN, ~W_EN, W_LANE_1, W_LANE[7:0]);

	assign W_LANE[31:24] = W_RD;
	assign W_LANE[23:16] = W_LANE_0;
	assign W_LANE[15:8]  = W_LANE_1;

endmodule
