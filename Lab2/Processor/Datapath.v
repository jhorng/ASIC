module Datapath(
	input Clock, Reset, Enable, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub,
	input [1:0]Asel, 
	input [7:0]Input,
	output Aeq0, Apos,
	output [7:5]IR,
	output [7:0]Output
);
	
	wire [4:0]outputMux2;
	wire [7:0]outputRam, outputAddSub;
	
	InsCycOp  ICO (.Clock(Clock), .Reset(Reset), .IRload(IRload), .JMPmux(JMPmux), .PCload(PCload), .Meminst(Meminst),
				   .inputIR(outputRam), .IR(IR), .outputMux2(outputMux2));
	// MemoryRam RAM (.Clock(Clock), .WE(MemWr), .memAddr(outputMux2), .iDat(Output), .oDat(outputRam));
  InitRam modifiedRam (.Clock(Clock), .WE(MemWr), .Enable(Enable), .Address(outputMux2), .D(Output), .Q(outputRam));
	InsSetOp  ISO (.Clock(Clock), .Reset(Reset), .Aload(Aload), .Sub(Sub), .Asel(Asel), .Input(Input), 
				   .outputRam(outputRam), .outputA(Output), .Aeq0(Aeq0), .Apos(Apos));
	
endmodule 