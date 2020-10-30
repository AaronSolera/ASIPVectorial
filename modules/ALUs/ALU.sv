module ALU
	#(parameter bits = 32)
	 (input  logic [3:0]      S,
	  input  logic [bits-1:0] A, B,
	  output logic [3:0]      NZCV,
	  output logic [bits-1:0] Y);
	  
	  logic            Y_CB, NOT_S3, n1, n2;
	  logic [bits-1:0] Y_Logic, Y_Arithmetic;
	  
	  ALUArithmeticModule #(bits) ALUAM1 (Y_CB, Y_Arithmetic, A, B, S[0]);
	  
	  ALULogicModule      #(bits) ALULM1 (Y_Logic, A, B, S[2:0]);
	  
	  MUX2x1_nBits        #(bits) m1     (Y, Y_Arithmetic, Y_Logic, S[3]);
	  
	  //------------------------------------------------------------------
	  // FLAGS
	  //------------------------------------------------------------------
	  not not1(NOT_S3, S[3]);
	  
	  //Negative
	  assign NZCV[3] = Y[bits-1];
	  
	  //Zero
	  assign NZCV[2] = (Y == 0);
	  
	  //Carry
	  and and1(NZCV[1], Y_CB, NOT_S3);
	  
	  //oVerflow
	  xor  xor1  (n1, A[bits-1], Y_Arithmetic[bits-1]);
	  xnor xnor1 (n2, A[bits-1], B[bits-1], S[0]);  
	  and  and2  (NZCV[0], n1, n2, NOT_S3);
	  
endmodule
