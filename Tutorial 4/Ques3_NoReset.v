module Ques3_NoReset(
	input iClk, iDat1, iDat2,
	output reg oDat
);

	always@(posedge iClk or negedge iDat2)
	begin
		if(!iDat2)
			oDat<=0;
		else
			oDat<=iDat1;
	end

endmodule
