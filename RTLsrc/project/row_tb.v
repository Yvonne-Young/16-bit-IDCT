module row_tb;

reg clk,rst_n;
reg [15:0] x;

wire [15:0] y;

idct_row idct_row(
		.clk(clk),
		.rst_n(rst_n),
		.x(x),
		.y(y)
		);

initial begin
#0	clk=0;
forever #5	clk=!clk;
end

initial begin
#0	rst_n=0;
#15	rst_n=1;
end

reg[15:0] count;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	count<=0;
else if(count<64)
	count<=count+1;
else
	count=0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	x<=16'b0;
else
	x<=count;

endmodule



