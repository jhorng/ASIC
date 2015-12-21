module InitRam(
	input Clock, WE, Enable,
	input [4:0]Address,
	input [7:0]D,
	output reg [7:0]Q
);

	reg [7:0]RAM[31:0];

	always@(posedge Clock)
	begin
		if(Enable)
		begin
			RAM[5'b00000] = 8'b10000000;	// input A
			RAM[5'b00001] = 8'b00111110;	// store A, X
			RAM[5'b00010] = 8'b10000000;	// input A
			RAM[5'b00011] = 8'b00111111;	// store A, Y
			
			RAM[5'b00100] = 8'b00011110;	// loop, load A, X -- X = Y?
			RAM[5'b00101] = 8'b01111111;	// sub A, Y
			RAM[5'b00110] = 8'b10110000;	// jz out
			RAM[5'b00111] = 8'b11001100;	// jp XgtY
			
			RAM[5'b01000] = 8'b00011111;	// load A, Y
			RAM[5'b01001] = 8'b01111110;	// sub A, X
			RAM[5'b01010] = 8'b00111111;	// store A, Y
			RAM[5'b01011] = 8'b11000100;	// jp loop
			
			RAM[5'b01100] = 8'b00011110;	// XgtY: load A, X	-- X > Y
			RAM[5'b01101] = 8'b01111111;	// sub A, Y
			RAM[5'b01110] = 8'b00111110;	// store A, X
			RAM[5'b01111] = 8'b11000100;	// jp loop
			
			RAM[5'b10000] = 8'b00011110;	// load A, X
			RAM[5'b10001] = 8'b11111111;	// halt
			
			RAM[5'b11110] = 8'b00000000;	// X
			RAM[5'b11111] = 8'b00000000;	// Y
		end
		else
		begin
			if(WE)
				RAM[Address] = D;
			else
				Q = RAM[Address];
		end
	end

endmodule 