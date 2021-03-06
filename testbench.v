`timescale 1ns/1ns

module testbench;

reg signed [15:0] data;
reg [1:0] mode;
reg [1:0] mode_mem[0:30];
wire signed[15:0] dout;
integer flag;
integer fp_r,fp_w;
reg clk,rst_n;

initial begin
fp_r = $fopen("input_data.txt","r");
fp_w = $fopen("output_data.txt","w");
end

initial begin
#5	$readmemb("mode.txt",mode_mem);
end

initial begin
data =0;
#0	clk=0;
forever #5	clk=!clk;
end

initial begin
#0	rst_n=0;
#8	rst_n=1;
end

reg [5:0]cnt4;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	cnt4<=6'b0;
else if(mode == 2'b0 && cnt4<44)
	cnt4<=cnt4+1;
else if(mode == 2'b0)
	cnt4<=6'b1;
else
	cnt4<=6'b0;

reg [7:0]cnt8;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	cnt8<=8'b0;
else if(mode == 2'b1 && cnt8<148)
	cnt8<=cnt8+1;
else
	cnt8<=8'b0;

reg [15:0] cnt_mode;
always@(posedge clk or negedge rst_n)
if(!rst_n)
	cnt_mode<=16'b0;
else if(cnt4==0 && cnt8==0)
	cnt_mode<=cnt_mode+1;
else
	cnt_mode<=cnt_mode;

always@(posedge clk or negedge rst_n)
if(!rst_n)
	mode<=2'b01;
else
	mode<=mode_mem[cnt_mode];


always@(posedge clk)
if(rst_n && mode == 2'b01 && cnt8<64)
	flag = $fscanf(fp_r,"%d",data);
else if(rst_n && mode == 2'b0 && cnt4<16)
	flag = $fscanf(fp_r,"%d",data);
else
	flag = 0;

idct_top idct(
		.clk(clk),
		.rst_n(rst_n),
		.data(data),
		.mode(mode),
		.dout(dout)
		);

reg signed[15:0]dout_reg;
always@(posedge clk)
	dout_reg<=dout;

reg signed[15:0]dout_reg_reg;
always@(posedge clk)
	dout_reg_reg<=dout_reg;

always@(posedge clk)
if(dout_reg != 0 || (dout_reg == 0 && dout_reg_reg != 0 && dout != 0 ))
	$fwrite(fp_w,"%d\n",dout_reg);

/*
always@(dout)
$fmonitor(fp_w,"%d",dout);
*/
endmodule
