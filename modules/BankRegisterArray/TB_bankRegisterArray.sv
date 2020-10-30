module TB_bankRegisterArray();	

	logic             CLK, WE3, V1, V2, V3;
	logic [9:0][15:0] VD1, VD2, WD3;
	
	bankRegisterArray #(16) uut(CLK, WE3, V1, V2, V3, WD3, VD1, VD2);
	
	initial begin
	
		V1 = 0;
		V2 = 1;
		V3 = 0;
		WD3[0] = 16'd00;
		WD3[1] = 16'd11;
		WD3[2] = 16'd22;
		WD3[3] = 16'd33;
		WD3[4] = 16'd44;
		WD3[5] = 16'd55;
		WD3[6] = 16'd66;
		WD3[7] = 16'd77;
		WD3[8] = 16'd88;
		WD3[9] = 16'd99;
		WE3 = 0;
		
		CLK = 1; #10;
		CLK = 0; #10;
		
		WE3 = 1;
		
		CLK = 1; #10;
		CLK = 0; #10;
		
		WE3 = 0;

	end

endmodule
