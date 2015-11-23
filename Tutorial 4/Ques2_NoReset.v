module Ques2_NoReset(
	input iClk, iDat,
	output reg [15:0]sr
);

	always@(posedge iClk)
	begin
		sr<={sr[14:0], iDat};
	end

endmodule
