module N_BITS_REGISTER_BANK #(parameter BITS = 32) (CLK, WE3, A1, A2, A3, WD3, RD1, RD2);
	  
	input 			         CLK, WE3;
	input        [3:0] 	   A1, A2, A3;
	input        [BITS-1:0] WD3;
	output logic [BITS-1:0] RD1, RD2;
	
	logic [BITS-1:0] REGS [15:0];

	initial begin
	
		REGS[0]  = 32'd0;
		REGS[1]  = 32'd81928;
		REGS[15] = 32'd65536;
		
		for (int i = 2; i < 15; i++) begin
			
			REGS[i] = 32'd0;
			
		end
		
	end
	
	always @ (posedge CLK)
		if (WE3) REGS[A3] <= WD3;
		
	assign RD1 = REGS[A1];
	assign RD2 = REGS[A2];

endmodule
