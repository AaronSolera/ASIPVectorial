module concCheck
	(input logic [3:0] Cond, Flags,
	 output logic      CondEx);

	logic N, Z, C, V, ge;

	assign {N, Z, C, V} = Flags;
	assign ge = (N == V);

	always_comb 
		case(Cond) 
			4'b0000: CondEx = Z; 			//EQ
			4'b0001: CondEx = ~Z; 			//NE
			4'b0010: CondEx = C; 			//CS
			4'b0011: CondEx = ~C; 			//CC
			4'b0100: CondEx = N; 			//MI
			4'b0101: CondEx = ~N; 			//PL
			4'b0110: CondEx = V; 			//VS
			4'b0111: CondEx = ~V; 			//VC
			4'b1000: CondEx = C & ~Z; 		//HI
			4'b1001: CondEx = ~(C & ~Z);	//LS
			4'b1010: CondEx = ge; 			//GE
			4'b1011: CondEx = ~ge; 			//LT
			4'b1100: CondEx = ~Z & ge; 		//GT
			4'b1101: CondEx = ~(~Z & ge); 	//LE
			4'b1110: CondEx = 1'b1; 		//AL (or none)
			default: CondEx = 1'bx; 		//Undefined
		endcase

endmodule
