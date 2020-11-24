module VECTOR_ALU (IN0, IN1, OP, OUT);

	input        [31:0] IN0, IN1; // Inputs
	input        [1:0]  OP;			// Operation
	output logic [31:0] OUT;      // Output
	
	always_comb begin
		
		case (OP)
			
			2'b00: 
				begin
				OUT[7:0]   = IN0[7:0]   + IN1[7:0];
				OUT[15:8]  = IN0[15:8]  + IN1[15:8];
				OUT[23:16] = IN0[23:16] + IN1[23:16];
				OUT[31:24] = IN0[31:24] + IN1[31:24];
				end
			2'b01: 
				begin
				OUT[7:0]   = IN0[7:0]   - IN1[7:0];
				OUT[15:8]  = IN0[15:8]  - IN1[15:8];
				OUT[23:16] = IN0[23:16] - IN1[23:16];
				OUT[31:24] = IN0[31:24] - IN1[31:24];
				end
			2'b10: 
				begin
				OUT[7:0]   = IN0[7:0]   * IN1[7:0];
				OUT[15:8]  = IN0[15:8]  * IN1[15:8];
				OUT[23:16] = IN0[23:16] * IN1[23:16];
				OUT[31:24] = IN0[31:24] * IN1[31:24];
				end
			2'b11: 
				begin
				OUT[7:0]   = IN0[7:0]   / IN1[7:0];
				OUT[15:8]  = IN0[15:8]  / IN1[15:8];
				OUT[23:16] = IN0[23:16] / IN1[23:16];
				OUT[31:24] = IN0[31:24] / IN1[31:24];
				end
			
		endcase
		
	end

endmodule 