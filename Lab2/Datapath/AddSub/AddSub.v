module AddSub #(parameter width = 8)(
	input sub,
	input [width-1:0]iDat1,
	input [width-1:0]iDat2,
	output reg [width-1:0]oDat
);

	always@*
	begin
		if (sub)
			oDat = iDat1 - iDat2;
		else
			oDat = iDat1 + iDat2;
	end
	
endmodule 