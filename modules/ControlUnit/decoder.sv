module decoder
	(input logic  [1:0] Op,
	 input logic  [7:0] Funct,
	 input logic  [3:0] Rd,
	 output logic       PCS, RegSW, RegVW, MemW, MemtoReg, ALUSrc, NoWrite, Pass,
	 output logic [1:0] FlagW, ImmSrc, RegSrc, 
	 output logic [3:0] ALUControl);

	logic       Branch, ALUOp;
	logic [9:0] controls;

	//---------------------------------------------------------------------------------------
	// Main Decoder
	//---------------------------------------------------------------------------------------
	always_comb
		case(Op)
			//Data Processing Instructions
			2'b00:
				//(I) Funct[6] = 0 -> DP Reg
				//(I) Funct[6] = 1 -> DP Imm
				if (Funct[6]==1)
				begin
					controls = 8'b01001001;
				end
				else
					controls = 8'b01000001;
			//Memory Instructions
			2'b01:
				//(L) Funct[6] = 0 -> STR
				//(L) Funct[6] = 1 -> LDR
				if (Funct[6]==1)
				begin
					controls = 8'b01011010;
				end
				else
					controls = 8'b0010110;
			//Branch Instructions
			2'b10:
				//B
				controls = 8'b10001100;
			default:
				//Unimplemented
				controls = 8'bx;
		endcase	

	assign {Branch, RegSW, MemW, MemtoReg, ALUSrc, ImmSrc, ALUOp} = controls;
	
	assign RegVW = Funct[6];

	//---------------------------------------------------------------------------------------
	// ALU Decoder
	//---------------------------------------------------------------------------------------
	always_comb
		if (ALUOp)begin
			case(Funct[2:0]) //(cmd)
				3'b000: ALUControl = 2'b00;		//ADD
				3'b001: ALUControl = 2'b01;		//SUB
				3'b010: ALUControl = 2'b10;		//AND
				3'b011: ALUControl = 2'b11;		//LSR
				3'b100: ALUControl = 2'b01; 	//CMP
				3'b110: ALUControl = 2'b00; 	//ADDV
				3'b111: ALUControl = 2'b01;		//MULV
				default: ALUControl = 4'bx;		//Unimplemented
			endcase
			FlagW[1] = Funct[0];
			FlagW[0] = Funct[0] & (ALUControl == 4'b0000 | ALUControl == 4'b0001 | ALUControl == 4'b0011 |  ALUControl == 4'b0100 | ALUControl == 4'b1000);
			NoWrite  = Funct[0] & (Funct[4:1] == 4'b0100);
		end
		else begin
			ALUControl = 2'b00;
			FlagW = 2'b00;
			NoWrite = 1'b0;
		end

	assign Pass = Funct[4:1] == 4b'1000;

	//---------------------------------------------------------------------------------------
	// PC Logic
	//---------------------------------------------------------------------------------------
	assign PCS = ((Rd == 4'b1111) & RegW) | Branch;

endmodule
