
module Counter #(parameter M = 100)(
    input wire clk, rst, en,
    output reg [$clog2(M) - 1 : 0] cnt,
    output wire co
);
    initial begin cnt <= '0; end
    always@(posedge clk) begin
        if(rst) cnt <= '0;
        else if(en) begin
            if(cnt < M - 1) cnt <= cnt + 1'b1;
            else cnt <= '0;
        end
    end
    assign co = en & (cnt == M - 1);
endmodule

module SPIMaster #(
	parameter HBDIV = 1, // half bit divider
	parameter BITS = 16, // 16
	parameter CSDN = 1,
	parameter CSUN = 1,
	parameter SCKINT = 1'b1, 
	parameter SPEDGE = 1'b0  // 0 for 1stEdge_Sample	1 for 2thEdge_Sample
)(
    input wire clk, rst, start,
    input wire [BITS - 1 : 0] dataOut,
	output reg [BITS - 1 : 0] dataIn = '0,
	output reg finish ='0; //no
    output reg working = '0,
    output reg sck, sdo, cs,
	input wire sdi
);
	reg busy = '0;
    wire hbr_co, hbc_co;
	wire csd_co, csu_co;
    wire [$clog2(BITS * 2 + 1) - 1 : 0] hbc_cnt;
    reg [BITS -1: 0] shifterOut = '0;
	reg [BITS -1: 0] shifterIn  = '0;
    Counter #(HBDIV) hbRateCnt(clk, rst, busy, , hbr_co);
    Counter #(BITS * 2 + 1) hbCnt(clk, rst, hbr_co, hbc_cnt, hbc_co);
	
	//state
	reg [1:0]stateSPI = '0;
	always@(posedge clk)begin
		case(stateSPI)
			'd0:if(start)begin
					working <= 'd1;
					stateSPI<= 'd1;
				end
			'd1:if(csd_co)begin
					busy <= 'd1;
					stateSPI<= 'd2;
				end
			'd2:if(hbc_co)begin
					busy <= 1'b0;
					stateSPI<= 'd3;
				end
			'd3:if(csu_co)begin
					working <= 'd0;
					stateSPI<= 'd0;
				end
		endcase
	end
	Counter #(CSDN) csdCnt(clk, rst, (stateSPI=='d1), , csd_co);
	Counter #(CSUN) csuCnt(clk, rst, (stateSPI=='d3), , csu_co);
    
	//out
	reg sEn = '0;
    always@(posedge clk)
    begin
        if(rst) shifterOut <= '0;
        else if(start&(stateSPI=='d0)) shifterOut <= dataOut;
		else begin
			if(SPEDGE) begin // 2thEdge_Sample
				if(hbr_co & (~hbc_cnt[0]) & (hbc_cnt != 'd0)) shifterOut <= shifterOut << 1;
			end
			else begin//1stEdge_Sample				
				if(hbr_co & ( hbc_cnt[0]) & (hbc_cnt != (BITS*2-1))) shifterOut <= shifterOut << 1;
			end
		end
        
    end
	
	//in
    always@(posedge clk)
    begin
        if(rst) shifterIn <= '0;
        else if(~busy) dataIn <= shifterIn[BITS-1:0];
		else begin
			if(SPEDGE) begin// 2thEdge_Sample
				if(hbr_co & ( hbc_cnt[0])) sEn <= 1'd1;
				else if(sEn) begin
					shifterIn <= {shifterIn[BITS-2:0],sdi};
					sEn <= 1'd0;
				end	
			end
			else begin //1stEdge_Sample				
				if(hbr_co & (~hbc_cnt[0]))sEn <= 1'd1;
				else if(sEn) begin
					shifterIn <= {shifterIn[BITS-2:0],sdi};
					sEn <= 1'd0;
				end
			end
		end      
    end	
	
	//port
    always@(posedge clk)
    begin
        sck <= busy ? (SCKINT^hbc_cnt[0]):SCKINT;
        cs <= ~working;
        sdo <= shifterOut[BITS-1];
    end
endmodule

