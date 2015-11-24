module Increment #(parameter width = 5)(
	input [width-1:0]iDat,
	output reg [width-1:0]oDat
);

	always@(iDat)
	begin
		oDat=iDat+1;
	end

endmodule
