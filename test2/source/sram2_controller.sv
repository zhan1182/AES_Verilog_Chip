// $Id: $
// File name:   sram2_controller.sv
// Created:     4/23/2015
// Author:      Xinjie Lei
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: sram2 controller
module sram2_controller
  (
   input wire 	    clk,
   input wire 	    enable,
   input wire n_rst,
   input wire 	    en_or_de,
   input wire [7:0] s_addr,
   input wire [7:0] loc,
   input wire 	    flag_40,
   output reg 	    r_en,
   output reg 	    w_en,
   output reg [7:0] addr,
   output reg 	    en_fin
   );
   reg 		    r_c_en;
   reg 		    w_c_en ;
   reg 		    r_done;
   reg 		    w_done;
   reg 		    r_n_rst;
   reg 		    w_n_rst;
   reg 		    load;
   reg [7:0] 	    r_addr;
   reg [7:0] 	    w_addr;
   
   assign addr = (en_or_de) ? r_addr : w_addr;
   assign r_en = r_c_en && !r_done;
   assign w_en = w_c_en && !w_done;
   
   address_counter #(.NUM_CNT_BITS(8)) r_addr_counter(.clk(clk), .n_rst(r_n_rst), .load(load), .enable(r_c_en), .loc(loc), .s_addr(s_addr), .addr(r_addr), .d_flag(r_done));
   address_counter #(.NUM_CNT_BITS(8)) w_addr_counter(.clk(clk), .n_rst(w_n_rst), .load(load), .enable(w_c_en), .loc(loc), .s_addr(s_addr), .addr(w_addr), .d_flag(w_done));
   typedef enum      bit [2:0] {idle, read, write, r_wait, w_wait} stateType;
   stateType state, nextstate;
   
   //next state logic
   always_comb begin
      nextstate = state;
      case(state)
	idle : begin
	   if(enable && en_or_de == 1'b1) begin
	      nextstate = read;
	   end
	   else if(enable && en_or_de == 1'b0 && flag_40 == 1'b1) begin
	      nextstate = write;
	   end
	end
	read : begin
	   if(r_done) begin
	      nextstate = r_wait;
	   end
	end
	r_wait : begin
	   if(enable == 1'b0) begin
	      nextstate = idle;
	   end
	end
	write : begin
	   if(w_done) begin
	      nextstate = w_wait;
	   end
	end
	w_wait : begin
	   if(enable == 1'b0) begin
	      nextstate = idle;
	   end
	end
      endcase
   end // always_comb
   
   //D-flip-flop
   always_ff @ (posedge clk, negedge n_rst) begin
      if(!n_rst) begin
	 state <= idle;
      end
      else begin
	 state <= nextstate;
      end
   end 

   //output logic
   always_comb begin
      en_fin = 1'b0;
      r_c_en = 1'b0;
      w_c_en = 1'b0;
      r_n_rst = 1'b1;
      w_n_rst = 1'b1;
      load = 1'b0;
      if(state == idle) begin
	 load = 1'b1;
      end
      if(state == read) begin
	 r_c_en = 1'b1;
      end
      if(state == r_wait) begin
	 r_n_rst = 1'b0;
      end
      if(state == write) begin
	 w_c_en = 1'b1;
      end
      if(state == w_wait) begin
	 w_n_rst = 1'b0;
	 en_fin = 1'b1;
      end
   end // always_comb
endmodule

