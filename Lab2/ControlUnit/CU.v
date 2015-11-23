module CU (
	input Reset, Clock,
	output reg IRload,Aload,Sub,
	output reg JMPmux,PCload, Meminst, MemWr, Halt,
  output reg [1:0] Asel,
	input [2:0] IR,
	input Aeq0, Apos, Enter,
	output reg [3:0] state, nstate
);
	
	//reg[3:0] state,nstate;
	//........declaration for constant state......
	parameter [3:0] start=4'b0000,
		fetch=4'b0001,
		decode=4'b0010,
		load=4'b1000,
		store=4'b1001,
		add=4'b1010,
		sub=4'b1011,
		Input=4'b1100,
		jz=4'b1101,
		jpos=4'b1110,
		halt=4'b1111;
				      
	//......code begin here...............			      
	always@(posedge Reset, posedge Clock)
	begin
		if (Reset)
			state<= start;
		else
			state<=nstate;
	end
	
	//.......always block state.........
	always@(state, IR, Enter, Aeq0, Apos)begin 

	case(state)					
	start:begin					//start --> fetch (state)
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=fetch;
			end
		  
	fetch:begin				// fetch --> decode
			IRload=1;  //  !!!!!!!!!!!!
			JMPmux=0;
			PCload=1;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=decode;
		  end
	
	decode:begin		// decode --> load
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=1;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
			case (IR)
			  3'b000 : nstate= load;
			  3'b001 : nstate= store;
			  3'b010 : nstate= add;
			  3'b011 : nstate= sub;
			  3'b100 : nstate= Input;
			  3'b101 : nstate= jz;
			  3'b110 : nstate= jpos;
			  3'b111 : nstate= halt;
			  endcase
			end
			
	load:begin					// load --> start
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b10;
			Aload=1;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end
		  
	store:begin					// store --> start
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=1;
			MemWr=1;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end
		  
	add:begin							// add --> start
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=1;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end

	sub:begin							// sub --> start
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=1;
			Sub=1;
			Halt =0;
		  nstate=start;
		  end
		  
	Input:begin						// Input --> start
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b01;
			Aload=1;
			Sub=0;
			Halt =0;					// IF...............
			if (Enter)begin		// (Enter) --> start
		  nstate=start;
			end
		  else begin				// (Enter') --> Input
		  nstate=Input;
		  end
		  end
		  
	jz:begin							// jz --> start
			IRload=0;
			JMPmux=1;
			PCload=Aeq0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end
		  
	jpos:begin						// jpos -->start
			IRload=0;
			JMPmux=1;
			PCload=Apos;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =0;
		  nstate=start;
		  end
		  
		  
	halt:begin					// halt --> halt
			IRload=0;
			JMPmux=0;
			PCload=0;
			Meminst=0;
			MemWr=0;
			Asel[1:0]=2'b00;
			Aload=0;
			Sub=0;
			Halt =1;
		  nstate=halt;
		  end

		                            
	default:nstate=start;
	endcase
	end
	
	endmodule
	
	
	