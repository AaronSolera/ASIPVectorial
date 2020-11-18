module DECODER_0 (POS, OUT);

	input 	    [1:0] POS; // Position number
	output logic [3:0] OUT; // Outputs
	
	always_comb begin
		
		case (POS)
			
			2'd0: OUT = 4'b0001;
			2'd1: OUT = 4'b0010;
			2'd2: OUT = 4'b0100;
			2'd3: OUT = 4'b1000;
			
		endcase
		
	end
	
endmodule 