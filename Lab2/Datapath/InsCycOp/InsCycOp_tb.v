module InsCycOp_tb();

	reg Clock, Reset, IRload, JMPmux, PCload, Meminst;
	reg [7:0]inputIR;
	
	wire [7:5]IR;
	wire [7:0]outputIR;
	wire [4:0]outputMux2;
	
	integer i, j;
	
initial
begin
	Clock=0;
	Reset=1;
	IRload=0;
	JMPmux=0;
	PCload=0;
	Meminst=0;
	inputIR={$random}%256;
	#2 Reset=0;
	for (i=1; i>0; i=i-1)
	begin
		#2 IRload=i;
			PCload=i;
		for (j=1; j>0; j=j-1)
		begin
			#2 JMPmux=j;
				Meminst=j;
		end
	end
	#50 $finish;
end

initial
begin
	$display("inputIR | IRload | JMPmux | PCload | Meminst | IR | outputMux2 | outputIR");
	$monitor("%b    %b       %b       %b        %b       %b    %b      %b", inputIR, IRload, JMPmux, PCload, Meminst, IR, outputMux2, outputIR);
end

always #1 Clock=~Clock;

InsCycOp Part1 (Clock, Reset, IRload, JMPmux, PCload, Meminst, inputIR, IR, outputIR, outputMux2);

endmodule 