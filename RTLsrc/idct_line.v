//module:idct_line
//author:yangyifan
//date:2018/3/12

module idct_line(
		clk,
		rst_n,
		y,
		z,
		mode,
		counter
		);
		
input wire clk,rst_n;
input wire [1:0]mode;
input wire signed [15:0]y;
input wire [7:0]counter;
output reg signed [16:0]z;

reg signed [15:0]y1;
reg signed [15:0]y2;
reg signed [15:0]y3;
reg signed [15:0]y4;
reg signed [15:0]y5;
reg signed [15:0]y6;
reg signed [15:0]y7;
reg signed [15:0]z0;
reg signed [15:0]z1;
reg signed [15:0]z2;
reg signed [15:0]z3;
reg signed [15:0]z4;
reg signed [15:0]z5;
reg signed [15:0]z6;
reg signed [15:0]z7;
reg [6:0]counter_reg;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	counter_reg<=7'd1;
else
	counter_reg<=counter;

//*****************************delay**********************************\\
always@(posedge clk or negedge rst_n)
if(!rst_n)
	y1<=16'b0;
else 
	y1<=y;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	y2<=16'b0;
else
	y2<=y1;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	y3<=16'b0;
else
	y3<=y2;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	y4<=16'b0;
else if(mode == 2'b01)
	y4<=y3;
else
	y4<=16'b0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	y5<=16'b0;
else if(mode == 2'b01)
	y5<=y4;
else
	y5<=16'b0;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	y6<=16'b0;
else if(mode == 2'b01)
	y6<=y5;
else
	y6<=16'b0;
	
always@(posedge clk or negedge rst_n)
if(!rst_n)
	y7<=16'b0;
else if(mode == 2'b01)
	y7<=y6;
else
	y7<=16'b0;
	
//*****************************matrix**********************************\\
always@(posedge clk or negedge rst_n)
if(!rst_n)
begin
	z0<=16'b0;
	z1<=16'b0;
	z2<=16'b0;
	z3<=16'b0;
	z4<=16'b0;
	z5<=16'b0;
	z6<=16'b0;
	z7<=16'b0;
end
else if(mode == 2'b01 && counter>81 && counter<146 && counter%8==2)
begin	
	z0<=(64*y7+89*y6+83*y5+75*y4+64*y3+50*y2+36*y1+18*y)>>12;
	z1<=(64*y7+75*y6+36*y5-18*y4-64*y3-89*y2-83*y1-50*y)>>12;
	z2<=(64*y7+50*y6-36*y5-89*y4-64*y3+18*y2+83*y1+75*y)>>12;
	z3<=(64*y7+18*y6-83*y5-50*y4+64*y3+75*y2-36*y1-89*y)>>12;
	z4<=(64*y7-18*y6-83*y5+50*y4+64*y3-75*y2-36*y1+89*y)>>12;
	z5<=(64*y7-50*y6-36*y5+89*y4-64*y3-18*y2+83*y1-75*y)>>12;
	z6<=(64*y7-75*y6+36*y5+18*y4-64*y3+89*y2-83*y1+50*y)>>12;
	z7<=(64*y7-89*y6+83*y5-75*y4+64*y3-50*y2+36*y1-18*y)>>12;
/*
	z0<=(64*y7+89*y6+83*y5+75*y4+64*y3+50*y2+36*y1+18*y)/4096;
	z1<=(64*y7+75*y6+36*y5-18*y4-64*y3-89*y2-83*y1-50*y)/4096;
	z2<=(64*y7+50*y6-36*y5-89*y4-64*y3+18*y2+83*y1+75*y)/4096;
	z3<=(64*y7+18*y6-83*y5-50*y4+64*y3+75*y2-36*y1-89*y)/4096;
	z4<=(64*y7-18*y6-83*y5+50*y4+64*y3-75*y2-36*y1+89*y)/4096;
	z5<=(64*y7-50*y6-36*y5+89*y4-64*y3-18*y2+83*y1-75*y)/4096;
	z6<=(64*y7-75*y6+36*y5+18*y4-64*y3+89*y2-83*y1+50*y)/4096;
	z7<=(64*y7-89*y6+83*y5-75*y4+64*y3-50*y2+36*y1-18*y)/4096;*/
end
else if(mode == 2'b0 && counter>25 && counter<42 && counter%4==2)
begin
	z0<=(64*y3+83*y2+64*y1+36*y)>>12;
	z1<=(64*y3+36*y2-64*y1-83*y)>>12;
	z2<=(64*y3-36*y2-64*y1+83*y)>>12;
	z3<=(64*y3-83*y2+64*y1-36*y)>>12;
	z4<=32'b0;
	z5<=32'b0;
	z6<=32'b0;
	z7<=32'b0;
/*
	z0<=(64*y3+83*y2+64*y1+36*y)/4096;
	z1<=(64*y3+36*y2-64*y1-83*y)/4096;
	z2<=(64*y3-36*y2-64*y1+83*y)/4096;
	z3<=(64*y3-83*y2+64*y1-36*y)/4096;
	z4<=16'b0;
	z5<=16'b0;
	z6<=16'b0;
	z7<=16'b0;*/
end	
else if(counter%8!=2)
begin
	z0<=z0;
	z1<=z1;
	z2<=z2;
	z3<=z3;
	z4<=z4;
	z5<=z5;
	z6<=z6;
	z7<=z7;
end
else if(mode == 2'b0 && counter>25 && counter<42 && counter%4!=2)
begin
	z0<=z0;
	z1<=z1;
	z2<=z2;
	z3<=z3;
	z4<=z4;
	z5<=z5;
	z6<=z6;
	z7<=z7;
end
else
begin
	z0<=16'b0;
	z1<=16'b0;
	z2<=16'b0;
	z3<=16'b0;
	z4<=16'b0;
	z5<=16'b0;
	z6<=16'b0;
	z7<=16'b0;
end

//******************************P2S***********************************\\
always@(posedge clk or negedge rst_n)
if(!rst_n)
	z<=16'b0;
else if(mode == 2'b01 && counter_reg%8==2)
	z<=z0;
else if(mode == 2'b01 && counter_reg%8==3)
	z<=z1;
else if(mode == 2'b01 && counter_reg%8==4)
	z<=z2;
else if(mode == 2'b01 && counter_reg%8==5)
	z<=z3;
else if(mode == 2'b01 && counter_reg%8==6)
	z<=z4;
else if(mode == 2'b01 && counter_reg%8==7)
	z<=z5;
else if(mode == 2'b01 && counter_reg%8==0)
	z<=z6;
else if(mode == 2'b01 && counter_reg%8==1)
	z<=z7;
else if(mode == 2'b0 && counter_reg%4==2)
	z<=z0;
else if(mode == 2'b0 && counter_reg%4==3)
	z<=z1;
else if(mode == 2'b0 && counter_reg%4==0)
	z<=z2;
else if(mode == 2'b0 && counter_reg%4==1)
	z<=z3;
else
	z<=16'b0;
	
endmodule

