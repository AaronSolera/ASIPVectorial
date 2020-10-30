module TB_ALUV();

	logic [3:0]  ALUControl;
	logic [15:0] A           [9:0]; 
	logic [15:0] B           [9:0]; 
	logic [3:0]  NZCV        [9:0]; 
	logic [15:0] ALUResult   [9:0];
	
	ALUV #(16) uut(ALUControl, A, B, NZCV, ALUResult);

	initial begin
	
		A[0] = 16'd0; B[0] = 16'd0; 
		A[1] = 16'd1; B[1] = 16'd1; 
		A[2] = 16'd2; B[2] = 16'd2; 
		A[3] = 16'd3; B[3] = 16'd3; 
		A[4] = 16'd4; B[4] = 16'd4; 
		A[5] = 16'd5; B[5] = 16'd5; 
		A[6] = 16'd6; B[6] = 16'd6;
		A[7] = 16'd7; B[7] = 16'd7; 
		A[8] = 16'd8; B[8] = 16'd8; 
		A[9] = 16'd9; B[9] = 16'd9; 
		ALUControl = 4'b0; 
		#100;
		
		A[0] = 16'd0; B[0] = 16'd0; 
		A[1] = 16'd1; B[1] = 16'd1; 
		A[2] = 16'd2; B[2] = 16'd2; 
		A[3] = 16'd3; B[3] = 16'd3; 
		A[4] = 16'd4; B[4] = 16'd4; 
		A[5] = 16'd5; B[5] = 16'd5; 
		A[6] = 16'd6; B[6] = 16'd6;
		A[7] = 16'd7; B[7] = 16'd7; 
		A[8] = 16'd8; B[8] = 16'd8; 
		A[9] = 16'd9; B[9] = 16'd9; 
		ALUControl = 4'b1; 
		#100;
		
	end
	
endmodule
