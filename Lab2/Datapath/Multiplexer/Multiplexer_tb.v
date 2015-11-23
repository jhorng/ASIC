module Multiplexer_tb();

	reg [4:0]iDat1, iDat0;
	reg load;
	wire [4:0]oDat;

	initial
	begin
		iDat1 = {$random}%32;
		iDat0 = {$random}%32;
		load=1;
		#2 load=0;
		#2 load=1;
	end
	
	always@(oDat)
	begin
	  $display("load=%d", load);
	  $display("iDat1=%b, iDat0=%b, oDat=%b", iDat1, iDat0, oDat);
	end
	
Multiplexer #(.width(5), .sel(1)) mux2_1 (iDat1, iDat0, load, oDat);
	
endmodule
