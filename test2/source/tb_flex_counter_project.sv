// $Id: $
// File name:   tb_flex_counter_project.sv
// Created:     4/19/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for flex counter project


module tb_flex_counter_project();
  
  localparam CLK_PERIOD = 10;
  
  integer tb_default_test_num = 0;
  //integer ct;
  
  reg tb_clk;
  reg tb_count_enable;
  reg tb_done_flag;


  flex_counter_project #(.NUM_CNT_BITS(6), .NUM_TO_COUNT(40)) COUNT_TO_EIGHT
  (
  .clk(tb_clk), 
  .count_enable(tb_count_enable), 
  .done_flag(tb_done_flag)
  );

  //Generate Clock Signal
  always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		tb_default_test_num = tb_default_test_num + 1;
		#(CLK_PERIOD/2.0);
	end
	
	initial
	begin
	  
	  tb_count_enable = 1'b0;
	  
	  #(CLK_PERIOD * 5);
	  
	  tb_count_enable = 1'b1;
	  
	  #(CLK_PERIOD * 40);
	  #(0.1);
	  
	  
	  if ( tb_done_flag == 1'b1)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED", tb_default_test_num);
	  
	  
	  tb_count_enable = 1'b0;
	  
	  
	end
		
	
endmodule

















