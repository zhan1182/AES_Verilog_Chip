// $Id: $
// File name:   flex_stp_sr.sv
// Created:     4/19/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: serial to parallel shift register

module receive_info
(
  input wire clk,
  input wire n_rst,
  input wire shift_enable,  // just the start signal
  input wire serial_in,
  output reg [127:0] key,
  output reg [7:0] address,
  output reg [7:0] location,
  output reg mode
);  


// MSB
// If enabled, get 1 bit of information per clock
// 128 bits key, 8 bits address, 1 bit en/de mode

reg []
   

always_ff @ (posedge clk, negedge n_rst)
begin
  if(n_rst == 1'b0)
  begin
    parallel_out <= '0;
  end
  else
  begin
    if(shift_enable == 1'b1)
    begin
      parallel_out <= {parallel_out[135:0], serial_in};
    end
    else
    begin
      parallel_out <= parallel_out;
    end
  end
end







endmodule






