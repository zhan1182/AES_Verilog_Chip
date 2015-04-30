library verilog;
use verilog.vl_types.all;
entity mix_column is
    port(
        state_array_in  : in     vl_logic_vector(0 to 15);
        state_array_out : out    vl_logic_vector(0 to 15)
    );
end mix_column;
