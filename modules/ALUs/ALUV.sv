module ALUV
	#(parameter bits = 32)
	 (input  logic [3:0]      ALUVControl,
	  input  logic [bits-1:0] A            [9:0],
	  input  logic [bits-1:0] B            [9:0],
	  output logic [3:0]      NZCV         [9:0],
	  output logic [bits-1:0] ALUVResult   [9:0]);

	ALU #(bits) ALU0 (ALUVControl, A[0], B[0], NZCV[0], ALUVResult[0]);
	ALU #(bits) ALU1 (ALUVControl, A[1], B[1], NZCV[1], ALUVResult[1]);
	ALU #(bits) ALU2 (ALUVControl, A[2], B[2], NZCV[2], ALUVResult[2]);
	ALU #(bits) ALU3 (ALUVControl, A[3], B[3], NZCV[3], ALUVResult[3]);
	ALU #(bits) ALU4 (ALUVControl, A[4], B[4], NZCV[4], ALUVResult[4]);
	ALU #(bits) ALU5 (ALUVControl, A[5], B[5], NZCV[5], ALUVResult[5]);
	ALU #(bits) ALU6 (ALUVControl, A[6], B[6], NZCV[6], ALUVResult[6]);
	ALU #(bits) ALU7 (ALUVControl, A[7], B[7], NZCV[7], ALUVResult[7]);
	ALU #(bits) ALU8 (ALUVControl, A[8], B[8], NZCV[8], ALUVResult[8]);
	ALU #(bits) ALU9 (ALUVControl, A[9], B[9], NZCV[9], ALUVResult[9]);
	  
endmodule
