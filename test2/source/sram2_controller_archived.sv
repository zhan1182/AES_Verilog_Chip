// $Id: $
// File name:   sram2_controller.sv
// Created:     4/19/2015
// Author:      Xinjie Lei
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: SRAM2 controller
module sram2_controller
  (
   input wire clk,
   input wire enable,
   input wire en_or_de,
   input wire [7:0] s_addr,
   input wire [7:0] loc,
   input wire flag_40,
   output wire r_en,
   output wire w_en,
   output wire [7:0] r_addr,
   output wire [7:0] w_addr,
   output wire en_fin
   );
   reg r_done;
   
   assign r_en = (en_or_de == 1) ? enable && !r_done: 0;
   assign w_en = (en_or_de == 0) ? (enable && flag_40 && !en_fin) : 0;
   
   address_counter #(.NUM_CNT_BITS(8)) r_addr_counter(.clk(clk), .enable(enable), .loc(loc), .s_addr(s_addr), .addr(r_addr), .d_flag(r_done));
   address_counter #(.NUM_CNT_BITS(8)) w_addr_counter(.clk(clk), .enable(w_en), .loc(loc), .s_addr(s_addr), .addr(w_addr), .d_flag(en_fin));
   
endmodule // sram2_controller
