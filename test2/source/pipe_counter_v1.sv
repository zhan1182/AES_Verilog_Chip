// $Id: $
// File name:   pipe_counter.sv
// Created:     4/21/2015
// Author:      Xinjie Lei
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Pipeline 40 counter
module pipe_counter
  #(
    NUM_CNT_BITS = 6,
    NUM_TO_COUNT = 39
    )
   (
    input wire clk,
    input wire count_enable,
    output reg done_flag
    );

   reg [(NUM_CNT_BITS - 1):0] count;
   reg [(NUM_CNT_BITS - 1):0] next_count;


   always_ff @ (posedge clk)
     begin
	count <= next_count;
     end
   
   always_comb
     begin
	if(count_enable == 1'b1)
	  begin
	     if(count == NUM_TO_COUNT) begin
		next_count = count;
	     end
	     else begin
	     next_count = count + 1;
	     end
	  end
	else
	  begin
	     next_count = 0;
	  end
     end

   assign done_flag = (count == NUM_TO_COUNT) ? 1'b1:1'b0;
   
endmodule
