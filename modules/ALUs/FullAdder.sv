module FullAdder
	(output logic Cout, S,
	 input logic Cin, A, B);
	 
	logic n1, n2, n3;
	 
	xor xor1(n1, A, B);
	xor xor2(S, n1, Cin);
	 
	and and1(n2, n1, Cin);
	and and2(n3, A, B);
	 
	or or1(Cout, n2, n3);
	 
endmodule
