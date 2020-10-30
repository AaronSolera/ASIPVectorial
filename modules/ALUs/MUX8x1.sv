module MUX8x1
	(output logic Z,
	 input logic E0, E1, E2, E3, E4, E5, E6, E7, S2, S1, S0);
	 
	logic n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, NOT_S2, NOT_S1, NOT_S0;
	
	not not1(NOT_S2, S2);
	not not2(NOT_S1, S1);
	not not3(NOT_S0, S0);
	
	and and1(n0, E0, NOT_S2, NOT_S1, NOT_S0);
	and and2(n1, E1, NOT_S2, NOT_S1, S0);
	and and3(n2, E2, NOT_S2, S1, NOT_S0);
	and and4(n3, E3, NOT_S2, S1, S0);
	and and5(n4, E4, S2, NOT_S1, NOT_S0);
	and and6(n5, E5, S2, NOT_S1, S0);
	and and7(n6, E6, S2, S1, NOT_S0);
	and and8(n7, E7, S2, S1, S0);
	
	or or1(n10, n0, n1, n2, n3);
	or or2(n11, n4, n5, n6, n7);
	or or3(Z, n10, n11);
	
endmodule
