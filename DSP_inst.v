module inst (in,clk,rst,CE,mux_in) ;
parameter w = 48 ;
localparam SYNC = 0 ;
localparam ASYNC= 1 ;
parameter INREG = 1 ;
parameter RSTTYPE= SYNC ;
input [w-1:0] in ;
input clk , rst , CE ;
output [w-1:0] mux_in ;

reg [w-1:0] in_r ;

generate
	if (RSTTYPE == SYNC) begin
		always @(posedge clk ) begin
			if (rst)
				in_r <= 0 ;
			else if (CE)
				in_r <= in ;
		end
		end
	else begin
		always @(posedge clk or posedge rst) begin
			if (rst)
				in_r <= 0 ;
			else if (CE)
				in_r <= in ;
		end
	end	

endgenerate

assign mux_in = (INREG)? in_r : in ;
endmodule