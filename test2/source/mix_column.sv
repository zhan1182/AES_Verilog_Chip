// $Id: $
// File name:   mix_column.sv
// Created:     4/1/2015
// Author:      Jinyi Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: mix column

module mix_column
(
  input wire [0:15][7:0] state_array_in,
  output wire [0:15][7:0] state_array_out
);


reg [0:3][7:0] row1;
reg [0:3][7:0] row2;
reg [0:3][7:0] row3;
reg [0:3][7:0] row4;


reg [0:3][7:0] row5;
reg [0:3][7:0] row6;
reg [0:3][7:0] row7;
reg [0:3][7:0] row8;

reg [7:0] factor1;
reg [7:0] factor2;

integer ct;

assign row1 = '{state_array_in[0], state_array_in[4], state_array_in[8], state_array_in[12]};   // add the '{}
assign row2 = '{state_array_in[1], state_array_in[5], state_array_in[9], state_array_in[13]};
assign row3 = '{state_array_in[2], state_array_in[6], state_array_in[10], state_array_in[14]};
assign row4 = '{state_array_in[3], state_array_in[7], state_array_in[11], state_array_in[15]};

always_comb
begin
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    factor1 = (row1[ct][7] == 1'b0) ? {row1[ct][6:0], 1'b0} : ({row1[ct][6:0], 1'b0} ^ (8'b00011011));
    factor2 = ((row2[ct][7] == 1'b0) ? {row2[ct][6:0], 1'b0} : ({row2[ct][6:0], 1'b0} ^ (8'b00011011))) ^ row2[ct];
    row5[ct] = factor1 ^ factor2 ^ row3[ct] ^ row4[ct];    
  end
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    factor1 = (row2[ct][7] == 1'b0) ? {row2[ct][6:0], 1'b0} : ({row2[ct][6:0], 1'b0} ^ (8'b00011011));
    factor2 = ((row3[ct][7] == 1'b0) ? {row3[ct][6:0], 1'b0} : ({row3[ct][6:0], 1'b0} ^ (8'b00011011))) ^ row3[ct];
    row6[ct] = row1[ct] ^ factor1 ^ factor2 ^ row4[ct];    
  end
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    factor1 = (row3[ct][7] == 1'b0) ? {row3[ct][6:0], 1'b0} : ({row3[ct][6:0], 1'b0} ^ (8'b00011011));
    factor2 = ((row4[ct][7] == 1'b0) ? {row4[ct][6:0], 1'b0} : ({row4[ct][6:0], 1'b0} ^ (8'b00011011))) ^ row4[ct];
    row7[ct] = row1[ct] ^ row2[ct] ^ factor1 ^ factor2;    
  end
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    factor1 = (row4[ct][7] == 1'b0) ? {row4[ct][6:0], 1'b0} : ({row4[ct][6:0], 1'b0} ^ (8'b00011011));
    factor2 = ((row1[ct][7] == 1'b0) ? {row1[ct][6:0], 1'b0} : ({row1[ct][6:0], 1'b0} ^ (8'b00011011))) ^ row1[ct];
    row8[ct] =  factor2 ^ row2[ct] ^ row3[ct] ^ factor1;    
  end
  
  // fix the for loop to assignment
  /*
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    state_array_out[4*ct] = row5[ct];
  end
  
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    state_array_out[4*ct+1] = row6[ct];
  end
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    state_array_out[4*ct+2] = row7[ct];
  end
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    state_array_out[4*ct+3] = row8[ct];
  end
  */

end



assign state_array_out[0] = row5[0];
assign state_array_out[1] = row6[0];
assign state_array_out[2] = row7[0];
assign state_array_out[3] = row8[0];

assign state_array_out[4] = row5[1];
assign state_array_out[5] = row6[1];
assign state_array_out[6] = row7[1];
assign state_array_out[7] = row8[1];

assign state_array_out[8] = row5[2];
assign state_array_out[9] = row6[2];
assign state_array_out[10] = row7[2];
assign state_array_out[11] = row8[2];

assign state_array_out[12] = row5[3];
assign state_array_out[13] = row6[3];
assign state_array_out[14] = row7[3];
assign state_array_out[15] = row8[3];

endmodule












