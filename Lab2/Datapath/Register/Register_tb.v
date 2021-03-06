module Register_tb();

	reg Clock, Clear;
	reg Load;
	reg [7:0]Input;
	wire [7:0]Output;
	
	initial
	begin
		Clock=0;
		Load=0;
		Input=0;
		Clear=1;
		#2 Clear=0;
		#2 Input=8'b11110000;
		#2 Load=1;
		#2 Input=8'b10001100;
		#2 Input=8'b11001010;
		#10 $finish;
	end
	
	always@(Output)
	begin
	  $display("Load %d", Load);
	  $display("Clear %d", Load);
	  if(Input == Output)
	    $display("Match -> Input & Output %b %b\n",Input, Output );
	  else
	  begin
	    $display("No Match! %b %b\n", Input, Output);
	    $finish;
	  end
	end
	
always #1 Clock = ~Clock;

Register #(.width(8)) rg (Clock, Clear, Load, Input, Output);

endmodule
