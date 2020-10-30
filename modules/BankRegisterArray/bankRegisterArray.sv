module bankRegisterArray
	#(parameter bits = 16)
	 (input  logic 			       CLK, WE3, 
	  input  logic                 V1, V2, V3,
	  input  logic [9:0][bits-1:0] WD3,
     output logic [9:0][bits-1:0] VD1, 
     output logic [9:0][bits-1:0] VD2);
	
	logic [1:0][9:0][bits-1:0] rf;
	
	always_ff@(posedge CLK)
		if (WE3) rf[V3] <= WD3;
		
	assign VD1 = rf[V1];
	assign VD2 = rf[V2];

endmodule
