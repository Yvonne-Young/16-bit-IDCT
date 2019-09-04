//module:RAM
//author:yangyifan
//date:2018/3/12

module RAM(
		clk,
		rst_n,
		wr_rd,
		data_in,
		wr_addr,
		rd_addr,
		data_out,
		mode
		);

input wire clk,rst_n,wr_rd;
input wire [15:0] data_in;		//or 8-bit?
input wire [5:0]wr_addr;
input wire [5:0]rd_addr;
input wire [1:0]mode;
output reg [15:0]data_out;		//or 8-bit?

reg [15:0]ram1[0:63];
reg [15:0]ram2[0:63];

reg [15:0]ram3[0:15];
reg [15:0]ram4[0:15];
/*	
always@(posedge clk or negedge rst_n)
if(!rst_n)
begin
	ram1[0]<=16'b0;
	ram1[1]<=16'b0;
	ram1[2]<=16'b0;
	ram1[3]<=16'b0;
	ram1[4]<=16'b0;
	ram1[5]<=16'b0;
	ram1[6]<=16'b0;
	ram1[7]<=16'b0;
	ram1[8]<=16'b0;
	ram1[9]<=16'b0;
	ram1[10]<=16'b0;
	ram1[11]<=16'b0;
	ram1[12]<=16'b0;
	ram1[13]<=16'b0;
	ram1[14]<=16'b0;
	ram1[15]<=16'b0;
	ram1[16]<=16'b0;
	ram1[17]<=16'b0;
	ram1[18]<=16'b0;
	ram1[19]<=16'b0;
	ram1[20]<=16'b0;
	ram1[21]<=16'b0;
	ram1[22]<=16'b0;
	ram1[23]<=16'b0;
	ram1[24]<=16'b0;
	ram1[25]<=16'b0;
	ram1[26]<=16'b0;
	ram1[27]<=16'b0;
	ram1[28]<=16'b0;
	ram1[29]<=16'b0;
	ram1[30]<=16'b0;
	ram1[31]<=16'b0;
	ram1[32]<=16'b0;
	ram1[33]<=16'b0;
	ram1[34]<=16'b0;
	ram1[35]<=16'b0;
	ram1[36]<=16'b0;
	ram1[37]<=16'b0;
	ram1[38]<=16'b0;
	ram1[39]<=16'b0;
	ram1[40]<=16'b0;
	ram1[41]<=16'b0;
	ram1[42]<=16'b0;
	ram1[43]<=16'b0;
	ram1[44]<=16'b0;
	ram1[45]<=16'b0;
	ram1[46]<=16'b0;
	ram1[47]<=16'b0;
	ram1[48]<=16'b0;
	ram1[49]<=16'b0;
	ram1[50]<=16'b0;
	ram1[51]<=16'b0;
	ram1[52]<=16'b0;
	ram1[53]<=16'b0;
	ram1[54]<=16'b0;
	ram1[55]<=16'b0;
	ram1[56]<=16'b0;
	ram1[57]<=16'b0;
	ram1[58]<=16'b0;
	ram1[59]<=16'b0;
	ram1[60]<=16'b0;
	ram1[61]<=16'b0;
	ram1[62]<=16'b0;
	ram1[63]<=16'b0;
end
else if(mode == 2'b01 && wr_rd==0)
	ram1[wr_addr]<=data_in;
else
	ram1[wr_addr]<=ram1[wr_addr];
*/


always@(posedge clk or negedge rst_n)
if(!rst_n)
begin
	ram1[0]<=16'b0;
	ram1[1]<=16'b0;
	ram1[2]<=16'b0;
	ram1[3]<=16'b0;
	ram1[4]<=16'b0;
	ram1[5]<=16'b0;
	ram1[6]<=16'b0;
	ram1[7]<=16'b0;
	ram1[8]<=16'b0;
	ram1[9]<=16'b0;
	ram1[10]<=16'b0;
	ram1[11]<=16'b0;
	ram1[12]<=16'b0;
	ram1[13]<=16'b0;
	ram1[14]<=16'b0;
	ram1[15]<=16'b0;
	ram1[16]<=16'b0;
	ram1[17]<=16'b0;
	ram1[18]<=16'b0;
	ram1[19]<=16'b0;
	ram1[20]<=16'b0;
	ram1[21]<=16'b0;
	ram1[22]<=16'b0;
	ram1[23]<=16'b0;
	ram1[24]<=16'b0;
	ram1[25]<=16'b0;
	ram1[26]<=16'b0;
	ram1[27]<=16'b0;
	ram1[28]<=16'b0;
	ram1[29]<=16'b0;
	ram1[30]<=16'b0;
	ram1[31]<=16'b0;
	ram1[32]<=16'b0;
	ram1[33]<=16'b0;
	ram1[34]<=16'b0;
	ram1[35]<=16'b0;
	ram1[36]<=16'b0;
	ram1[37]<=16'b0;
	ram1[38]<=16'b0;
	ram1[39]<=16'b0;
	ram1[40]<=16'b0;
	ram1[41]<=16'b0;
	ram1[42]<=16'b0;
	ram1[43]<=16'b0;
	ram1[44]<=16'b0;
	ram1[45]<=16'b0;
	ram1[46]<=16'b0;
	ram1[47]<=16'b0;
	ram1[48]<=16'b0;
	ram1[49]<=16'b0;
	ram1[50]<=16'b0;
	ram1[51]<=16'b0;
	ram1[52]<=16'b0;
	ram1[53]<=16'b0;
	ram1[54]<=16'b0;
	ram1[55]<=16'b0;
	ram1[56]<=16'b0;
	ram1[57]<=16'b0;
	ram1[58]<=16'b0;
	ram1[59]<=16'b0;
	ram1[60]<=16'b0;
	ram1[61]<=16'b0;
	ram1[62]<=16'b0;
	ram1[63]<=16'b0;
