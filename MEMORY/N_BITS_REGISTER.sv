module N_BITS_REGISTER #(parameter BITS = 32) (CLK, WE, RST, WD, RD);

	input 				      CLK, WE, RST; // Clock, Write enable, Reset
	input  		 [BITS-1:0] WD;			  // Write data
	output logic [BITS-1:0] RD;			  // Read data
	
	initial begin
		RD = {BITS{1'b0}};
	end

	always @(posedge CLK, posedge RST) begin
		if (RST) RD <= {BITS{1'b0}};
		else if (WE)  RD <= WD;
	end
	
endmodule 
 