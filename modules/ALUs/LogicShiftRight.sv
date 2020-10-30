module LogicShiftRight 
	#(parameter bits = 32)
	 (output logic signed [bits-1:0] S,
	  input logic [bits-1:0] A, B);

	assign S = A >> B;
	
endmodule
