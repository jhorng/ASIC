module InsCycOp(
	input Clock, Reset, IRload, JMPmux, PCload, Meminst,
	input [7:0]inputIR,
	output [7:5]IR,
	//output [7:0]outputIR,
	output [4:0]outputMux2
);
	
	wire [4:0]IR4_0, outputPC, outputMux1, outputIncr;
	// wire [4:0]outputMux1, outputIncr;
	wire [7:0]outputIR;
	
	assign IR4_0 = outputIR[4:0];
	assign IR = outputIR[7:5];
	
	Register #(.width(8)) IR_reg (.Clock(Clock), .Clear(Reset), .Load(IRload), .Input(inputIR), .Output(outputIR));
	Multiplexer #(.width(5), .sel(1)) mux1 (.iDat1(IR4_0), .iDat0(outputIncr), .load(JMPmux), .oDat(outputMux1));
	Increment #(.width(5)) Incr (.iDat(outputPC), .oDat(outputIncr));
	Register #(.width(5)) PC_reg (.Clock(Clock), .Clear(Reset), .Load(PCload), .Input(outputMux1), .Output(outputPC));
	Multiplexer #(.width(5), .sel(1)) mux2 (.iDat1(IR4_0), .iDat0(outputPC), .load(Meminst), .oDat(outputMux2));
	
endmodule 