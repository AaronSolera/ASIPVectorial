module TB_ALU();

	logic [3:0] A, B, ALUControl, ALUResult, NZCV;
	
	ALU #(4) uut(ALUControl, A, B, NZCV, ALUResult);

	initial begin
	
		A = 4'd2; B = 4'd2; ALUControl = 4'b0;  
		#10;
		
		A = 4'd2; B = 4'd2; ALUControl = 4'b1;  
		#10;
	
		A = 4'd2; B = 4'd2; ALUControl = 4'b10; 
		#10;
		
	end
	
endmodule
