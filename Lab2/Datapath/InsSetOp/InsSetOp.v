module InsSetOp(
	input Clock, Reset, Aload, sub,
	input [1:0]Asel,
	input [7:0]Input, outputRam,
	output [7:0]outputA, Aeq0, outputAddSub,
	output Apos	
);

	wire [7:0]outputMux3_1, outputMux3_2, outputMux3, inputA;
	
	assign outputMux3 = outputMux3_1 | outputMux3_2;
	assign Aeq0=~(outputA[0] | outputA[1] | outputA[2] | outputA[3] | outputA[4] | outputA[5] | outputA[6] | outputA[7]);
	assign Apos=outputA[7];
	
	Multiplexer #(.width(8), .sel(1)) mux3_2 (.iDat1(0), .iDat0(outputRam), .load(Asel[1]), .oDat(outputMux3_2));
	Multiplexer #(.width(8), .sel(1)) mux3_1 (.iDat1(Input), .iDat0(outputAddSub), .load(Asel[0]), .oDat(outputMux3_1));
	Register #(.width(8)) A_reg (.Clock(Clock), .Clear(Reset), .Load(Aload), .Input(outputMux3), .Output(outputA));
	AddSub #(.width(8)) AS (.sub(sub), .iDat1(outputA), .iDat2(outputRam), .oDat(outputAddSub));

endmodule 