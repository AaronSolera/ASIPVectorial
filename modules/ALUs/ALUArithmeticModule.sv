module ALUArithmeticModule
	#(parameter bits = 32)
	 (output logic Y_CB,
	  output logic [bits-1:0] Y,
	  input logic [bits-1:0] A, B,
	  input logic S);
	
	logic Cout, Bout;
	logic [bits-1:0] Y_ADD, Y_SUB;
	
	FullAdder_nBits       #(bits) fa1(Cout, Y_ADD, 1'b0, A, B);
	FullSubstracter_nBits #(bits) fs1(Bout, Y_SUB, 1'b0, A, B);
	
	MUX2x1_nBits          #(bits) m1(Y, Y_ADD, Y_SUB, S);
	
	MUX2x1_nBits          #(1)    m2(Y_CB, Cout, Bout, S);
	
endmodule
