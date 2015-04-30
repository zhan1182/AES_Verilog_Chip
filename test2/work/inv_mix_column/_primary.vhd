library verilog;
use verilog.vl_types.all;
entity inv_mix_column is
    port(
        state_array_in  : in     vl_logic_vector(0 to 15);
        state_array_out : out    vl_logic_vector(0 to 15)
    );
end inv_mix_column;
