// $Id: $
// File name:   flex_counter.sv
// Created:     2/5/2015
// Author:      Xihui Wang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: flexible counter.

module flex_counter_spi
  (
   input wire 	      clk,
   input wire 	      n_rst,
   input wire 	      clear,
   input wire 	      count_enable,
   input wire [7 : 0] rollover_val,
   //output reg [NUM_CNT_BITS-1:0] count_out,
   output reg 	      rollover_flag
   );
   reg [7 : 0] 	      count_out;   
   reg [7 : 0] 	      ncnt;
   reg 		      flag;

   assign rollover_flag = (n_rst == 0)? 1'b0 : flag;
   
   
   always @ (posedge clk, negedge n_rst)
     begin
	if (n_rst == 0)
	  begin     
	     count_out <= 0;
	     //rollover_flag <= 0;	     
	  end
	else
	  begin
	     count_out <= ncnt;
	     //rollover_flag <= flag;	     
	  end
     end // always @ (posedge clk, negedge n_rst)

   
   always_comb
     begin
	ncnt = 0;	
	flag = 0;
	
	if (clear == 1)
	  begin
	     ncnt = 0;	
	  end     
	else if (count_enable == 1)
	  begin
	     if (count_out == rollover_val)
	       begin
		  ncnt = 1;
	       end
	     else
	       begin
		  ncnt = count_out + 1;
	       end
	     
	     if (count_out == rollover_val)// - 1)
	       begin
		  flag = 1;
	       end
	     else
	       begin
		  flag = 0;
	       end	     
	  end // if (count_enable == 1)
	else
	  begin
	     ncnt=count_out;
	     flag=rollover_flag;	     
	  end // else: !if(count_enable == 1)
	
     end // always_comb   
endmodule
