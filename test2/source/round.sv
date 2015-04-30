// $Id: $
// File name:   round.sv
// Created:     4/8/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: one single round

// the data input here is after the first add round key


module round
(
  input wire clk,
  input wire n_rst,
  input wire [0:15][7:0] data_in,
  input wire [0:3][31:0] round_key,
  output reg [0:15][7:0] data_out
);

reg [0:15][7:0] subByte_out;
reg [0:15][7:0] mixColumn_in;
reg [0:15][7:0] mixColumn_out;
reg [0:15][7:0] addRoundKey_in;


sub_byte ROUND_SUB_BYTE
(
  .state_array_in(data_in),
  .state_array_out(subByte_out)
);

// combine shift row with sub byte


mix_column ROUND_MIX_COLUMN
(
  .state_array_in(mixColumn_in),
  .state_array_out(mixColumn_out)
);

add_roundkey ROUND_ADDKEY
(
  .state_array_in(addRoundKey_in),
  .round_key(round_key),
  .state_array_out(data_out)
);


always_ff @ (posedge clk, negedge n_rst)
begin
  if(n_rst == 1'b0)
  begin
    mixColumn_in <= '{'{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}};
    addRoundKey_in <= '{'{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}};
  end
  else
  begin
    mixColumn_in <= subByte_out;
    addRoundKey_in <= mixColumn_out;
  end
end


endmodule






