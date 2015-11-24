module InsSetOp_tb();

	reg Clock, Reset, Aload, sub;
	reg [1:0]Asel;
	reg [7:0]Input, outputRam;
	
	wire [7:0]outputA, outputAddSub;
	wire Aeq0, Apos;

	integer i, j;
	
initial
begin
	Clock=0;
	Input=0;
	outputRam=0;
	Aload=0;
	Reset=1;
	sub=0;
	Asel=0;
	#2 Reset=0;
		Aload=1;
	for(i=0; i<2; i=i+1)
	begin
		Input={$random}%256;
		outputRam={$random}%256;
		#2 Asel[0]=i;
		for(j=0; j<2; j=j+1)
		begin
			#2 Asel[1]=j;
				sub=j;
		end
	end
	#50 $finish;
end

initial
begin
	$display("Aload | Asel | Sub | outputRam |  Input  | outputAddSub | outputA | Aeq0 | Apos");
	$monitor("  %b      %b     %b     %b    %b    %b    %b    %b    %b", Aload, Asel, sub, outputRam, Input, outputAddSub, outputA, Aeq0, Apos);
end

always #1 Clock=~Clock;

InsSetOp ISO (Clock, Reset, Aload, sub, Asel, Input, outputRam, outputA, outputAddSub, Aeq0, Apos);

endmodule 