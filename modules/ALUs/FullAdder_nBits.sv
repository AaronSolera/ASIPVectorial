module FullAdder_nBits
	#(parameter bits = 32)
	 (output logic Cout,
	  output logic [bits-1:0] S,
	  input logic Cin,
	  input logic [bits-1:0] A, B);
	  
	logic [bits:0] carrys;
	assign carrys[0] = Cin;
	
	genvar i;
	generate
		for (i=0; i<bits; i++) begin: foorloop
			FullAdder fa1(carrys[i+1], S[i], carrys[i], A[i], B[i]);
		end
	endgenerate
	
	assign Cout = carrys[bits];
	  
endmodule
