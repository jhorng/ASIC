module AddSub_tb();

	reg sub;
	reg [7:0]iDat1;
	reg [7:0]iDat2;
	
	wire [7:0]oDat;
	
	integer i, j;
	
initial
begin
  sub=0;
  iDat1=0;
  iDat2=0;
  for (i=0; i<10; i=i+1)
	begin
		#2 iDat1={$random}%256;
			iDat2={$random}%256;
		for (j=0; j<2; j=j+1)
		begin
			#2 sub=j;
		end
	end
	#10 $finish;
end

always@(oDat)
begin
	$display("sub |    iDat1    |    iDat2    |    oDat");
	$monitor("%b       %b      %b      %b", sub, iDat1, iDat2, oDat);
end

AddSub #(.width(8)) AS (sub, iDat1, iDat2, oDat);

endmodule 