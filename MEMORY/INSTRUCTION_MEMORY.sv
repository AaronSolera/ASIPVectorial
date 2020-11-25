module INSTRUCTION_MEMORY #(parameter PATH = "")(CLK, PC, INSTRUCTION);

	input        [31:0] PC;
	input               CLK;
	output logic [31:0] INSTRUCTION;

	logic [31:0] READ [0:263];

	initial begin
		INSTRUCTION = 32'b11000000000000000000000000000000;
		$readmemb(PATH, READ);
	end

	always @ (posedge CLK) begin
		INSTRUCTION = READ[PC];
	end
	
endmodule 