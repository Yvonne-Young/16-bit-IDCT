module line_tb;

reg clk,rst_n;
reg [15:0] y;
reg [1:0]mode;

wire [15:0] z;

idct_line idct_line(
		.clk(clk),
		.rst_n(rst_n),
		.y(y),
		.z(z),
		.mode(mode)
		);

initial begin
#0	clk=0;
forever #5	clk=!clk;
end

initial begin
#0	rst_n=0;
#15	rst_n=1;
end

initial	mode=2'b01;

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
	y<=16'b0;
else
	y<=count;

endmodule



