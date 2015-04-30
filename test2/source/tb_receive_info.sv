// $Id: $
// File name:   tb_receive_info.sv
// Created:     4/19/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for receiving info



module tb_receive_info();
  
  localparam CLK_PERIOD = 10;
  
  integer tb_default_test_num = 0;
  //integer ct;
  
  reg tb_clk;
  reg tb_n_rst;
  
  reg tb_start;
  reg tb_serial_in;
  reg [136:0] tb_parallel_out;
  
  reg [127:0] key;
  reg [7:0] address;
  reg mode;
  
  assign key = 128'h6c756b65696d796f7572666174686572;
  assign address = 8'b11110000;
  assign mode = 1'b1;
  
  
  receive_info RECEIVE_INFO(
    .clk(tb_clk),
    .n_rst(tb_n_rst),
    .shift_enable(tb_start),
    .serial_in(tb_serial_in),
    .parallel_out(tb_parallel_out)
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
	
	
	integer ct;
	
	initial
	begin
	  
	  tb_n_rst = 1'b0;
	  tb_start = 1'b0;
	  
	  #(CLK_PERIOD);
	  
	  for(ct = 0; ct < 137; ct = ct + 1)
	  begin
	    tb_n_rst = 1'b1;
	    tb_start = 1'b1; 
	    tb_serial_in = key[136 - ct];
	    #(CLK_PERIOD);
	  end
	  
	  for(ct = 0; ct < 8; ct = ct + 1)
	  begin
	    tb_serial_in = address[7 - ct];
	    #(CLK_PERIOD);
	  end
	  
	  tb_serial_in = mode;
	  
	end 
  
endmodule























