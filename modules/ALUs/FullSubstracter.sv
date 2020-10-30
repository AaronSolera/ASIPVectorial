module FullSubstracter
	(output logic Bout, R,
	 input logic Bin, A, B);
	 
	logic n1, n2, n3, n4;
	logic NOT_A;
	 
	xor xor1(n1, A, B);
	xor xor2(R, n1, Bin);
	 
	not not1(NOT_A, A);
	 
	and and1(n2, NOT_A, B);
	and and2(n3, NOT_A, Bin);
	and and3(n4, B, Bin);
	or or1(Bout, n2, n3, n4);

endmodule
