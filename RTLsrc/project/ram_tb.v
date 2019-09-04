module ram_tb;

reg clk,rst_n,wr_rd;
reg [15:0]data_in;
reg [5:0]wr_addr;
reg [5:0]rd_addr;

wire [15:0]data_out;

RAM ram(
	.clk(clk),
	.rst_n(rst_n),
	.wr_rd(wr_rd),
	.data_in(data_in),
	.wr_addr(wr_addr),
	.rd_addr(rd_addr),
	.data_out(data_out)
	);

initial begin
#0	clk=0;
forever #5 clk=!clk;
end

initial begin
#0	rst_n=0;
#3	rst_n=1;
end

initial begin
#0	wr_rd=1;
#645	wr_rd=0;
#640	wr_rd=1;
end

/*
initial begin
#0	data_in=0;
#15	data_in=1;
end
*/

always@(posedge clk or negedge rst_n)
if(!rst_n)
	data_in<=16'b0;
else if(data_in<63)
	data_in<=data_in+1;
else
	data_in<=0;

/*
initial begin
#0	wr_addr=0;
#15	wr_addr=0;
end
*/

always@(posedge clk or negedge rst_n)
if(!rst_n)
	wr_addr<=6'b0;
else if(wr_addr<63)
	wr_addr<=wr_addr+1;
else
	wr_addr<=0;

/*
initial begin
#0	rd_addr=0;
#15	rd_addr=0;
end
*/

always@(posedge clk or negedge rst_n)
if(!rst_n)
	rd_addr<=6'b0;
else if(rd_addr<63)
	rd_addr<=rd_addr+8;
else
	rd_addr<=(rd_addr+8)%63;

endmodule
