library verilog;
use verilog.vl_types.all;
entity inv_round is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        data_in         : in     vl_logic;
        round_key       : in     vl_logic;
        data_out        : out    vl_logic
    );
end inv_round;
