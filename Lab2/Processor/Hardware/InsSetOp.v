module InsSetOp(
	input Clock, Reset, Aload, Sub,
	input [1:0]Asel,
	input [7:0]Input, outputRam,
	output [7:0]outputA,
	output Aeq0, Apos	
);

	wire [7:0]outputMux3_1, outputMux3_2, outputMux3, inputA, outputAddSub;
	
	assign Aeq0=~(outputA[0] | outputA[1] | outputA[2] | outputA[3] | outputA[4] | outputA[5] | outputA[6] | outputA[7]);
	assign Apos=~outputA[7];
	
	Multiplexer #(.width(8), .sel(1)) mux3_2 (.iDat1(8'b00000000), .iDat0(outputRam), .load(Asel[0]), .oDat(outputMux3_2));
	Multiplexer #(.width(8), .sel(1)) mux3_1 (.iDat1(Input), .iDat0(outputAddSub), .load(Asel[0]), .oDat(outputMux3_1));
	Multiplexer #(.width(8), .sel(1)) mux3 (.iDat1(outputMux3_2), .iDat0(outputMux3_1), .load(Asel[1]), .oDat(outputMux3));
	Register #(.width(8)) A_reg (.Clock(Clock), .Clear(Reset), .Load(Aload), .Input(outputMux3), .Output(outputA));
	AddSub #(.width(8)) AS (.Sub(Sub), .iDat1(outputA), .iDat2(outputRam), .oDat(outputAddSub));

endmodule 