module ControlUnit_tb();
	
	reg Clock, Reset, Enter;
	reg [7:5]IR;
	reg Aeq0, Apos;

	wire IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt;
	wire [1:0]Asel;
	wire [3:0]state, nstate;
	
initial 
begin
Clock=0;
Reset=0;
Aeq0=0;
Apos=0;
Enter=0;
IR=0;
#2 Reset=1;
#2 Enter=0;
#2 IR=0;
#8 IR=3'b001;
#8 IR=3'b010;
#8 IR=3'b011;
   Enter=1;
#8 IR=3'b101;
#8 IR=3'b110;
#8 IR=3'b100;
   Aeq0=1;
#8 IR=3'b101;
   Apos=1;
#8 IR=3'b110;
#8 IR=3'b111;
   Aeq0=0;
   Apos=0;
#100 $finish; 
end

always #1 Clock=~Clock;

CU CUtb(Clock, Reset, Enter, IR, Aeq0, Apos, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt, Asel, state, nstate);
endmodule 