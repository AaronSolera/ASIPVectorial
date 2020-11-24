module controller(input logic clk, reset,
                  input logic [31:12] InstrD,
                  input logic [3:0] ALUFlagsE, 

                  //Memory Unit
                  output logic [1:0] RegSrcD, ImmSrcD,  // ??
                  output logic       BranchTakenE,      // ??
  
                  //Execution Stage
                  output logic       ALUSrcE,
                  output logic [1:0] ALUControlE, 
                  output logic       PassE,
                  //Memory Stage
                  output logic       MemWriteM, 
                  //Write Back Stage
                  output logic       MemtoRegW, PCSrcW, RegSWriteW, RegVWriteW, 

                  // Hazard interface 
                  output logic RegWriteM, MemtoRegE, 
                  output logic PCWrPendingF, 
                  input logic  FlushE);

//logic [9:0] controlsD; 
logic [7:0] controlsD;

logic CondExE, ALUOpD; 
logic [1:0] ALUControlD; 
logic ALUSrcD;

logic MemtoRegD, MemtoRegM; 
//logic RegWriteD, 
logic RegWriteE, RegWriteGatedE; 
logic MemWriteD, MemWriteE, MemWriteGatedE; 
logic BranchD, BranchE; 
logic [1:0] FlagWriteD, FlagWriteE; 
logic PCSrcD, PCSrcE, PCSrcM; 
logic [3:0] FlagsE, FlagsNextE, CondE;

logic NoWriteE, RegSwriteD, RegVWriteD;

//---------------------------------------------------------------------------------------
// Main Decoder
//---------------------------------------------------------------------------------------
logic [1:0] Op    = InstrD[27:26];
logic [7:0] Funct = InstrD[21:14];
logic [3:0] Rd    = InstrD[13:10];


  always_comb
    case(Op)
      //Data Processing Instructions
      2'b00:
        //(I) Funct[6] = 0 -> DP Reg
        //(I) Funct[6] = 1 -> DP Imm
        if (Funct[6] == 1)
        begin
          controls = 8'b01001001;
        end
        else
          controls = 8'b01000001;
      //Memory Instructions
      2'b01:
        //(L) Funct[6] = 0 -> STR
        //(L) Funct[6] = 1 -> LDR
        if (Funct[6] == 1)
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

//assign {RegSrcD, ImmSrcD, ALUSrcD, MemtoRegD, RegWriteD, MemWriteD, BranchD, ALUOpD} = controlsD;

assign {BranchD, RegSWriteD, MemWriteD, MemtoRegD, ALUSrcD, ImmSrcD, ALUOpD} = controlsD;
assign RegVWriteD = Funct[6];

//---------------------------------------------------------------------------------------
// ALU Decoder
//---------------------------------------------------------------------------------------

  always_comb
    if (ALUOpD) begin
      case(Funct[2:0]) //(cmd)
        3'b000: ALUControlD = 2'b00;   //ADD
        3'b001: ALUControlD = 2'b01;   //SUB
        3'b010: ALUControlD = 2'b10;   //AND
        3'b011: ALUControlD = 2'b11;   //LSR
        3'b100: ALUControlD = 2'b01;   //CMP
        3'b110: ALUControlD = 2'b00;   //ADDV
        3'b111: ALUControlD = 2'b01;   //MULV
        default: ALUControlD = 4'bx;   //Unimplemented
      endcase
      FlagWriteD[1] = Funct[0];
      FlagWriteD[0] = Funct[0] & (ALUControlD == 4'b0000 | ALUControlD == 4'b0001 | ALUControlD == 4'b0011 |  ALUControlD == 4'b0100 | ALUControlD == 4'b1000);
      NoWriteE      = Funct[0] & (Funct[4:1] == 4'b0100);
    end
    else begin
      ALUControlD = 2'b00;
      FlagWriteD  = 2'b00;
      NoWriteE    = 1'b0;
    end

  assign PassE = Funct[4:1] == 4'b1000;

//---------------------------------------------------------------------------------------
// PC Logic
//---------------------------------------------------------------------------------------   
assign PCSrcD       = (((InstrD[15:12] == 4'b1111) & RegWriteD) | BranchD);

//---------------------------------------------------------------------------------------

// Execute stage   

floprc #(7) flushedregsE(clk, reset, FlushE,                             
                        {FlagWriteD, BranchD, MemWriteD, RegWriteD, 
                        PCSrcD,MemtoRegD},
                        {FlagWriteE, BranchE, MemWriteE, RegWriteE, PCSrcE, MemtoRegE});   

flopr #(3)  regsE(clk, reset,
                 {ALUSrcD, ALUControlD},
                 {ALUSrcE, ALUControlE});

flopr  #(4) condregE(clk, reset, InstrD[31:28], CondE);   
flopr  #(4) flagsreg(clk, reset, FlagsNextE, FlagsE);   
// write and Branch controls are conditional

conditional Cond(CondE, FlagsE, ALUFlagsE, FlagWriteE, CondExE, FlagsNextE);   

assign BranchTakenE    = BranchE & CondExE;   
assign RegWriteGatedE  = RegWriteE & CondExE;   
assign MemWriteGatedE  = MemWriteE & CondExE;   
assign PCSrcGatedE     = PCSrcE & CondExE;   

// Memory stage   
flopr #(4) regsM(clk, reset,                    
                {MemWriteGatedE, MemtoRegE, RegWriteGatedE, PCSrcGatedE},                    
                {MemWriteM, MemtoRegM, RegWriteM, PCSrcM});   
                

// Writeback stage   
flopr #(3) regsW(clk, reset,                    
                {MemtoRegM, RegWriteM, PCSrcM},
                {MemtoRegW, RegWriteW, PCSrcW});  
                
// Hazard Prediction   
assign PCWrPendingF = PCSrcD | PCSrcE | PCSrcM; 

endmodule
