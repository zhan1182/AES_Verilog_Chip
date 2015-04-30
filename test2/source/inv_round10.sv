// $Id: $
// File name:   inv_round10.sv
// Created:     4/25/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: inverse round 10

module inv_round10
(
  input wire clk,
  input wire n_rst,
  input wire [0:15][7:0] data_in,
  input wire [0:3][31:0] round_key,
  output reg [0:15][7:0] data_out
);

reg [0:15][7:0] inv_subByte_out;


reg [0:15][7:0] inv_addRoundKey_in;



inv_sub_byte INV_ROUND_SUB_BYTE
(
  .state_array_in(data_in),
  .state_array_out(inv_subByte_out)
);


inv_add_roundkey INV_ROUND_ADDKEY
(
  .state_array_in(inv_addRoundKey_in),
  .round_key(round_key),
  .state_array_out(data_out)
);



always_ff @ (posedge clk, negedge n_rst)
begin
  if(n_rst == 1'b0)
  begin
    inv_addRoundKey_in <= '{'{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}, '{ 0, 0, 0, 0, 0, 0, 0, 0}};
  end
  else
  begin
    inv_addRoundKey_in <= inv_subByte_out;
  end
end


endmodule
