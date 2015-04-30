// $Id: $
// File name:   flex_counter_project.sv
// Created:     4/19/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: simple flex counter for project


module flex_counter_project
#(
   NUM_CNT_BITS = 4,
   NUM_TO_COUNT = 8
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
    next_count = count + 1;
  end
  else
  begin
    next_count = 0;
  end
end

assign done_flag = (count == NUM_TO_COUNT) ? 1'b1:1'b0;
  
endmodule