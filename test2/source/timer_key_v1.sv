// $Id: $
// File name:   timer_key.sv
// Created:     4/19/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: timer to count clocks to generate key schedule


module timer_key
(
  input wire clk,
  input wire key_enable,
  output reg key_done
);


flex_counter #(.NUM_CNT_BITS(4),.NUM_TO_COUNT(8)) COUNT_TO_EIGHT
(
  .clk(clk), 
  .count_enable(key_enable), 
  .done_flag(key_done)
);



endmodule
