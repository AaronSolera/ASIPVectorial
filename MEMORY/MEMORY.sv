module MEMORY (CLK, A, WDV, WDS, POS, WE, E, S, RD);

	input  CLK, WE, E, S;   // Clock, Write enable, Extra, Special
	input  [16:0] A;			// Address
	input  [31:0] WDV, WDS; // Write data vector, Write data scalar
	input  [1:0]  POS; 		// Position
	output logic [31:0] RD;			// Read data
	
	logic 		  RCLK, WCLK;
	logic  [3:0]  W_DEC;
	logic  [7:0]  W_MUX_EX1;
	logic  [31:0] W_MUX_WD, W_WD, W_RD, W_MUX_EX0, W_MUX_S;
	
	MEMORY_32BIT
		MEMORY (A, W_WD, WCLK, RCLK, WE, W_RD);
		
	DECODER_0 
		DEC0 (POS, W_DEC);
  
	TWO_INPUTS_N_BITS_MUX #(1)
		CLKR_MUX (CLK, ~CLK,  WE, WCLK),
		CLKW_MUX (~CLK, CLK,  WE, RCLK);
	TWO_INPUTS_N_BITS_MUX 
		WDV0_MUX (WDV[7:0],   WDS[7:0], W_DEC[0], W_MUX_WD[7:0]),
		WDV1_MUX (WDV[15:8],  WDS[7:0], W_DEC[1], W_MUX_WD[15:8]),
		WDV2_MUX (WDV[23:16], WDS[7:0], W_DEC[2], W_MUX_WD[23:16]),
		WDV3_MUX (WDV[31:24], WDS[7:0], W_DEC[3], W_MUX_WD[31:24]);
	TWO_INPUTS_N_BITS_MUX #(32)
		WD_MUX  (WDV, W_MUX_WD, E, W_WD),
		EX0_MUX ({W_RD[15:8], W_RD[15:8], W_RD[7:0], W_RD[7:0]}, {W_RD[31:24], W_RD[31:24], W_RD[23:16], W_RD[23:16]}, POS[0], W_MUX_EX0),
		S_MUX   (W_MUX_EX0, {{24'd0}, W_MUX_EX1}, E, W_MUX_S),
		RD_MUX  (W_RD, W_MUX_S, S, RD);
	FOUR_INPUTS_N_BITS_MUX
		EX1_MUX (W_RD[7:0], W_RD[15:8], W_RD[23:16], W_RD[31:24], POS, W_MUX_EX1);

endmodule 