module CUtb ();

//...declaration input as reg and output as wire...
//........Liew Ee Mei INPUT and OUTPUT........
	reg [2:0] IR;
	reg	Aeq0, Apos, Enter, Reset, Clock; 
      
	wire IRload, Aload, Sub, JMPmux, PCload, Meminst, Halt, MemWr;
	wire [1:0] Asel;
	wire [3:0] state, nstate; 
	wire [13:0] Output_L, Output_C;
 
assign Output_L = { IRload,JMPmux,PCload,Meminst,MemWr, Aload, Sub, Halt, Asel,state };
//........Chu Jaan Horng OUTPUT........
	wire IRload_C,Aload_C,Sub_C,JMPmux_C,PCload_C,Meminst_C,Halt_C,MemWr_C;
	wire [1:0] Asel_C;
	wire [3:0] state_C, nstate_C; 
  
assign Output_C = { IRload_C,JMPmux_C,PCload_C,Meminst_C,MemWr_C, Aload_C, Sub_C, Halt_C, Asel_C,state_C };



initial begin 
//..intialize the input..
	Clock = 0;
	Reset = 1;
	IR = 3'b000;
	Aeq0 = 0;
	Apos = 0;
	Enter = 0;
//..start delay mode..
#4 Reset = 0; 
   Aeq0 = 0; 
   Apos = 0; 
   Enter = 0;
#8 IR = 3'b000;
#8 IR = 3'b001;
#8 IR = 3'b010;
#8 IR = 3'b011;
#8 IR = 3'b100; 
   Enter = 0;
#8 IR = 3'b100; 
   Enter = 1;
#8 IR = 3'b101; 	
   Aeq0 = 0;
#8 IR = 3'b101; 	
   Aeq0 = 1;
#10 IR = 3'b110; 	
	Apos = 0;
#10 IR = 3'b110; 	
	Apos = 1;
#10 IR = 3'b111;
#200 $finish;          /*terminal stimulation*/
end




always #1 // can be output for #1
	begin
		if(Output_L == Output_C) 
		  begin
			 $display("Match State %h", state);
		  end
		else
		  begin
			 $display("Result Not Match at %h", state);
			 $display("LIEWoutput = {%b,%b,%b,%b,%b,%b,%b,%b,%b,%h}",IRload,JMPmux,PCload,Meminst,MemWr, Aload, Sub, Halt, Asel,state);
			 $display("CHUoutput = {%b,%b,%b,%b,%b,%b,%b,%b,%b,%h}",IRload_C,JMPmux_C,PCload_C,Meminst_C,MemWr_C, Aload_C, Sub_C, Halt_C, Asel_C,state_C);
		  end
	end



//...clock pulse genneartor.....
always #1 Clock = ~Clock;


//..connect module to test bench..
 ControlUnit CUtb_C(Clock,Reset,Enter,IR,Aeq0,Apos,IRload_C,JMPmux_C,PCload_C,Meminst_C,MemWr_C,Aload_C,Sub_C,Halt_C,Asel_C,state_C,nstate_C);
 
 CU CUtb_L (Reset,Clock,IRload,Aload,Sub,JMPmux,PCload,Meminst,MemWr,Halt,Asel,IR,Aeq0,Apos,Enter,state,nstate);
		
  endmodule
  
		
