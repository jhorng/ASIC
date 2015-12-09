module Datapath_tb();

    reg Clock, Reset, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub;
    reg [1:0]Asel;
    reg [7:0]Input;
    
    wire Aeq0, Apos;
    wire [7:5]IR;
    wire [7:0]Output, outputRam;
    wire [4:0]IR4_0, outputPC;
	
    integer i, j;

initial
begin
Clock=0;
Reset=1;
#2 Reset=0;
#2 start();
#2 fetch();
#2 decode();
#2 Input={$random}%256;
$display("value iDat!");
#2 load();
#2 inputState();
#2 writeMemory();
// #2 {IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub} = 7'b1111010;
#2 oneTimeReset();
$display("Reset address!");
#2 readMemory();
#4 add();
#10 sub();
#10 IRload=1; Sub=0; Input={$random}%256; Asel=2'b01; Aload=1;
$display("Initialize jump condition! - jz1");
#2 jz();
#10 IRload=1; Sub=0; Input=0; Asel=2'b01; Aload=1;
$display("Initialize jump condition! - jz2");
#2 jz();
#2 oneTimeReset();
$display("Reset address!");
#2 readMemory();
#4 IRload=1; Sub=0; Input=0; Asel=2'b01; Aload=1;
$display("Initialize jump condition! - jpos1");
#2 jpos();
#10 IRload=1; Sub=0; Input=8'b11111001; Asel=2'b01; Aload=1;
$display("Initialize jump condition! - jpos2");
#2 jpos();
//#2 fetch();
//#2 decode();
#10 $finish;
end

initial
begin
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
$monitor("	%b	%b	%b	%b	%b	%b	%b	%b	%b   %b   %b 	   %b 	   %b      %b      %b       %b %t", IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Asel, Input, Output, outputRam, IR, IR4_0, outputPC, Aeq0, Apos, $time);
end


task writeMemory;
begin
$display("Write data into memory!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
	for(i=0; i<3; i=i+1)
	begin
		#2 PCload=1;
		IRload=1;
		JMPmux=0;
		Meminst=0;
		MemWr=1;
		Asel = 2'b01;
		Aload = 1;
		Input={$random}%256;
	end
	// MemWr=0;
	// Aload=1;
end
endtask

task readMemory;
begin
$display("Retrieve value from RAM!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
  for(j=0; j<3; j=j+1)
  begin
    // #2 {IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub} = 7'b1010010;
    #2 PCload=1;
		IRload=1;
		JMPmux=0;
		Meminst=0;
		MemWr=0;
		Asel = 2'b10;
		Aload = 1;
  end
end
endtask

task oneTimeReset();
begin
$display("Clear register!");
  #2 Reset=1;
	IRload=0;
	JMPmux=0;
	PCload=0;
	Meminst=0;
	MemWr=0;
	Aload=0;
	Sub=0;
	Asel=0;
  #4 Reset=0;
end
endtask

task start;
begin
$display("Start!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=0;
PCload=0;
Meminst=0;
MemWr=0;
Aload=0;
Sub=0;
Asel=0;
end
endtask

task fetch;
begin
$display("Fetch!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=1;
JMPmux=0;
PCload=1;
Meminst=0;
MemWr=0;
Aload=0;
Sub=0;
Asel=0;
end
endtask

task decode;
begin
$display("Decode!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=0;
PCload=0;
Meminst=1;
MemWr=0;
Aload=0;
Sub=0;
Asel=0;
end
endtask

task load;
begin
$display("Load!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=0;
PCload=0;
Meminst=0;
MemWr=0;
Aload=1;
Sub=0;
Asel=2'b10;
end
endtask

task store;
begin
$display("Store!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=0;
PCload=0;
Meminst=1;
MemWr=1;
Aload=0;
Sub=0;
Asel=0;
end
endtask

task add;
begin
$display("Add!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=0;
PCload=0;
Meminst=0;
MemWr=0;
Aload=1;
Sub=0;
Asel=0;
end
endtask

task sub;
begin
$display("Sub!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=0;
PCload=0;
Meminst=0;
MemWr=0;
Aload=1;
Sub=1;
Asel=0;
end
endtask

task inputState;
begin
$display("Input!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=0;
PCload=0;
Meminst=0;
MemWr=0;
Aload=1;
Sub=0;
Asel=2'b01;
Input={$random}%256;
end
endtask

task jz;
begin
$display("Jump if zero!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=1;
PCload=Aeq0;
Meminst=0;
MemWr=0;
Aload=0;
Sub=0;
Asel=0;
end
endtask

task jpos;
begin
$display("Jump if positive!");
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  |   IR   |  IR4_0  |  outputPC | Aeq0 | Apos | time");
IRload=0;
JMPmux=1;
PCload=Apos;
Meminst=0;
MemWr=0;
Aload=0;
Sub=0;
Asel=0;
end
endtask

always #1 Clock=~Clock;

Datapath DP (Clock, Reset, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Asel, Input, Aeq0, Apos, IR, Output, outputRam, IR4_0, outputPC);

endmodule 