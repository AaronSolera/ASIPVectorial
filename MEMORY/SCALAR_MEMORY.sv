module SACALAR_MEMORY (CLK, WE, A, WD, RD);

	input  		  CLK, WE; // Clock, Write enable
	input  [31:0] A, WD;	  // Address, Write data
	output [31:0] RD;      // Read data

	MEMORY_32BIT 
		MEMORY (A, WD, CLK, ~CLK, WE, RD);

endmodule
