// $Id: $
// File name:   data_transfer_to_ofc.sv
// Created:     4/27/2015
// Author:      Xinjie Lei
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: data transfer to off chip sram
module data_transfer_to_ofc
  (
   input wire [127:0] d_in,
   output reg [127:0] d_out
   );
   assign d_out = d_in;
endmodule // data_transfer_to_ofc
