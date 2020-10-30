module OR_nBits
	#(parameter bits = 32)
	 (output logic [bits-1:0] S,
	  input logic [bits-1:0] A, B);
	  
	genvar i;
	generate
		for (i=0; i<bits; i++) begin: forloop
			or(S[i], A[i], B[i]);
		end
	endgenerate
		
endmodule
