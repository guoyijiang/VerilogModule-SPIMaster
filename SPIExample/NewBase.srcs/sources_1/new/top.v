`timescale 1ns / 1ps

module top(
    input wire clk,
    input wire crystal_clk,
	output wire si5351_scl,
	inout wire si5351_sda,
	input wire [7:0] ad9288_a,
	input wire [7:0] ad9288_b,
	output reg [9:0] dac5652a_a,
	output reg [9:0] dac5652a_b,
	output reg [7:0] led,
	
	output wire CS_ADS8860,
	input  wire DI_ADS8860,
	output wire SCK_ADS8860,
	
	output wire CS_DAC8811,
    output wire DO_DAC8811,
    output wire SCK_DAC8811	,
    
	output wire CS_ADS7883A,
	input  wire DI_ADS7883A,
	output wire SCK_ADS7883A,
	output wire CS_ADS7883B,
    input  wire DI_ADS7883B,
    output wire SCK_ADS7883B
    );
    

//clk
    Si5351_Init clk_init(
        .clk(crystal_clk),
        .sclx(si5351_scl),
        .sda(si5351_sda)
    );
//rst
    reg rst;
    reg [7:0]rstDelay;
    initial begin
        rst = 1'b0;
        rstDelay = 8'b0;
    end
    always@(posedge clk)
    begin
        if (rstDelay == 8'd10) rst <= 1'b1;
        if(rst == 0)rstDelay <= rstDelay + 8'b1;
    end
    
    wire [15:0] ads8860_dataIn;
    wire [15:0] dac8811_dataOut;
    wire [11:0] ads7883_dataIn;   
    //assign dac8811_dataOut = {ads7883_dataIn,4'd0};
    assign dac8811_dataOut = ads8860_dataIn;
//ADS8860    T=1060ns f = 943.4kSPS
reg adSampleState = 'd0;
wire sampleEn = ~adSampleState;
//wire adDelayCo;
//always@(posedge clk) begin
//    case(adSampleState)
//        1'b0:   adSampleState <= 'd1;
//        1'b1:   if(adDelayCo) adSampleState <= 'd0;
//    endcase
//end
//Counter #(110) adDelayCnt(clk, ~rst,adSampleState, , adDelayCo);
	reg adSampleEn;
	wire SampleFinished;
	reg cs_ad_l;
    reg [9:0]adDelayCnt;
    always@(posedge clk) begin
        cs_ad_l<= CS_ADS8860;
    end
    assign SampleFinished = CS_ADS8860 & (~cs_ad_l);
always@(posedge clk) begin
    if(~rst)
    begin
        adDelayCnt <= 10'd0;
        adSampleEn <= 1'b1;
    end
    else 
    begin
        if(SampleFinished)
            adDelayCnt <= 10'd80;
        else if(adDelayCnt != 10'd0) adDelayCnt <= adDelayCnt -10'd1;
        if(adDelayCnt == 10'd1)    adSampleEn <= 1'b1;
        else adSampleEn <= 1'b0;
    end
end

SPIMaster #(
         .HBDIV(1),  // half bit divider
         .BITS(16),  // 16
         .CSDN(71), 
         .CSUN(2), 
         .SCKINT(1'b0), 
         .SPEDGE(1'b0)  // 0 for 1stEdge_Sample    1 for 2thEdge_Sample
    )ads8860_inst(
        .clk(clk), 
        .rst(~rst), 
        .start(adSampleEn), 
        .dataOut(16'haaaa), 
        .dataIn(ads8860_dataIn), 
        .finish(), 
        .working(), 
        .sck(SCK_ADS8860), 
        .sdo(), 
        .cs(CS_ADS8860), 
        .sdi(DI_ADS8860)
    );
//DSC8811  T= 360ns f= 2.78MSPS
    SPIMaster #(
             .HBDIV(1),  // half bit divider
             .BITS(16),  // 16
             .CSDN(1), 
             .CSUN(1), 
             .SCKINT(1'b1), 
             .SPEDGE(1'b1)  // 0 for 1stEdge_Sample    1 for 2thEdge_Sample
        )dac8811_inst(
            .clk(clk), 
            .rst(~rst), 
            .start(1'b1), 
            .dataOut(dac8811_dataOut), 
            .dataIn(), 
            .finish(), 
            .working(), 
            .sck(SCK_DAC8811), 
            .sdo(DO_DAC8811), 
            .cs(CS_DAC8811), 
            .sdi(1'd1)
        );
//ADS7883 f= 5MSPS
    ads7883_5M_En(
       .clk(clk),
       .rst(rst),
       .workEn(1'd1),
       .finished5M(),
       .recivData(ads7883_dataIn),
       .CS_A(CS_ADS7883A),
       .SCK_A(SCK_ADS7883A),
       .MISO_A(DI_ADS7883A),
       .CS_B(CS_ADS7883B),
       .SCK_B(SCK_ADS7883B),
       .MISO_B(DI_ADS7883B)
    );
//HIADDA
    reg signed [7:0] data_a,data_b;
    always@(posedge clk)begin
        data_a <= ad9288_a;
        data_b <= ad9288_b;
        dac5652a_a[9:0] <= ads8860_dataIn[15:6];
        dac5652a_b[9:0] <= ads7883_dataIn[11:2];
    end
endmodule
