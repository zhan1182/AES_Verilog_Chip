// $Id: $
// File name:   inv_add_roundkey.sv
// Created:     4/9/2015
// Author:      Xihui Wang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: inverse add round key

module inv_add_roundkey
(
  input wire [0:15][7:0] state_array_in,
  input wire [0:3][31:0] round_key,
  output reg [0:15][7:0] state_array_out
);

reg [7:0] first;
reg [7:0] second;
reg [7:0] third;
reg [7:0] fourth;

integer ct;

always_comb
begin
  
  for(ct = 0; ct < 4; ct = ct+ 1)
  begin
    first = round_key[ct][31:24];
    second = round_key[ct][23:16];
    third = round_key[ct][15:8];
    fourth = round_key[ct][7:0];
    
    state_array_out[4*ct] = state_array_in[4*ct] ^ first;
    state_array_out[4*ct+1] = state_array_in[4*ct+1] ^ second; 
    state_array_out[4*ct+2] = state_array_in[4*ct+2] ^ third; 
    state_array_out[4*ct+3] = state_array_in[4*ct+3] ^ fourth; 
    
  end
end

endmodule