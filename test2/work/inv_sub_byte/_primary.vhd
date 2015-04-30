library verilog;
use verilog.vl_types.all;
entity inv_sub_byte is
    port(
        state_array_in  : in     vl_logic;
        state_array_out : out    vl_logic
    );
end inv_sub_byte;