end
else if(wr_rd==0)
	ram1[wr_addr]<=data_in;
else
	ram1[wr_addr]<=ram1[wr_addr];


always@(posedge clk or negedge rst_n)
if(!rst_n)
begin
	ram2[0]<=16'b0;
	ram2[1]<=16'b0;
	ram2[2]<=16'b0;
	ram2[3]<=16'b0;
	ram2[4]<=16'b0;
	ram2[5]<=16'b0;
	ram2[6]<=16'b0;
	ram2[7]<=16'b0;
	ram2[8]<=16'b0;
	ram2[9]<=16'b0;
	ram2[10]<=16'b0;
	ram2[11]<=16'b0;
	ram2[12]<=16'b0;
	ram2[13]<=16'b0;
	ram2[14]<=16'b0;
	ram2[15]<=16'b0;
	ram2[16]<=16'b0;
	ram2[17]<=16'b0;
	ram2[18]<=16'b0;
	ram2[19]<=16'b0;
	ram2[20]<=16'b0;
	ram2[21]<=16'b0;
	ram2[22]<=16'b0;
	ram2[23]<=16'b0;
	ram2[24]<=16'b0;
	ram2[25]<=16'b0;
	ram2[26]<=16'b0;
	ram2[27]<=16'b0;
	ram2[28]<=16'b0;
	ram2[29]<=16'b0;
	ram2[30]<=16'b0;
	ram2[31]<=16'b0;
	ram2[32]<=16'b0;
	ram2[33]<=16'b0;
	ram2[34]<=16'b0;
	ram2[35]<=16'b0;
	ram2[36]<=16'b0;
	ram2[37]<=16'b0;
	ram2[38]<=16'b0;
	ram2[39]<=16'b0;
	ram2[40]<=16'b0;
	ram2[41]<=16'b0;
	ram2[42]<=16'b0;
	ram2[43]<=16'b0;
	ram2[44]<=16'b0;
	ram2[45]<=16'b0;
	ram2[46]<=16'b0;
	ram2[47]<=16'b0;
	ram2[48]<=16'b0;
	ram2[49]<=16'b0;
	ram2[50]<=16'b0;
	ram2[51]<=16'b0;
	ram2[52]<=16'b0;
	ram2[53]<=16'b0;
	ram2[54]<=16'b0;
	ram2[55]<=16'b0;
	ram2[56]<=16'b0;
	ram2[57]<=16'b0;
	ram2[58]<=16'b0;
	ram2[59]<=16'b0;
	ram2[60]<=16'b0;
	ram2[61]<=16'b0;
	ram2[62]<=16'b0;
	ram2[63]<=16'b0;
end
else if(wr_rd==1)
	ram2[wr_addr]<=data_in;
else
	ram2[wr_addr]<=ram2[wr_addr];

always@(posedge clk or negedge rst_n)
if(!rst_n)
begin
	ram3[0]<=16'b0;
	ram3[1]<=16'b0;
	ram3[2]<=16'b0;
	ram3[3]<=16'b0;
	ram3[4]<=16'b0;
	ram3[5]<=16'b0;
	ram3[6]<=16'b0;
	ram3[7]<=16'b0;
	ram3[8]<=16'b0;
	ram3[9]<=16'b0;
	ram3[10]<=16'b0;
	ram3[11]<=16'b0;
	ram3[12]<=16'b0;
	ram3[13]<=16'b0;
	ram3[14]<=16'b0;
	ram3[15]<=16'b0;
end
else if(mode == 2'b0 && wr_rd == 0)
	ram3[wr_addr]<=data_in;
else
	ram3[wr_addr]<=ram3[wr_addr];

always@(posedge clk or negedge rst_n)
if(!rst_n)
begin
	ram4[0]<=16'b0;
	ram4[1]<=16'b0;
	ram4[2]<=16'b0;
	ram4[3]<=16'b0;
	ram4[4]<=16'b0;
	ram4[5]<=16'b0;
	ram4[6]<=16'b0;
	ram4[7]<=16'b0;
	ram4[8]<=16'b0;
	ram4[9]<=16'b0;
	ram4[10]<=16'b0;
	ram4[11]<=16'b0;
	ram4[12]<=16'b0;
	ram4[13]<=16'b0;
	ram4[14]<=16'b0;
	ram4[15]<=16'b0;
end
else if(mode == 2'b0 && wr_rd == 1)
	ram4[wr_addr]<=data_in;
else
	ram4[wr_addr]<=ram4[wr_addr];


always@(posedge clk or negedge rst_n)
if(!rst_n)
	data_out<=16'b0;
else if(mode == 2'b01 && wr_rd == 0)
	data_out<=ram2[rd_addr];
else if(mode == 2'b01)
	data_out<=ram1[rd_addr];
else if(mode == 2'b0 && wr_rd == 0)
	data_out<=ram4[rd_addr];
else if(mode == 2'b0)
	data_out<=ram3[rd_addr];

endmodule


