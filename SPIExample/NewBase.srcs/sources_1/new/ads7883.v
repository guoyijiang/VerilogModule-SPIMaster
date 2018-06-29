 module ads7883_2M5_En(
   clk,
   rst,
   workEn,
   finished,
   recivData,
   CS,
   SCK,
   MISO
);
input wire clk;
input wire rst;
input wire workEn;
output wire finished;
output reg[11:0]recivData;
output wire CS;
output wire SCK;
input wire MISO;

reg sck;
reg[5:0] adState;
reg[13:0] shiftBuf;
always@(posedge clk) begin
   if(~rst)    adState <= 6'd0;
   else  begin
       case(adState) 
           6'd0:    if(workEn)adState<= adState + 6'd1;
           6'd39:    adState <= 6'd0;
           default: adState<= adState + 6'd1;    
       endcase    
   end
end

assign CS = ~((adState >= 6'd1)&&(adState <= 6'd29));
assign finished = (adState == 6'd39);
//SCK
always@(posedge clk) begin
   if(~rst) begin
      recivData <= 12'd0;
      sck <= 1'd1;
      shiftBuf <= 14'd0;
   end
   else begin
       if((adState>6'd0)&&(adState<6'd29)&&(adState[0]==1'b0)) begin
         shiftBuf <= {shiftBuf[12:0],MISO};    
          sck <= 1'd0;
       end
       else sck <= 1'd1;
       if(adState==6'd29) recivData <= shiftBuf[11:0];
   end
end
assign SCK = sck;

endmodule

module ads7883_5M_En(
   clk,
   rst,
   workEn,
   finished5M,
   recivData,
   CS_A,
   SCK_A,
   MISO_A,
   CS_B,
   SCK_B,
   MISO_B
);
input wire clk;
input wire rst;
input wire workEn;
output reg finished5M;
output reg[11:0]recivData;
output wire CS_A;
output wire SCK_A;
input wire MISO_A;
output wire CS_B;
output wire SCK_B;
input wire MISO_B;


wire      finishedA;
wire      finishedB;
reg     workEnA;
reg     workEnB;
wire[11:0]recivDataA;
wire[11:0]recivDataB;
reg [5:0] delayCnt;

always@(posedge clk) begin
   if(finishedA|finishedB) finished5M <= 1'd1;
   else finished5M<= 1'd0;
end

always@(posedge clk) begin
   if(workEn) workEnA<= 1'b1;
   else workEnA<= 1'b0;
end

always@(posedge clk) begin
   if(~rst) delayCnt <= 6'd0;
   else begin
       if(delayCnt==6'd0) begin
           workEnB <= 1'b0;
           if(workEnA) delayCnt <= 6'd1;
       end
       else if(delayCnt < 6'd19) delayCnt<= delayCnt + 6'd1;
       else begin
           delayCnt <= 6'd0;
           workEnB <= 1'b1;
       end 
   end 
end

always@(posedge clk) begin
   if(~rst) recivData <= 12'd0;
   else begin
       if(finishedA)  recivData <= recivDataA;
       else if(finishedB)  recivData <= recivDataB;
   end 
end
ads7883_2M5_En ads7883_En_instA(
   .clk(clk),
   .rst(rst),
   .workEn(workEnA),
   .finished(finishedA),
   .recivData(recivDataA),
   .CS(CS_A),
   .SCK(SCK_A),
   .MISO(MISO_A)
);
ads7883_2M5_En ads7883_En_instB(
   .clk(clk),
   .rst(rst),
   .workEn(workEnB),
   .finished(finishedB),
   .recivData(recivDataB),
   .CS(CS_B),
   .SCK(SCK_B),
   .MISO(MISO_B)
);

endmodule
