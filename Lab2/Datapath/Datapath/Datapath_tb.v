module Datapath_tb();

    reg Clock, Reset, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub;
    reg [1:0]Asel;
    reg [7:0]Input;
    
    wire Aeq0, Apos;
    wire [7:5]IR;
    wire [7:0]Output, outputRam;
    
    integer i;

initial
begin
Clock=0;
Reset=1;
#2 Reset=0;
#2 writeMemory();
#2 start();
#2 fetch();
#2 decode();
#2 oneTimeReset();
#2 load();
// #2 add();
// #2 sub();
// #2 inputState();
// #2 jz();
// #2 jpos();
#100 $finish;
end

initial
begin
$display("IRload | JMPmux | PCload | Meminst | MemWr | Aload | Sub |   Asel   |   Input  |  Output  |  outRam  | time");
$monitor("	%b	%b	%b	%b	%b	%b	%b	%b	%b   %b  %b %t", IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Asel, Input, Output, outputRam, $time);
end


task writeMemory;
begin
	for(i=0; i<10; i=i+1)
	begin
		#2 Asel = 2'b01;
       Aload = 1;
       Input={$random}%256;
		#2 store();
	end
end
endtask

task oneTimeReset();
begin
  #2 Reset=1;
  #4 Reset=0;
end
endtask

task start;
begin
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

Datapath DP (Clock, Reset, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Asel, Input, Aeq0, Apos, IR, Output, outputRam);

endmodule 