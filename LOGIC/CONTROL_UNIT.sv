module CONTROL_UNIT (FUNCT, OP, REG_UPDATE, REG_S_WRITE, REG_V_WRITE, ALU_S_SRC, 
							ALU_V_SRC, ALU_CONTROL, ALU_S_PASS, ALU_V_PASS, ALU_RESULT_SRC, 
							MEM_SRC, MEM_WRITE, MEM_S, MEM_E, MEM_TO_REG, NO_REG_WRITE, BRANCH); 
	
	input  [6:0] FUNCT;
	input  [1:0] OP;
	output [1:0] ALU_CONTROL;
	output 		 REG_UPDATE, REG_S_WRITE, REG_V_WRITE, ALU_S_SRC, ALU_V_SRC, ALU_S_PASS, ALU_V_PASS, ALU_RESULT_SRC, MEM_SRC, MEM_WRITE, MEM_S, MEM_E, MEM_TO_REG, NO_REG_WRITE, BRANCH;

	logic        W_REG_UPDATE, W_NO_REG_WRITE;
	logic  [7:0] CONTROL;
	
	//---------------------------------------------------------------------------------------
	// Main Decoder
	//---------------------------------------------------------------------------------------

	assign W_REG_UPDATE   = ((OP == 2'b01) && FUNCT[4]);
	assign MEM_S          = ((OP == 2'b01) && FUNCT[2]);
	assign MEM_E          = ((OP == 2'b01) && FUNCT[1]);
	assign W_NO_REG_WRITE = ((OP == 2'b00) && (FUNCT[2:0] == 3'b101));
	assign REG_S_WRITE    = (~(FUNCT[5] || FUNCT[6]) || (OP == 2'b01 && FUNCT[5] || FUNCT[6] && W_REG_UPDATE)) && ~W_NO_REG_WRITE;
	assign ALU_S_PASS     = (OP == 2'b00 && FUNCT[2:0] == 3'b100 && ~FUNCT[5]) || (OP == 2'b10);
	assign ALU_V_PASS     = (OP == 2'b00 && FUNCT[2:0] == 3'b100 &&  FUNCT[5]) || (OP == 2'b01 && FUNCT[3]);

	assign REG_UPDATE   = W_REG_UPDATE;
	assign NO_REG_WRITE = W_NO_REG_WRITE;

	always_comb
		case(OP)
		//---------------------------------------------------------------------------------
		// Data Processing Instruction
		//---------------------------------------------------------------------------------
		2'b00:
			// VCTR = FUNCT[6:5]
			// I = FUNCT[4]
			//-------------------------------------------------------------------------------
			// Scalar - Scalar
			//-------------------------------------------------------------------------------
			if (FUNCT[6:5] == 2'b00) 
			begin
			 // DP Reg
			 if (FUNCT[4] == 1'b0)
				CONTROL = 8'b00000000;
			 // DP Imm
			 else
				CONTROL = 8'b00100000;
			end 
			//-------------------------------------------------------------------------------
			// Vector - Vector
			//-------------------------------------------------------------------------------
			else if (FUNCT[6:5] == 2'b11)
			begin
			 CONTROL = 8'b01011000;
			end
			//-------------------------------------------------------------------------------
			// Vector - Scalar
			//-------------------------------------------------------------------------------
			else 
			begin
			 CONTROL = 8'b01001000;
			end
		//---------------------------------------------------------------------------------
		// Memory Instruction
		//---------------------------------------------------------------------------------
		2'b01:
			// VCTR = FUNCT[6:5]
			// L = FUNCT[3]
			//-------------------------------------------------------------------------------
			// Scalar
			//-------------------------------------------------------------------------------
			if (FUNCT[6:5] == 2'b00)
			begin
			 // LDR
			 if (FUNCT[3] == 1'b1)
				CONTROL = 8'b00100111;
			 // STR
			 else
				CONTROL = 8'b00100110;
			end
			//-------------------------------------------------------------------------------
			// Vector
			//-------------------------------------------------------------------------------
			else
			begin
			 // LDRV
			 if (FUNCT[3] == 1'b1)
				CONTROL = 8'b01101011;
			 // STRV
			 else
			 begin
				CONTROL = 8'b01101010;
			 end
			end
		//---------------------------------------------------------------------------------
		// Branch Instruction
		//---------------------------------------------------------------------------------
		2'b10:
			//B
			CONTROL = 8'b10100000;
		//---------------------------------------------------------------------------------
		// Unimplemented
		//---------------------------------------------------------------------------------
		default:
			CONTROL = 8'd0;
	endcase 

	assign {BRANCH, REG_V_WRITE, ALU_S_SRC, ALU_V_SRC, ALU_RESULT_SRC, MEM_SRC, MEM_WRITE, MEM_TO_REG} = CONTROL;

	//---------------------------------------------------------------------------------------
	// ALU Decoder
	//---------------------------------------------------------------------------------------

	assign ALU_CONTROL = FUNCT[1:0];
	
	/*
	always_comb begin
		case(FUNCT[2:0]) //(cmd)
		  3'b000:  ALU_CONTROL = 2'b00;  //ADD
		  3'b001:  ALU_CONTROL = 2'b01;  //SUB
		  3'b010:  ALU_CONTROL = 2'b10;  //MUL
		  3'b011:  ALU_CONTROL = 2'b11;  //DIV
		  3'b101:  ALU_CONTROL = 2'b01;  //CMP
		  default: ALU_CONTROL = 2'b00;  //Unimplemented
		endcase
	end
	*/

endmodule 