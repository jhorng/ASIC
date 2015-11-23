module Register #(parameter width = 8)(
	input Clock, Clear,
	input Load,
	input [width-1:0]Input, 
	output reg [width-1:0]Output
);

	always@(posedge Clock , posedge Clear)
	begin
		if (Clear)
			Output<=0;
		else
			begin
				if (Load)
					Output<=Input;
				else
					Output<=Output;
			end
	end
endmodule
