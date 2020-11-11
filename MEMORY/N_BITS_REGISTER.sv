module N_BITS_REGISTER #(parameter BITS = 32) (CLK, WE, WD, RD);

	input 				      CLK, WE; // Clock, Write enable
	input  		 [BITS-1:0] WD;		// Write data
	output logic [BITS-1:0] RD;		// Read data
	
	initial begin
		RD = {BITS{1'b0}};
	end

	always @(posedge CLK) begin
		if (WE) RD <= WD;
	end
	 
endmodule 
