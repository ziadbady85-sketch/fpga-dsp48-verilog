module DSP_tb();
reg [11:0] D ;
reg [17:0] A , B , BCIN ;
reg [47:0] C , PCIN ;
reg carryin , clk , CEA , CEB , CED , CEC , CECARRYIN , CEM , CEOPMODE , CEP , RSTA , RSTB , RSTC , RSTD ;
reg RSTCARRYIN , RSTM , RSTOPMODE , RSTP ; 
reg [7:0] opmode ;
wire [35:0] M ;
wire [17:0] BCOUT ;
wire carryout , carryoutf ;
wire [47:0] PCOUT , P ;
reg [35:0] M_sf ;
reg [17:0] BCOUT_sf ;
reg carryout_sf , carryoutf_sf ;
reg [47:0] PCOUT_sf , P_sf ;
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

DSP #(.A0REG(A0REG),.B0REG(B0REG),.A1REG(A1REG),.CREG(CREG),.DREG(DREG),.MREG(MREG),.PREG(PREG),.CARRYINREG(CARRYINREG),.CARRYOUTREG(CARRYOUTREG),
	  .OPMODEREG(OPMODEREG),.CARRYINSEL(CARRYINSEL),.B_INPUT(B_INPUT),.RSTTYPE(RSTTYPE)) 
 DUT (.D(D),.A(A),.B(B),.C(C),.BCIN(BCIN),.PCIN(PCIN),.carryin(carryin) ,.clk(clk),.CEA(CEA),.CEB(CEB),
      .CED(CED),.CEC(CEC),.CECARRYIN(CECARRYIN),.CEM(CEM),.CEOPMODE(CEOPMODE),.CEP(CEP),.RSTA(RSTA),.RSTB(RSTB),
      .RSTC(RSTC),.RSTD(RSTD),.RSTCARRYIN(RSTCARRYIN),.RSTM(RSTM),.RSTOPMODE(RSTOPMODE),.RSTP(RSTP),.opmode(opmode),
      .M(M),.BCOUT(BCOUT),.carryout(carryout),.carryoutf(carryoutf),.PCOUT(PCOUT),.P(P)) ;

initial begin
	clk=0;
	forever #1 clk=~clk ;
end

initial begin
	RSTA=1 ;
	RSTB=1 ;
	RSTC=1 ;
	RSTD=1 ;
    RSTCARRYIN=1 ;
    RSTM=1 ;
    RSTOPMODE=1 ;
    RSTP=1 ;
    CEA=1 ;
    CEB=1 ;
    CED=1 ;
    CEC=1 ;
    CECARRYIN=1 ;
    CEM=1 ;
    CEOPMODE=1 ;
    CEP=1 ;

    A=$ranodm ;
    B=$ranodm ;
    C=$ranodm ;
    D=$ranodm ;
    BCIN=$ranodm ;
    PCIN=$ranodm ;
    carryin=$ranodm ;
    opmode=$ranodm ;
    @(negedge clk) ;

    M_sf=0 ;
    P_sf=0 ;
    BCOUT_sf=0 ;
    PCOUT_sf=0 ;
    carryout_sf=0;
    carryoutf_sf=0 ;

    if (M_sf!=M || P_sf!=P || BCOUT_sf!=BCOUT || PCOUT_sf!=PCOUT || carryout_sf!=carryout || carryoutf_sf!=carryoutf) begin
    	$display ("ERORR") ;
    	$stop ;
    end
    
    // path 1
    RSTA=0 ;
	RSTB=0 ;
	RSTC=0 ;
	RSTD=0 ;
    RSTCARRYIN=0 ;
    RSTM=0 ;
    RSTOPMODE=0 ;
    RSTP=0 ;
    CEA=1 ;
    CEB=1 ;
    CED=1 ;
    CEC=1 ;
    CECARRYIN=1 ;
    CEM=1 ;
    CEOPMODE=1 ;
    CEP=1 ;

    A=20 ;
    B=10 ;
    C=350 ;
    D=25 ;
    BCIN=$ranodm ;
    PCIN=$ranodm ;
    carryin=$ranodm ;
    opmode=8'b11011101 ;
    repeat(4) @(negedge clk ) ;

    M_sf= 'h12c ;
    P_sf='h32 ;
    BCOUT_sf='hf ;
    PCOUT_sf='h32 ;
    carryout_sf=0;
    carryoutf_sf=0 ;

    if (M_sf!=M || P_sf!=P || BCOUT_sf!=BCOUT || PCOUT_sf!=PCOUT || carryout_sf!=carryout || carryoutf_sf!=carryoutf) begin
    	$display ("ERORR") ;
    	$stop ;
    end
    
    // path 2
    A=20 ;
    B=10 ;
    C=350 ;
    D=25 ;
    BCIN=$ranodm ;
    PCIN=$ranodm ;
    carryin=$ranodm ;
    opmode=8'b00010000 ;
    repeat(3) @(negedge clk ) ;

    M_sf= 'h2bc ;
    P_sf='h0 ;
    BCOUT_sf='h23 ;
    PCOUT_sf='h0 ;
    carryout_sf='h0;
    carryoutf_sf='h0 ;

    if (M_sf!=M || P_sf!=P || BCOUT_sf!=BCOUT || PCOUT_sf!=PCOUT || carryout_sf!=carryout || carryoutf_sf!=carryoutf) begin
    	$display ("ERORR") ;
    	$stop ;
    end
    
    // path 3
    A=20 ;
    B=10 ;
    C=350 ;
    D=25 ;
    BCIN=$ranodm ;
    PCIN=$ranodm ;
    carryin=$ranodm ;
    opmode=8'b00001010 ;
    repeat(3) @(negedge clk ) ;

    M_sf= 'hc8 ;
    P_sf='h0 ;
    BCOUT_sf='ha ;
    PCOUT_sf='h0 ;
    carryout_sf=0;
    carryoutf_sf=0 ;

    if (M_sf!=M || P_sf!=P || BCOUT_sf!=BCOUT || PCOUT_sf!=PCOUT || carryout_sf!=carryout || carryoutf_sf!=carryoutf) begin
    	$display ("ERORR") ;
    	$stop ;
    end
    
    // path 4
    A=5 ;
    B=6 ;
    C=350 ;
    D=25 ;
    BCIN=$ranodm ;
    PCIN=3000 ;
    carryin=$ranodm ;
    opmode=8'b10100111 ;
    repeat(3) @(negedge clk ) ;

    M_sf= 'h1e ;
    P_sf='hfe6fffec0bb1 ;
    BCOUT_sf='h6 ;
    PCOUT_sf='hfe6fffec0bb1 ;
    carryout_sf=1 ;
    carryoutf_sf=1 ;

    if (M_sf!=M || P_sf!=P || BCOUT_sf!=BCOUT || PCOUT_sf!=PCOUT || carryout_sf!=carryout || carryoutf_sf!=carryoutf) begin
    	$display ("ERORR") ;
    	$stop ;
    end
    $stop;
end

endmodule