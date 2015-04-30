// $Id: $
// File name:   shift_row.sv
// Created:     4/1/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: shift row


module shift_row
(
  input wire [7:0] state_array_in[0:15],
  output reg [7:0] state_array_out[0:15]
);

assign state_array_out[0] = state_array_in[0];
assign state_array_out[1] = state_array_in[5];
assign state_array_out[2] = state_array_in[10];
assign state_array_out[3] = state_array_in[15];
assign state_array_out[4] = state_array_in[4];
assign state_array_out[5] = state_array_in[9];
assign state_array_out[6] = state_array_in[14];
assign state_array_out[7] = state_array_in[3];
assign state_array_out[8] = state_array_in[8];
assign state_array_out[9] = state_array_in[13];
assign state_array_out[10] = state_array_in[2];
assign state_array_out[11] = state_array_in[7];
assign state_array_out[12] = state_array_in[12];
assign state_array_out[13] = state_array_in[1];
assign state_array_out[14] = state_array_in[6];
assign state_array_out[15] = state_array_in[11];


endmodule