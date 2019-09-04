//module:idct_row
//author:yangyifan
//date:2018/3/11

module idct_row(
		clk,
		rst_n,
		x,
		y,
		mode,
		counter
		);
		
input wire clk,rst_n;
input wire signed[15:0]x;
input wire [1:0]mode;
input wire [7:0]counter;
output reg signed[15:0]y;

reg signed[15:0]x1;
reg signed[15:0]x2;
reg signed[15:0]x3;
reg signed[15:0]x4;
reg signed[15:0]x5;
reg signed[15:0]x6;
reg signed[15:0]x7;
reg signed[15:0]y0;
reg signed[15:0]y1;
reg signed[15:0]y2;
reg signed[15:0]y3;
reg signed[15:0]y4;
reg signed[15:0]y5;
reg signed[15:0]y6;
reg signed[15:0]y7;
//reg [6:0]counter;
reg [6:0]counter_reg;
//reg [3:0]counter4;
//reg [3:0]counter4_reg;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	counter_reg<=7'd1;
else
	counter_reg<=counter;
/*
always@(posedge clk or negedge rst_n)
if(!rst_n)
	counter4<=4'b0;
else if(counter4<16)
	counter4<=counter4+1;
else
	counter4<=4'b1;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	counter4_reg<=4'b0;
else
	counter4_reg<=counter4;
*/
//*****************************delay**********************************\\
always@(posedge clk or negedge rst_n)
if(!rst_n)
	x1<=16'b0;
else
	x1<=x;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	x2<=16'b0;
else
	x2<=x1;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	x3<=16'b0;
else
	x3<=x2;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	x4<=16'b0;
else if(mode == 2'b01)
	x4<=x3;
else
	x4<=16'b0;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	x5<=16'b0;
else if(mode == 2'b01)
	x5<=x4;
else
	x5<=16'b0;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	x6<=16'b0;
else if(mode == 2'b01)
	x6<=x5;
else
	x6<=16'b0;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	x7<=16'b0;
else if(mode == 2'b01)
	x7<=x6;
else
	x7<=16'b0;
	
//*****************************matrix**********************************\\
always@(posedge clk or negedge rst_n)
if(!rst_n)
begin
	y0<=16'b0;
	y1<=16'b0;
	y2<=16'b0;
	y3<=16'b0;
	y4<=16'b0;
	y5<=16'b0;
	y6<=16'b0;
	y7<=16'b0;
end
else if(mode == 2'b01 && counter % 8 == 0)					
begin	

	y0<=(64*x7+89*x6+83*x5+75*x4+64*x3+50*x2+36*x1+18*x)>>7;
	y1<=(64*x7+75*x6+36*x5-18*x4-64*x3-89*x2-83*x1-50*x)>>7;
	y2<=(64*x7+50*x6-36*x5-89*x4-64*x3+18*x2+83*x1+75*x)>>7;
	y3<=(64*x7+18*x6-83*x5-50*x4+64*x3+75*x2-36*x1-89*x)>>7;
	y4<=(64*x7-18*x6-83*x5+50*x4+64*x3-75*x2-36*x1+89*x)>>7;
	y5<=(64*x7-50*x6-36*x5+89*x4-64*x3-18*x2+83*x1-75*x)>>7;
	y6<=(64*x7-75*x6+36*x5+18*x4-64*x3+89*x2-83*x1+50*x)>>7;
	y7<=(64*x7-89*x6+83*x5-75*x4+64*x3-50*x2+36*x1-18*x)>>7;
/*
	y0<=(64*x7+89*x6+83*x5+75*x4+64*x3+50*x2+36*x1+18*x)/128;
	y1<=(64*x7+75*x6+36*x5-18*x4-64*x3-89*x2-83*x1-50*x)/128;
	y2<=(64*x7+50*x6-36*x5-89*x4-64*x3+18*x2+83*x1+75*x)/128;
	y3<=(64*x7+18*x6-83*x5-50*x4+64*x3+75*x2-36*x1-89*x)/128;
	y4<=(64*x7-18*x6-83*x5+50*x4+64*x3-75*x2-36*x1+89*x)/128;
	y5<=(64*x7-50*x6-36*x5+89*x4-64*x3-18*x2+83*x1-75*x)/128;
	y6<=(64*x7-75*x6+36*x5+18*x4-64*x3+89*x2-83*x1+50*x)/128;
	y7<=(64*x7-89*x6+83*x5-75*x4+64*x3-50*x2+36*x1-18*x)/128;*/
end
else if(mode == 2'b0 && counter % 4 == 0)
begin
	y0<=(64*x3+83*x2+64*x1+36*x)>>7;
	y1<=(64*x3+36*x2-64*x1-83*x)>>7;
	y2<=(64*x3-36*x2-64*x1+83*x)>>7;
	y3<=(64*x3-83*x2+64*x1-36*x)>>7;
	y4<=16'b0;
	y5<=16'b0;
	y6<=16'b0;
	y7<=16'b0;
end	
else
begin
	y0<=y0;
	y1<=y1;
	y2<=y2;
	y3<=y3;
	y4<=y4;
	y5<=y5;
	y6<=y6;
	y7<=y7;
end

//******************************P2S***********************************\\
always@(posedge clk or negedge rst_n)
if(!rst_n)
	y<=16'b0;
else if(mode == 2'b01 && counter_reg%8==0)
	y<=y0;
else if(mode == 2'b01 && counter_reg%8==1)
	y<=y1;
else if(mode == 2'b01 && counter_reg%8==2)
	y<=y2;
else if(mode == 2'b01 && counter_reg%8==3)
	y<=y3;
else if(mode == 2'b01 && counter_reg%8==4)
	y<=y4;
else if(mode == 2'b01 && counter_reg%8==5)
	y<=y5;
else if(mode == 2'b01 && counter_reg%8==6)
	y<=y6;
else if(mode == 2'b01 && counter_reg%8==7)
	y<=y7;
else if(mode == 2'b0 && counter_reg%4==0)
	y<=y0;
else if(mode == 2'b0 && counter_reg%4==1)
	y<=y1;
else if(mode == 2'b0 && counter_reg%4==2)
	y<=y2;
else if(mode == 2'b0 && counter_reg%4==3)
	y<=y3;
else
	y<=16'b0;
	
endmodule

