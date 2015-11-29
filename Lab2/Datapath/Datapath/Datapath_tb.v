module Datapath_tb();

	reg Clock, Reset, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub;
	reg [1:0]Asel;
	reg [7:0]Input;
	
	wire Aeq0, Apos;
	wire [7:5]IR;
	wire [7:0]Output;
	
initial
begin

end

always #1 Clock=~Clock;

Datapath DP (Clock, Reset, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Asel, Input, Aeq0, Apos, IR, Output);

endmodule 