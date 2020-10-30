module AND_nBits
	#(parameter bits = 32)
	 (output logic [bits-1:0] S,
	  input logic [bits-1:0] A, B);
	  
	genvar i;
	generate
		for (i=0; i<bits; i++) begin: forloop
			and(S[i], A[i], B[i]);
		end
	endgenerate
		
endmodule
