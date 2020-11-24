module condLogic
	(input logic       CLK, PCS, RegW, NoWrite, MemW,
	 input logic [1:0] FlagW,
	 input logic [3:0] Cond, ALUFlags,
	 output logic      PCSrc, RegWrite, MemWrite);

	logic [1:0] FlagWrite;
	logic [3:0] Flags;
	logic       CondEx;

	FlipFlop #(2) flagreg1(ALUFlags[3:2], CLK, reset, FlagWrite[1], Flags[3:2]);
	FlipFlop #(2) flagreg0(ALUFlags[1:0], CLK, reset, FlagWrite[0], Flags[1:0]);
	
	//Write controls are conditional
	assign FlagWrite = FlagW & {2{CondEx}};
	
	concCheck   cc(Cond, Flags, CondEx,);
	and         and1(PCSrc, PCS, CondEx);
	and         and2(RegWrite, RegW, ~NoWrite, CondEx);
	and         and3(MemWrite, MemW, CondEx);

endmodule
