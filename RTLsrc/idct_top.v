module idct_top(
		clk,
		rst_n,
		data,
		mode,
		dout
		);
		
input wire clk,rst_n;
input wire [1:0]mode;
input wire [15:0]data;
output reg [15:0]dout;

wire [15:0]x2y;
wire [15:0]y2z;
reg wr_rd;
reg wr_rd4;
reg [5:0]wr_addr;

reg [5:0]rd_addr;
reg [3:0]wr_addr4;
reg [3:0]rd_addr4;
wire [15:0]z;

reg [7:0]c8;
reg done8;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	c8<=8'b0;
else if(mode == 2'b1 && c8<148)
	c8<=c8+1;
else
	c8<=8'b0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	done8<=0;
else if(c8 == 8 || c8 == 72)
	done8<=1;
else
	done8<=0;

reg [5:0]c4;
reg done4;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	c4<=6'b0;
else if(mode == 2'b0 && c4<44)
	c4<=c4+1;
else if(mode == 2'b0)
	c4<=6'b1;
else
	c4<=6'b0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	done4<=0;
else if(c4 == 4 || c4 == 20)
	done4<=1;
else
	done4<=0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	wr_rd<=1;
else if(done8 == 1)
	wr_rd<=!wr_rd;
else
	wr_rd<=wr_rd;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	wr_rd4<=1;
else if(done4 == 1)
	wr_rd4<=!wr_rd4;
else
	wr_rd4<=wr_rd4;

wire wr_rd_ram;
assign wr_rd_ram=(mode == 2'b01)?wr_rd:wr_rd4;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	wr_addr<=6'b0;
else if(done8 == 1)
	wr_addr<=6'b1;
else if(wr_addr != 6'b0 && wr_addr<63)
	wr_addr<=wr_addr+1;
else
	wr_addr<=6'b0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	rd_addr<=6'b0;
else if(done8 == 1)
	rd_addr<=6'd8;
else if(rd_addr != 6'b0 && rd_addr<56)
	rd_addr<=rd_addr+8;
else if(rd_addr != 6'b0)
	rd_addr<=(rd_addr-55)%8;
else
	rd_addr<=6'b0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	wr_addr4<=4'b0;
else if(done4 == 1)
	wr_addr4<=4'b1;
else if(wr_addr4 != 4'b0 && wr_addr4<15)
	wr_addr4<=wr_addr4+1;
else
	wr_addr4<=4'b0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	rd_addr4<=4'b0;
else if(done4 == 1)
	rd_addr4<=4'd4;
else if(rd_addr4 != 4'b0 && rd_addr4<12)
	rd_addr4<=rd_addr4+4;
else if(rd_addr4 != 4'b0)
	rd_addr4<=(rd_addr4-11)%4;
else
	rd_addr4<=4'b0;


//delay of wr_addr and rd_addr
reg [5:0]wr_addr_reg;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	wr_addr_reg<=6'b0;
else if(mode == 2'b01)
	wr_addr_reg<=wr_addr;
else
	wr_addr_reg<=wr_addr4;

reg [5:0]rd_addr_reg;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	rd_addr_reg<=6'b0;
else if(mode == 2'b01)
	rd_addr_reg<=rd_addr;
else
	rd_addr_reg<=rd_addr4;

reg [3:0]wr_addr4_reg;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	wr_addr4_reg<=4'b0;
else
	wr_addr4_reg<=wr_addr4;

reg [3:0]rd_addr4_reg;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	rd_addr4_reg<=4'b0;
else
	rd_addr4_reg<=rd_addr4;

wire [7:0]count_in_line;
assign count_in_line=(mode == 2'b01)?c8:c4;

wire [7:0]count_in_row;
assign count_in_row=(mode == 2'b01)?c8:c4;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	dout<=16'b0;
else
	dout<=z[15:0];

//instantiate all the modules
idct_row idct_row1(
		.clk(clk),
		.rst_n(rst_n),
		.x(data),
		.y(x2y),
		.mode(mode),
		.counter(count_in_row)
		);
		
RAM idct_ram1(
		.clk(clk),
		.rst_n(rst_n),
		.wr_rd(wr_rd_ram),
		.wr_addr(wr_addr_reg),
		.rd_addr(rd_addr_reg),
		.data_in(x2y),
		.data_out(y2z),
		.mode(mode)
		);
		
idct_line idct_line1(
		.clk(clk),
		.rst_n(rst_n),
		.y(y2z),
		.z(z),
		.mode(mode),
		.counter(count_in_line)
		);

endmodule


