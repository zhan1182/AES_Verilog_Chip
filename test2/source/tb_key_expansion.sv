// $Id: $
// File name:   tb_key_expansion.sv
// Created:     3/31/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test banch for key expansion

`timescale 1ns / 10ps

module tb_key_expansion();
  
  localparam CLK_PERIOD = 10;
  
  integer tb_default_test_num = 0;
  
  reg tb_clk;
  
  //wire [7:0] tb_key[0:15];
  reg [0:43][31:0] tb_key_schedule;
  
  // set key as lukeimyourfather
  /*
  assign tb_key[0] = 8'h6c;
  assign tb_key[1] = 8'h75;
  assign tb_key[2] = 8'h6b;
  assign tb_key[3] = 8'h65;
  assign tb_key[4] = 8'h69;
  assign tb_key[5] = 8'h6d;
  assign tb_key[6] = 8'h79;
  assign tb_key[7] = 8'h6f;
  assign tb_key[8] = 8'h75;
  assign tb_key[9] = 8'h72;
  assign tb_key[10] = 8'h66;
  assign tb_key[11] = 8'h61;
  assign tb_key[12] = 8'h74;
  assign tb_key[13] = 8'h68;
  assign tb_key[14] = 8'h65;
  assign tb_key[15] = 8'h72;
  */
  
  reg [127:0] tb_key = 128'h6c756b65696d796f7572666174686572; // the order of bits does matter
  
  
  key_expansion KEY_EXPAN(
  .key_in(tb_key),
  .key_schedule(tb_key_schedule));

  
  //Generate Clock Signal
  always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	
	initial
	begin
	  
	   #(CLK_PERIOD);
	  
	  // Test Case 1, test word 0
	  
	  if ( tb_key_schedule[0] == 32'h6c756b65)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED", tb_default_test_num);
			
		//#(CLK_PERIOD);	
		
		// Test Case 2, test word 1
	  
	  if ( tb_key_schedule[1] == 32'h696d796f)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED", tb_default_test_num);
			
		//#(CLK_PERIOD);	
			
		// Test Case 3, test word 2
	  
	  if ( tb_key_schedule[2] == 32'h75726661)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED", tb_default_test_num);
			
		//#(CLK_PERIOD);	
			
		// Test Case 4, test word 3
	  
	  if ( tb_key_schedule[3] == 32'h74686572)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED", tb_default_test_num);
			
			
		//#(CLK_PERIOD);	
			
		// Test Case 5, test word 4
	  
	  if ( tb_key_schedule[4] == 32'h28382bf7)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED", tb_default_test_num);


	  
	end

endmodule