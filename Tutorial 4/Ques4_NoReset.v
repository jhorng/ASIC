module Ques4_NoReset(
	input iClk, iDat1, iDat2, iDat3,
	output reg oDat
);

	always@(posedge iClk or negedge iDat3)
	begin
		if(!iDat3)
			oDat<=0;
		else
			oDat<= iDat1 | iDat2;
	end
	
endmodule
