module REGISTER #(parameter DATA_SIZE = 32) (CLK, RST, WRITE, IN_DATA, OUT_DATA);

	input  logic CLK, WRITE, RST;
	input  logic [DATA_SIZE-1:0] IN_DATA;
	output logic [DATA_SIZE-1:0] OUT_DATA;
	
	logic [DATA_SIZE-1:0] MEMORY;
	
	always_ff @(negedge CLK, negedge RST, posedge WRITE) begin
		if (!RST) MEMORY <= {DATA_SIZE{1'b1}};
		if (WRITE) MEMORY <= IN_DATA;
		OUT_DATA <= MEMORY; 
	end
	
endmodule 
