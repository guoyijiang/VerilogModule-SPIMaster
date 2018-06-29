`timescale 1 ns / 1 ns
module testbench();
  
  reg clk;
  reg rst;
  reg [7:0]delay;
  //clk
  initial begin
  clk = 1'b1;
  rst = 1'b0;
  delay = 8'b0;
  end
  always #5 clk <=~clk;
    always@(posedge clk)
    begin
        if (delay == 8'd2) rst <= 1'b1;
        if(rst == 0 ) delay <= delay + 8'b1;
    end

wire CS_A;
wire SCK_A;
wire SDO_A;
wire SDI_A;
wire busy;

wire CS_B;
wire SCK_B;
wire SDO_B;
wire SDI_B;

assign SDI_A = SDO_B;
assign SDI_B = SDO_A;

reg startEn;
reg [15:0]dataOut_A;
wire [15:0]dataIn_A;
reg [15:0]dataOut_B;
wire [15:0]dataIn_B;

reg [15:0]data_da;
initial begin
  #200
  
  dataOut_A = 16'h1234;
  dataOut_B = 16'h5678;
  data_da = 16'haaaa;
  startEn = 1'd1;
  #2000 startEn = 1'd0;
  #2000
  
  dataOut_A = 16'haaaa;
  dataOut_B = 16'h5555;
  startEn = 1'd1;        
  #10 startEn = 1'd0;
  
  #2000 $stop;
end

SPIMaster #(
    .HBDIV(1), // half bit divider
    .BITS(16), // 16 
    .CSDN(1),
    .CSUN(1),
	  .SCKINT(1'b0), 
	  .SPEDGE(1'b0)  // 0 for 1stEdge_Sample	1 for 2thEdge_Sample
)SPIMaster_A(
    .clk(clk), 
    .rst(~rst), 
    .start(startEn),
    .dataOut(dataOut_A),    
    .dataIn(dataIn_A),
    .working(busy),
    .sck(SCK_A), 
    .sdo(SDO_A), 
    .cs(CS_A),
	  .sdi(SDI_A)
);

SPIMaster #(
    .HBDIV(1), // half bit divider
    .BITS(16), // 16 
    .CSDN(1),
    .CSUN(1),    
	  .SCKINT(1'b0), 
	  .SPEDGE(1'b0)  // 0 for 1stEdge_Sample	1 for 2thEdge_Sample
)SPIMaster_B(
    .clk(clk), 
    .rst(~rst), 
    .start(startEn),
    .dataOut(dataOut_B),    
    .dataIn(dataIn_B),
    .working(),
    .sck(SCK_B), 
    .sdo(SDO_B), 
    .cs(CS_B),
	  .sdi(SDI_B)
);



wire sck_da;
wire sdo_da;
wire cs_da;

 DACx811 #(
    .HBDIV(5), // half bit divider
    .BITS(16)  // 16 for 8811, 12 for 7811
 )dac8811_inst(
    .clk(clk), 
    .rst(~rst), 
    .start(startEn),
    .data(data_da),
    .busy(),
    .sck(sck_da), 
    .sdo(sdo_da), 
    .cs_n(cs_da)
);

endmodule 
