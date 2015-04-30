// $Id: $
// File name:   inv_mix_column.sv
// Created:     4/9/2015
// Author:      Xihui Wang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: inverse mix column



module inv_mix_column
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
reg [7:0] factor3;
reg [7:0] factor4;


integer ct;

assign row1 = '{state_array_in[0], state_array_in[4], state_array_in[8], state_array_in[12]};
assign row2 = '{state_array_in[1], state_array_in[5], state_array_in[9], state_array_in[13]};
assign row3 = '{state_array_in[2], state_array_in[6], state_array_in[10], state_array_in[14]};
assign row4 = '{state_array_in[3], state_array_in[7], state_array_in[11], state_array_in[15]};


always_comb
begin
  
  // Row 5
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    
    // MUL E, 00001110
    // Three items
    if(row1[ct][7:5] == 3'b000)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ {row1[ct][5:0], 2'b00} ^ {row1[ct][6:0], 1'b0};
    end
    else if(row1[ct][7:5] == 3'b001)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row1[ct][5:0], 2'b00} ^ {row1[ct][6:0], 1'b0};
    end
    else if(row1[ct][7:5] == 3'b010)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00110110) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00011011)) ^ {row1[ct][6:0], 1'b0};
    end
    else if(row1[ct][7:5] == 3'b011)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00101101) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00011011)) ^ {row1[ct][6:0], 1'b0};
    end
    else if(row1[ct][7:5] == 3'b100)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00110110)) ^ ({row1[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else if(row1[ct][7:5] == 3'b101)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00110110)) ^ ({row1[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else if(row1[ct][7:5] == 3'b110) // small fix here
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00101101)) ^ ({row1[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00101101)) ^ ({row1[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    
    
    
    // MUL B, 00001011
    // Three items in total
    if(row2[ct][7:5] == 3'b000)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ {row2[ct][6:0], 1'b0} ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b001)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row2[ct][6:0], 1'b0} ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b010)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00110110) ^ {row2[ct][6:0], 1'b0} ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b011)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00101101) ^ {row2[ct][6:0], 1'b0} ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b100)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row2[ct][6:0], 1'b0} ^ (8'b00011011))  ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b101)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row2[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b110)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row2[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row2[ct];
    end
    else
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row2[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row2[ct];
    end
    
    
    // MUL D, 00001101
    // Three items
    if(row3[ct][7:5] == 3'b000)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ {row3[ct][5:0], 2'b00} ^row3[ct];
    end
    else if(row3[ct][7:5] == 3'b001)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row3[ct][5:0], 2'b00} ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b010)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00110110) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00011011)) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b011)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00101101) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00011011)) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b100)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00110110)) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b101)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00110110)) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b110)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00101101)) ^ row3[ct];
    end
    else
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00101101)) ^ row3[ct];
    end
    
    
    
    // MUL 9, 00001001
    if(row4[ct][7:5] == 3'b000)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b001)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00011011) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b010)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00110110) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b011)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00101101) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b100)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01101100) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b101)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01110111) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b110)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01011010) ^ row4[ct];
    end
    else
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01000001) ^ row4[ct];
    end
    
    
    row5[ct] = factor1 ^ factor2 ^ factor3 ^ factor4;
    
  end
  
  
  
  // Row 6
  
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    
    // MUL 9, 00001001
    // Two items
    if(row1[ct][7:5] == 3'b000)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b001)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00011011) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b010)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00110110) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b011)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00101101) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b100)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01101100) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b101)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01110111) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b110)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01011010) ^ row1[ct];
    end
    else
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01000001) ^ row1[ct];
    end
    
    // MUL E, 00001110
    // Three items
    if(row2[ct][7:5] == 3'b000)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ {row2[ct][5:0], 2'b00} ^ {row2[ct][6:0], 1'b0};
    end
    else if(row2[ct][7:5] == 3'b001)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row2[ct][5:0], 2'b00} ^ {row2[ct][6:0], 1'b0};
    end
    else if(row2[ct][7:5] == 3'b010)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00110110) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00011011)) ^ {row2[ct][6:0], 1'b0};
    end
    else if(row2[ct][7:5] == 3'b011)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00101101) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00011011)) ^ {row2[ct][6:0], 1'b0};
    end
    else if(row2[ct][7:5] == 3'b100)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00110110)) ^ ({row2[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else if(row2[ct][7:5] == 3'b101)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00110110)) ^ ({row2[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else if(row2[ct][7:5] == 3'b110)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00101101)) ^ ({row2[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00101101)) ^ ({row2[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    
    // MUL B, 00001011
    // Three items in total
    if(row3[ct][7:5] == 3'b000)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ {row3[ct][6:0], 1'b0} ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b001)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row3[ct][6:0], 1'b0} ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b010)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00110110) ^ {row3[ct][6:0], 1'b0} ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b011)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00101101) ^ {row3[ct][6:0], 1'b0} ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b100)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row3[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b101)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row3[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b110)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row3[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row3[ct];
    end
    else
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row3[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row3[ct];
    end
    
    
    // MUL D, 00001101
    // Three items
    if(row4[ct][7:5] == 3'b000)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ {row4[ct][5:0], 2'b00} ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b001)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row4[ct][5:0], 2'b00} ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b010)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00110110) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00011011)) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b011)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00101101) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00011011)) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b100)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00110110)) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b101)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00110110)) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b110)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00101101)) ^ row4[ct];
    end
    else
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00101101)) ^ row4[ct];
    end
    
    row6[ct] = factor1 ^ factor2 ^ factor3 ^ factor4;
    
  end
  
  
  
  
  // Row 7
  
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    
    // MUL D, 00001101
    // Three items
    if(row1[ct][7:5] == 3'b000)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ {row1[ct][5:0], 2'b00} ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b001)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row1[ct][5:0], 2'b00} ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b010)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00110110) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00011011)) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b011)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00101101) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00011011)) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b100)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00110110)) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b101)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00110110)) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b110)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00101101)) ^ row1[ct];
    end
    else
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row1[ct][5:0], 2'b00} ^ (8'b00101101)) ^ row1[ct];
    end
    
    
    // MUL 9, 00001001
    // Two items
    if(row2[ct][7:5] == 3'b000)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b001)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00011011) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b010)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00110110) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b011)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00101101) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b100)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01101100) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b101)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01110111) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b110)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01011010) ^ row2[ct];
    end
    else
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01000001) ^ row2[ct];
    end
    
    
    // MUL E, 00001110
    // Three items
    if(row3[ct][7:5] == 3'b000)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ {row3[ct][5:0], 2'b00} ^ {row3[ct][6:0], 1'b0};
    end
    else if(row3[ct][7:5] == 3'b001)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row3[ct][5:0], 2'b00} ^ {row3[ct][6:0], 1'b0};
    end
    else if(row3[ct][7:5] == 3'b010)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00110110) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00011011)) ^ {row3[ct][6:0], 1'b0};
    end
    else if(row3[ct][7:5] == 3'b011)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00101101) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00011011)) ^ {row3[ct][6:0], 1'b0};
    end
    else if(row3[ct][7:5] == 3'b100)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00110110)) ^ ({row3[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else if(row3[ct][7:5] == 3'b101)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00110110)) ^ ({row3[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else if(row3[ct][7:5] == 3'b110)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00101101)) ^ ({row3[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row3[ct][5:0], 2'b00} ^ (8'b00101101)) ^ ({row3[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    
    
    // MUL B, 00001011
    // Three items in total
    if(row4[ct][7:5] == 3'b000)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ {row4[ct][6:0], 1'b0} ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b001)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row4[ct][6:0], 1'b0} ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b010)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00110110) ^ {row4[ct][6:0], 1'b0} ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b011)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00101101) ^ {row4[ct][6:0], 1'b0} ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b100)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row4[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b101)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row4[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row4[ct];
    end
    else if(row4[ct][7:5] == 3'b110)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row4[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row4[ct];
    end
    else
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row4[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row4[ct];
    end
    
    
    row7[ct] = factor1 ^ factor2 ^ factor3 ^ factor4;
    
  end
  
  
  
  for(ct = 0; ct < 4; ct = ct + 1)
  begin
    
    
    // MUL B, 00001011
    // Three items in total
    if(row1[ct][7:5] == 3'b000)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ {row1[ct][6:0], 1'b0} ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b001)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row1[ct][6:0], 1'b0} ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b010)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00110110) ^ {row1[ct][6:0], 1'b0} ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b011)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b00101101) ^ {row1[ct][6:0], 1'b0} ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b100) // small fix here
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row1[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b101)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row1[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row1[ct];
    end
    else if(row1[ct][7:5] == 3'b110)
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row1[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row1[ct];
    end
    else
    begin
      factor1 = {row1[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row1[ct][6:0], 1'b0} ^ (8'b00011011)) ^ row1[ct];
    end
    
    
    
    // MUL D, 00001101
    // Three items
    if(row2[ct][7:5] == 3'b000)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ {row2[ct][5:0], 2'b00} ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b001)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row2[ct][5:0], 2'b00} ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b010)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00110110) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00011011)) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b011)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b00101101) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00011011)) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b100)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00110110)) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b101)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00110110)) ^ row2[ct];
    end
    else if(row2[ct][7:5] == 3'b110)
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00101101)) ^ row2[ct];
    end
    else
    begin
      factor2 = {row2[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row2[ct][5:0], 2'b00} ^ (8'b00101101)) ^ row2[ct];
    end
    
    
    
    
    // MUL 9, 00001001
    // Two items
    if(row3[ct][7:5] == 3'b000)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b001)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00011011) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b010)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00110110) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b011)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b00101101) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b100)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01101100) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b101)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01110111) ^ row3[ct];
    end
    else if(row3[ct][7:5] == 3'b110)
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01011010) ^ row3[ct];
    end
    else
    begin
      factor3 = {row3[ct][4:0], 3'b000} ^ (8'b01000001) ^ row3[ct];
    end
    
    
    // MUL E, 00001110
    // Three items
    if(row4[ct][7:5] == 3'b000)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ {row4[ct][5:0], 2'b00} ^ {row4[ct][6:0], 1'b0};
    end
    else if(row4[ct][7:5] == 3'b001)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00011011) ^ {row4[ct][5:0], 2'b00} ^ {row4[ct][6:0], 1'b0};
    end
    else if(row4[ct][7:5] == 3'b010)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00110110) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00011011)) ^ {row4[ct][6:0], 1'b0};
    end
    else if(row4[ct][7:5] == 3'b011)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b00101101) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00011011)) ^ {row4[ct][6:0], 1'b0};
    end
    else if(row4[ct][7:5] == 3'b100)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01101100) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00110110)) ^ ({row4[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else if(row4[ct][7:5] == 3'b101)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01110111) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00110110)) ^ ({row4[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else if(row4[ct][7:5] == 3'b110)
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01011010) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00101101)) ^ ({row4[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    else
    begin
      factor4 = {row4[ct][4:0], 3'b000} ^ (8'b01000001) ^ ({row4[ct][5:0], 2'b00} ^ (8'b00101101)) ^ ({row4[ct][6:0], 1'b0} ^ (8'b00011011));
    end
    
    
    row8[ct] = factor1 ^ factor2 ^ factor3 ^ factor4;
    
  end
  
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








