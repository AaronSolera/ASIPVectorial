module NOT_nBits
	#(parameter bits = 32)
	 (output logic [bits-1:0] S,
	  input logic [bits-1:0] A);
	  
	genvar i;
	generate
		for (i=0; i<bits; i++) begin: forloop
			not(S[i], A[i]);
		end
	endgenerate
		
endmodule
