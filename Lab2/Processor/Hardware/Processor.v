module Processor(

	// input Clock, Reset, Enter, Enable,
	// input [7:0]Input,
	
	// output Halt,
	// output [7:0]Output
  
   input Clock,
   input [9:0]SW,
   input [3:0]KEY,
   output [9:0]LEDR,
   output [7:0]LEDG    
);
	
	wire Reset;
	wire Enter, Enable, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Aeq0, Apos, Halt;
	wire [1:0]Asel;
    wire [7:0]Input, Output;
	wire [7:5]IR;

  assign Input = SW[7:0];
  assign Reset = ~KEY[0];
  assign Enable = ~KEY[1];
  assign Enter = ~KEY[2];
  assign LEDR[7:0] = Input;
  assign LEDR[8] = Enter;
  assign LEDR[9] = Halt;
  assign LEDG = Output;
  
  ClkDiv clk (Clock, Clk_1hz);
  
	ControlUnit CU (.Clock(Clk_1hz), .Reset(Reset), .Enter(Enter), .IR(IR), . Aeq0(Aeq0), .Apos(Apos), .IRload(IRload), .JMPmux(JMPmux), .PCload(PCload), .Meminst(Meminst), .MemWr(MemWr), .Asel(Asel), .Aload(Aload), .Sub(Sub), .Halt(Halt));
	
	Datapath 	DP (.Clock(Clk_1hz), .Reset(Reset), .Enable(Enable), .IRload(IRload), .JMPmux(JMPmux), .PCload(PCload), .Meminst(Meminst), .MemWr(MemWr), .Aload(Aload), .Sub(Sub), .Asel(Asel), .Input(Input), .Aeq0(Aeq0), .Apos(Apos), .IR(IR), .Output(Output));
	
endmodule 