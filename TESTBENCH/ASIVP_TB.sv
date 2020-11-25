`timescale 1 ps / 1 ps
module ASIVP_TB;

	// vsim -L altera_mf_ver -L lpm_ver work.ASIVP_TB

	logic       CLK;
	logic [4:0] SWITCH;
	logic [7:0] IMAGE;
 
	ASIVP 
		MAIN (CLK, SWITCH, IMAGE);
		
	initial begin
		
		SWITCH = 5'd10;
		CLK    = 1'b0;
	
	end
	
	always begin
	
		CLK <= ~ CLK; #1;
		
	end
	
endmodule 