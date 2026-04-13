module DSP (D,A,B,BCIN,C,PCIN,carryin, clk , CEA , CEB , CED , CEC , CECARRYIN , CEM , CEOPMODE , CEP , RSTA , RSTB , RSTC , RSTD ,
	        RSTCARRYIN , RSTM , RSTOPMODE , RSTP , opmode,M,BCOUT,carryout , carryoutf ,PCOUT,P) ;
input [11:0] D ;	
input [17:0] A , B , BCIN ;
input [47:0] C , PCIN ;
input carryin , clk , CEA , CEB , CED , CEC , CECARRYIN , CEM , CEOPMODE , CEP , RSTA , RSTB , RSTC , RSTD ;
input RSTCARRYIN , RSTM , RSTOPMODE , RSTP ; 
input [7:0] opmode ;
output [35:0] M ;
output [17:0] BCOUT ;
output carryout , carryoutf ;
output [47:0] PCOUT , P  ;

localparam CARRYIN   = 0 ;
localparam OPMODES   = 1 ;
localparam DIRECT    = 0 ;
localparam CASCADE   = 1 ;
localparam SYNC      = 0 ;
localparam ASYNC     = 1 ;
parameter A0REG      = 0 ;
parameter B0REG      = 0 ;
parameter A1REG      = 1 ;
parameter B1REG      = 1 ;
parameter CREG       = 1 ;
parameter DREG       = 1 ;
parameter MREG       = 1 ;
parameter PREG       = 1 ;
parameter CARRYINREG = 1 ;
parameter CARRYOUTREG= 1 ;
parameter OPMODEREG  = 1 ; 
parameter CARRYINSEL = OPMODES ;
parameter B_INPUT    = DIRECT  ;
parameter RSTTYPE    = SYNC    ;

wire [17:0] PRE , mux_PRE ;
wire [11:0] mux_D ;
wire [17:0] mux_A , mux_BIN , mux_B  , mux_A1 , mux_B1  ;
wire [47:0] mux_C  ;
wire [47:0] POST ;  
reg [47:0] X , Z ; 
wire [1:0] mux_OP_10 , mux_OP_32 ;
wire  mux_OP_4 , mux_OP_5 , mux_OP_6 , mux_OP_7 , mux_CIN , CIN , POST_COUT ;
wire [35:0] MULT , mux_M ;

assign mux_BIN = (B_INPUT==DIRECT)? B : BCIN ;

inst  #(.w(12),.INREG(DREG),.RSTTYPE(RSTTYPE)) DI (.clk(clk),.rst(RSTD),.CE(CED),.in(D),.mux_in(mux_D)) ;
inst  #(.w(18),.INREG(B0REG),.RSTTYPE(RSTTYPE)) BI (.clk(clk),.rst(RSTB),.CE(CEB),.in(mux_BIN),.mux_in(mux_B)) ;
inst  #(.w(18),.INREG(A0REG),.RSTTYPE(RSTTYPE)) AI (.clk(clk),.rst(RSTA),.CE(CEA),.in(A),.mux_in(mux_A)) ;
inst  #(.w(48),.INREG(CREG),.RSTTYPE(RSTTYPE)) CI (.clk(clk),.rst(RSTC),.CE(CEC),.in(C),.mux_in(mux_C)) ;

inst  #(.w(2),.INREG(OPMODEREG),.RSTTYPE(RSTTYPE)) op_01 (.clk(clk),.rst(RSTOPMODE),.CE(CEOPMODE),.in(opmode[1:0]),.mux_in(mux_OP_10)) ;
inst  #(.w(2),.INREG(OPMODEREG),.RSTTYPE(RSTTYPE)) op_32 (.clk(clk),.rst(RSTOPMODE),.CE(CEOPMODE),.in(opmode[3:2]),.mux_in(mux_OP_32)) ;
inst  #(.w(1),.INREG(OPMODEREG),.RSTTYPE(RSTTYPE)) op_4  (.clk(clk),.rst(RSTOPMODE),.CE(CEOPMODE),.in(opmode[4])  ,.mux_in(mux_OP_4))  ;
inst  #(.w(1),.INREG(OPMODEREG),.RSTTYPE(RSTTYPE)) op_5  (.clk(clk),.rst(RSTOPMODE),.CE(CEOPMODE),.in(opmode[5])  ,.mux_in(mux_OP_5))  ;
inst  #(.w(1),.INREG(OPMODEREG),.RSTTYPE(RSTTYPE)) op_6  (.clk(clk),.rst(RSTOPMODE),.CE(CEOPMODE),.in(opmode[6])  ,.mux_in(mux_OP_6))  ;
inst  #(.w(1),.INREG(OPMODEREG),.RSTTYPE(RSTTYPE)) op_7  (.clk(clk),.rst(RSTOPMODE),.CE(CEOPMODE),.in(opmode[7])  ,.mux_in(mux_OP_7))  ;

assign PRE = (mux_OP_6)? {6'b0 , mux_D} - mux_B : {6'b0 , mux_D} + mux_B ;
assign mux_PRE = (mux_OP_4)? PRE : mux_B ;

inst  #(.w(18),.INREG(B1REG),.RSTTYPE(RSTTYPE)) BII (.clk(clk),.rst(RSTB),.CE(CEB),.in(mux_PRE),.mux_in(mux_B1)) ;
inst  #(.w(18),.INREG(A1REG),.RSTTYPE(RSTTYPE)) AII (.clk(clk),.rst(RSTA),.CE(CEA),.in(mux_A),.mux_in(mux_A1))   ;

assign MULT = mux_A1 * mux_B1 ;

inst  #(.w(36),.INREG(MREG),.RSTTYPE(RSTTYPE)) MI (.clk(clk),.rst(RSTM),.CE(CEM),.in(MULT),.mux_in(mux_M)) ;
always @(*) begin
	case (mux_OP_10)
	 0 : X = 0 ;
	 1 : X = mux_M ;
	 2 : X = P ;
	 3 : X = {mux_D , mux_A1 , mux_B1} ;
	 default : X = 0 ;
	endcase
end

always @(*) begin
	case (mux_OP_32)
	 0 : Z = 0 ;
	 1 : Z = PCIN ;
	 2 : Z = P ;
	 3 : Z = mux_C ;
	 default : Z = 0 ;
	endcase
end

assign mux_CIN = (CARRYINSEL == OPMODES)? mux_OP_5 : (CARRYINSEL == CARRYIN)? carryin : 0 ;

inst  #(.w(1),.INREG(CARRYINREG),.RSTTYPE(RSTTYPE)) CRI (.clk(clk),.rst(RSTCARRYIN),.CE(CECARRYIN),.in(mux_CIN),.mux_in(CIN)) ;
assign { POST_COUT , POST } = (mux_OP_7)? Z-(X+CIN) : Z + X + CIN ;

inst  #(.w(1),.INREG(CARRYOUTREG),.RSTTYPE(RSTTYPE)) COI (.clk(clk),.rst(RSTCARRYIN),.CE(CECARRYIN),.in(POST_COUT),.mux_in(carryout)) ;
inst  #(.w(48),.INREG(PREG),.RSTTYPE(RSTTYPE)) PI (.clk(clk),.rst(RSTP),.CE(CEP),.in(POST),.mux_in(P)) ;

assign BCOUT = mux_B1 ;
assign M = mux_M ;
assign carryoutf = carryout ;
assign PCOUT = P  ;
endmodule