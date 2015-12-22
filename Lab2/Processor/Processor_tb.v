/********
 *
 *	Name  : Chu Jaan Horng
 *	Date  : 15-12-2015
 *	Title :	Processor testbench
 *
 ********/

`timescale 1ns/1ns
module Processor_tb();
	
	reg Clock, Reset, Enter, Enable;
	reg [7:0]Input;
  reg [7:0]tempX, tempY;
	
	wire Halt;
	wire [7:0]Output;
	
	integer errors, i;
	
	Processor up (.Clock(Clock), .Reset(Reset), .Enter(Enter), .Enable(Enable), .Input(Input), .Halt(Halt), .Output(Output));
	
	// -----------------Global Reset and Clock-----------------
	initial
	begin
		Clock<=0;
		forever #1 Clock = ~Clock;
	end
	
	initial
	begin
		Reset<=1;
		@(posedge Clock);
		@(negedge Clock) Reset=0; 
	end
	
	// -----------------Main Block of the Testbench-----------------
	initial
	begin
		INIT_VARS();
    INIT_RAM();
    // tempX = {$random}%128;
    // tempY = {$random}%128;
		for (i=1; i<100; i=i+1)
		begin
    RESET();
    tempX = {$random}%128;
      while(tempX == 0)
      begin
        tempX = {$random}%128;
      end
			#30 INPUT_VALUE(tempX);
    tempY = {$random}%128;
      while(tempY == 0)
      begin
        tempY = {$random}%128;
      end
      #30 INPUT_VALUE(tempY);
      #2 COMPUTATION(tempX, tempY);
		end
		SUMMARY();
    #2 $finish;
	end
	// -------------------------------------------------------------
  // initial
  // begin
    // $display("Enter |  Input  |   Output  | Halt | Time");
    // $monitor("  %d       %d       %d       %b %tns\n", Enter, Input, Output, Halt, $time);
  // end
  
	// ---------------------------Test sets-------------------------
	task RESET; 
	begin
	$display("Info: Reset processor");
		Reset=1;
		#2 Reset=0;
	end
	endtask
	
	task INIT_VARS;
	begin
	$display("Info: Initializing variables");
		Clock=0;
		Enter=0;
		Input=0;
    Enable=0;
    errors=0;
	end
	endtask
	
  task INIT_RAM;
  begin
    $display("Info: Initializing Memory");
    Enable=1;
    #2 Enable=0;
  end
  endtask
  
	task INPUT_VALUE;
	input [7:0]iDat;
	begin
	$display("Info: Data (%d) inputs into Datapath", iDat);
		Input = iDat;
    Enter=1;
		#2 Enter=0;
	end
	endtask
	
	task COMPUTATION;
	input [7:0]X, Y;
	begin
	$display("Info: Compute X (%d) and Y (%d)", X, Y);
		while(X != Y)
		begin
			if(X > Y)
				X = X - Y;
			else
				Y = Y - X;
		end
		VERIFY_OUTPUT(X);
    $display("Info: Computed result (%d) at time %tns", X, $time);
	end 
	endtask
	
	task VERIFY_OUTPUT;
	input [7:0]expected_value;
	begin
	$display("Info: Verifying output X");
    while(!Halt) #1;
		if(expected_value != Output)
		begin
			errors = errors + 1;
			$display("Expected answer to be %d but it was %d at time = %tns\n", expected_value, Output, $time);
		end
	end
	endtask
	
	task SUMMARY;
	begin
	  $display("\nInfo: End of calculation. Halt (%d) at %tns", Halt, $time);
		if(errors > 0)
			$display("\nInfo: Fail --> Total errors (%d)\n", errors);
		else
			$display("\nInfo: Success\n");
	end
	endtask
endmodule 