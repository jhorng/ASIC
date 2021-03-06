module ClkDiv(
	input CLOCK_50,
	output reg Clock
);

	integer value = 25000000;
	integer count;
	
	always@(posedge CLOCK_50)begin
		if (count < 25000000) begin
			count = count + 1;
			end
		else begin
			Clock = ~Clock;
			count = 0;
		end
	end
	
 endmodule 