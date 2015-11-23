module Ques4_Reset(
	input iReset, iClk,
	input iDat1, iDat2, iDat3,
	output reg oDat
);

	always@(posedge iClk or negedge iReset)
	begin
		if(!iReset)
			oDat<=0;
		else
			oDat<=!iDat3 & (iDat1 | iDat2);
	end
	
endmodule
