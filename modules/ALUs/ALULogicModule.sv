module ALULogicModule
	#(parameter bits = 32)
	 (output logic [bits-1:0] Y,
	  input logic [bits-1:0] A, B,
	  input logic [2:0] S);
	
	logic [bits-1:0] Y_AND, Y_OR, Y_XOR, Y_NOT, Y_LSL, Y_LSR, Y_ASR;
	
	AND_nBits            #(bits) and1(Y_AND, A, B);
	OR_nBits             #(bits) or1(Y_OR, A, B);
	XOR_nBits            #(bits) xor1(Y_XOR, A, B);
	NOT_nBits            #(bits) not1(Y_NOT, A);
	LogicShiftLeft       #(bits) LSL1(Y_LSL, A, B);
	LogicShiftRight      #(bits) LSR1(Y_LSR, A, B);
	ArithmeticShiftRight #(bits) ASR1(Y_ASR, A, B);
	
	MUX8x1_nBits         #(bits) m1(Y, Y_AND, Y_OR, Y_XOR, Y_NOT, Y_LSL, Y_LSR, Y_ASR, 0, S);
	
endmodule
