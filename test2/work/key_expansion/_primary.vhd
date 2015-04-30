library verilog;
use verilog.vl_types.all;
entity key_expansion is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        key_done        : in     vl_logic;
        key_in          : in     vl_logic_vector(127 downto 0);
        key_schedule_out: out    vl_logic_vector(0 to 43)
    );
end key_expansion;
