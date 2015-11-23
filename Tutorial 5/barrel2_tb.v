`timescale 1ns/1ns
module barrel2_tb();
	
	reg clk, reset, Load, errors;
	reg [2:0]sel;
	reg [7:0]data_in;
	reg [7:0]shifter, nReg;
	
	wire [7:0]data_out;
	wire [7:0]brl_in, brl_out;
	
	integer i,j;
	
	barrel #(.data_size(8)) brl1 (.clk(clk), .reset(reset), .Load(Load), .sel(sel), .data_in(data_in), .data_out(data_out));
	//barrel_wrong #(.data_size(8)) brl2 (clk, reset, Load, sel, data_in, data_out);
	
	initial
	begin
		clk<=0;
		forever #5 clk = ~clk;
	end
	
	initial
	begin
		reset<=0;
		@(posedge clk);
		@(negedge clk) reset=1;
	end
	
	initial //main loop
	begin
	  errors=0;
	  Load=1;
	  $display("Load = %h", Load);
	  #2 BARREL();
	  Load =0;
	  $display("Load = %h", Load);
	  #2 BARREL();
	  SUMMARY();
	  #20 $finish;
	end
	
	always@(nReg, data_in, Load)
	begin
		$display ("Expected value | Data_out");
		$monitor("  %b\t  %b", nReg, data_out);
	end
	
	task verify_output;
		input [7:0]expected_value;
		begin
			if(data_out[7:0] != expected_value[7:0])
			begin
				errors = errors + 1;
				$display("Simualted Value = %b, Expected Value = %b, errors = %d, at time = %d\n", data_out, expected_value, errors, $time);
			end
		end
	endtask
	
	task BARREL;
	begin
		assign shifter = Load? data_in : nReg;
		for (i=0; i<3; i=i+1)
		begin
			data_in={$random}%3;
			for(j=0; j<8; j=j+1)
			begin
				sel=j;
				SHIFTER(shifter, nReg);
				verify_output(nReg);
			end
		end
	end
	endtask
	
	task SHIFTER;
	  input [7:0]iDat;
	  output [7:0]oDat;
	  begin
	    //brl_out <= {brl_in[sel-1:0], brl_in[7:sel]};
	    case(sel)
	    3'b000 : oDat = iDat;
	    3'b001 : oDat = {iDat[0:0], iDat[7:1]};
	    3'b010 : oDat = {iDat[1:0], iDat[7:2]};
	    3'b011 : oDat = {iDat[2:0], iDat[7:3]};
	    3'b100 : oDat = {iDat[3:0], iDat[7:4]};
	    3'b101 : oDat = {iDat[4:0], iDat[7:5]};
	    3'b110 : oDat = {iDat[5:0], iDat[7:6]}; 
	    3'b111 : oDat = {iDat[6:0], iDat[7:7]};
	    default: oDat = 8'hFF;
	    endcase
	  end
	endtask
	
	task SUMMARY;
		if (errors!=0)
		begin
			$display("Fail!");
			$display("Errors = %d", errors);
		end
		else
			$display("Successful!");
	endtask
	
endmodule
