module MUX2x1_nBits
	#(parameter bits = 32)
	 (output logic [bits-1:0] Z,
	  input logic [bits-1:0] E0, E1,
	  input logic S);

	genvar i;
	generate
		for (i=0; i<bits; i++) begin: forloop
			MUX2x1 m1(Z[i], E0[i], E1[i], S);
		end
	endgenerate

endmodule
