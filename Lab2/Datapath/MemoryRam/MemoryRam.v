module MemoryRam(
	input Clock, WE,
	input [4:0]memAddr,
	input [7:0]iDat,
	output reg [7:0]oDat
);
	
	reg [7:0]RAM[31:0];
	reg [4:0]addrReg;
	
	always@(posedge Clock)
	begin
		if (WE)
			RAM[memAddr]<=iDat;
		else
			oDat=RAM[memAddr];
	end
	
	endmodule
	