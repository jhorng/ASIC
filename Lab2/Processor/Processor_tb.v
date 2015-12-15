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
	
	wire Halt;
	wire [7:0]Output;
	
	integer errors, i, j;
	
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
    // Enable<=1;
		@(posedge Clock)
		@(negedge Clock) Reset=0; 
                     // Enable=0;
	end
	
	// -----------------Main Block of the Testbench-----------------
	initial
	begin
		INIT_VARS();
    INIT_RAM();
		for (i=1; i<10; i=i+1)
		begin
    #2 RESET();
    j = {$random}%128;
      while(j == 0)
      begin
        j = {$random}%128;
      end
			#10 INPUT_VALUE(j);
      #10 INPUT_VALUE(i);
      #2 COMPUTATION(j, i);
		end
		SUMMARY();
    #2 $finish;
	end
	// -------------------------------------------------------------
  initial
  begin
    $display("Enter |   Input   |   Output   | Halt | Time");
    $monitor("  %b     %b     %b     %b %tns\n", Enter, Input, Output, Halt, $time);
  end
  
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
	$display("Info: Data (%b) inputs into Datapath when Enter (%h) at %t", iDat, Enter, $time);
		Input = iDat;
		#10 Enter=1;
		#4 Enter=0;
	end
	endtask
	
	task COMPUTATION;
	input [7:0]X, Y;
	begin
	$display("Info: Compute (%b) and (%b)", X, Y);
		while(X != Y)
		begin
			if(X > Y)
				X = X - Y;
			else
				Y = Y - X;
		end
		VERIFY_OUTPUT(X);
	end 
	endtask
	
	task VERIFY_OUTPUT;
	input [7:0]expected_value;
	begin
	$display("Info: Verifying output");
    while(Halt == 0)
    begin
    #10 i = i;
    end
		if(Output[7:0] != expected_value[7:0])
		begin
			errors = errors + 1;
			$display("Expected the answer to be %b but it was %b at time = %tns\n", expected_value, Output, $time);
		end
	end
	endtask
	
	task SUMMARY;
	begin
		if(errors > 0)
			$display("Info: Fail --> Total errors (%d)\n", errors);
		else
			$display("Info: Success\n");
	end
	endtask
endmodule 