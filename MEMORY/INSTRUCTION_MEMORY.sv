module INSTRUCTION_MEMORY #(parameter PATH = "")(CLK, PC, INSTRUCTION);

	input        [31:0] PC;
	input               CLK;
	output logic [31:0] INSTRUCTION;

	logic [31:0] READ [0:1];
	
	initial begin
		$readmemh(PATH, READ);
	end
	
	always_ff @ (posedge CLK) begin
		INSTRUCTION = READ[PC];
	end
	
endmodule 