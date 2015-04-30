// $Id: $
// File name:   AES_Controller.sv
// Created:     4/20/2015
// Author:      Xinjie Lei
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: AES main controller
module AES_Controller
  (
   input wire 	      clk,
   input wire 	      n_rst,
   input wire 	      start,
   input wire [127:0] usr_key,
   input wire [7:0]   usr_addr,
   input wire [7:0]   usr_loc,
   input wire 	      mode,
   input wire 	      en_d,
   input wire 	      de_d,
   input wire 	      key_d,
   output reg [127:0] key,
   output reg [7:0]   s_addr,
   output reg [7:0]   loc,
   output reg 	      en_or_de,
   output reg 	      key_en,
   output reg 	      con_en,
   output reg 	      AES_done,
   output reg 	      aes_clk,
   output reg 	      mem_clr,
   output reg 	      co_n_rst
   );
   assign aes_clk = clk;
   typedef enum bit [2:0] {idle, reset, key_expand, encryption, decryption, done} stateType;
   stateType state, nextstate;
   //next state logic
   always_comb begin
      nextstate = state;
      case(state)
	idle : begin
	   if(start) begin
	      nextstate = reset;
	   end
	end
	reset : begin
	   nextstate = key_expand;
	end
	key_expand : begin
	   if(key_d && !mode) begin
	      nextstate = encryption;
	   end
	   else if(key_d && mode) begin
	      nextstate = decryption;
	   end
	end
	encryption : begin
	   if(en_d) begin
	      nextstate = done;
	   end
	end
	decryption : begin
	   if(de_d) begin
	      nextstate = done;
	   end
	end
	done : begin
	   if(!start) begin
	   nextstate = idle;
	   end
	end
     endcase 
   end // always_comb
   
    //D-flip-flop
   always_ff @ (posedge clk, negedge n_rst) begin
      if(!n_rst)begin
	 state <= idle;
      end
      else begin
	 state <= nextstate;
      end 
   end 

   //output logic
   always_comb begin
      en_or_de = 1'b0;
      con_en = 1'b0;
      s_addr = 8'b0;
      loc = 8'b0;
      key = 128'b0;
      key_en = 1'b0;
      AES_done = 1'b0;
      mem_clr = 1'b0;
      co_n_rst = 1'b1;
      if(state == reset) begin
	 co_n_rst = 1'b0;
      end
      if(state == key_expand) begin
	 key_en = 1'b1;
	 key = usr_key;
	 if(mode == 1'b0) begin
	    mem_clr = 1'b1;
	 end
      end
      if(state == encryption) begin
	 con_en = 1'b1;
	 s_addr = usr_addr;
	 loc = usr_loc;
	 key = usr_key;
      end
      if(state == decryption) begin
	 con_en = 1'b1;
	 en_or_de = 1'b1;
	 s_addr = usr_addr;
	 loc = usr_loc;
	 key = usr_key;
      end
      if(state == done) begin
	 AES_done = 1'b1;
      end
   end // always_comb
endmodule // AES_Controller

