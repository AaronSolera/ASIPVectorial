module MUX8x1_nBits
	#(parameter bits = 32)
	 (output logic [bits-1:0] Z,
	  input logic [bits-1:0] E0, E1, E2, E3, E4, E5, E6, E7,
	  input logic [2:0] S);

	genvar i;
	generate
		for (i=0; i<bits; i++) begin: forloop
			MUX8x1 m1(Z[i], E0[i], E1[i], E2[i], E3[i], E4[i], E5[i], E6[i], E7[i], S[2], S[1], S[0]);
		end
	endgenerate

endmodule
