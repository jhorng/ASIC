module MemoryRam_tb();

	reg Clock, WE;
	reg [4:0]memAddr;
	reg [7:0]iDat;
	wire [7:0]oDat;
	
	integer i;
	
	initial
	begin
		Clock=0;
		memAddr=0;
		iDat=0;
		WE=1;
		for (i=0; i<5'b111; i=i+1)
		begin
	#4	 memAddr = memAddr + 5'b00001;
      iDat = iDat + 1;  		  
		end
		WE=0;
		memAddr=0;
		for (i=0; i<5'b111; i=i+1)
		begin
	#4  memAddr = memAddr +5'b00001;
		end
		#50 $finish;
	end
	
initial
begin
	$display("  MemWr | Address | iDat      | oDat    | Clock");
	$monitor("    %b     %b     %b   %b      %d", WE, memAddr, iDat, oDat, Clock);
end
	
always #1 Clock = ~Clock;
	
MemoryRam RAM (Clock, WE, memAddr, iDat, oDat);
	
endmodule
