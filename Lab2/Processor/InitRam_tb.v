module InitRam_tb();
	
	reg Clock, WE, Enable;
	reg [4:0]Address;
	reg [7:0]D;
	wire [7:0]Q;
	
	integer i;
	
	InitRam memory (.Clock(Clock), .WE(WE), .Enable(Enable), .Address(Address), .D(D), .Q(Q));
	
	initial
	begin
		Clock=0;
		WE=0;
		Enable=0;
		Address=0;
		D=0;
		#2 Enable=1;
		for(i=0; i<16; i=i+1)
		begin
			#2 Address = Address + 1;
		end
		#20 Enable=0; Address=0;
		for(i=0; i<32; i=i+1)
		begin
			#2 Address = Address + 1;
		end
		#50 $finish;
	end
	
	initial
	begin
		$display("WE | Enable | Address | D | Q | Time");
		$monitor("%b   %b   %b   %b  %b %tns", WE, Enable, Address, D, Q, $time);
	end
	
always #1 Clock=~Clock;

endmodule 