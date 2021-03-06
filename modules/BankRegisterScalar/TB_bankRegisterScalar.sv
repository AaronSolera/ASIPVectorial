module TB_bankRegisterScalar();	

	logic 		 CLK, WE3;
	logic [3:0]  A1, A2, A3;
	logic [31:0] WD3, PCplus;
	logic [31:0] RD1, RD2;
	
	bankRegister #(32) uut(CLK, WE3, A1, A2, A3, WD3, r15, RD1, RD2);
	
	initial begin
		A1 = 4'b0001;
		A2 = 4'b0100;
		A3 = 4'b1000;
		PCplus = 32'b10101010101010101010101010101010;
		WD3 = 32'b11111111111111000000000000000111;
		WE3 = 0;
		CLK = 1; #10;
		
		PCplus = 32'b10101010101010010101010110101010;
		CLK = 0;#10;
		
		WE3 = 1;
		CLK = 1;#10;
		CLK = 0;#10;
		
		WD3 = 32'b11110000000000000000000000000111;
		A3 = 4'b0001;
		PCplus = 32'b00000000000000000010101010101010;
		CLK = 1;#10;
		CLK = 0;#10;
		
		WE3 = 0;
		CLK = 1;#10;
		CLK = 0;#10;
		
		WE3 = 1;
		WD3 = 32'b11110000000011111111000000000111;
		PCplus = 32'b10101010101010101111111111111111;
		A3 = 4'b0100;
		CLK = 1;#10;
		CLK = 0;#10;
		CLK = 1;#10;
		CLK = 0;#10;
	end

endmodule