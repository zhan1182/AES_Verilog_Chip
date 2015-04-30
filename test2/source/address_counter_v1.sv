// $Id: $
// File name:   address_counter.sv
// Created:     2/2/2015
// Author:      Xinjie Lei
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Flexible and Scalable Counter with Controlled Rollover
module address_counter
  #(
    NUM_CNT_BITS = 8
    )
   (
    input wire 				clk,
    input wire 				n_rst,
    input wire 				load,
    input wire 				enable,
    input wire [(NUM_CNT_BITS - 1) : 0] loc,
    input wire [(NUM_CNT_BITS - 1) : 0] s_addr,
    output reg [(NUM_CNT_BITS - 1) : 0] addr,
    output reg 				d_flag
    );
   
   reg [(NUM_CNT_BITS - 1) : 0] 	next_addr;
   reg [(NUM_CNT_BITS - 1) : 0] 	cnt;
   reg [(NUM_CNT_BITS - 1) : 0] 	ncnt;
   
   always_ff @ (posedge clk, negedge n_rst) begin
      if(!n_rst) begin
	 addr <= 8'b0;
	 cnt <= 8'b0;
      end
      if(load) begin
	 addr <= s_addr;
	 cnt <= 8'b0;
      end
      else  begin
	 addr <= next_addr;
	 cnt  <= ncnt;
	 
      end
   end
   
   always_comb begin
      next_addr = addr;
      ncnt = cnt;
      if(enable && !d_flag) begin
	 next_addr = addr + 8;
	 ncnt = cnt + 8;
      end	
   end
   
  assign d_flag = (cnt >= loc && (cnt != 0) && (loc != 0)) ? 1'b1:1'b0;
   
endmodule





