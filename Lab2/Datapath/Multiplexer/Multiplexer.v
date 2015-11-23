module Multiplexer #(parameter width = 5, parameter sel = 1)(
	input [width-1:0]iDat1, iDat0,
	input [sel-1:0]load,
	output [width-1:0]oDat
);

	assign oDat = load ? iDat1 : iDat0;
	
endmodule
