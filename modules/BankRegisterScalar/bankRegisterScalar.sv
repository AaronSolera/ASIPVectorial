module bankRegisterScalar
	#(parameter bits = 32)
	 (input  logic 			   CLK, WE3,
	  input  logic [3:0] 	   A1, A2, A3,
	  input  logic [bits-1:0]  WD3, r15,
	  output logic [bits-1:0]  RD1, RD2);
	
	logic [bits-1:0] rf [14:0];
	
	always_ff@(posedge CLK)
		if (WE3) rf[A3] <= WD3;
		
	assign RD1 = (A1 == 4'b1111) ? r15 : rf[A1];
	assign RD2 = (A2 == 4'b1111) ? r15 : rf[A2];

endmodule
