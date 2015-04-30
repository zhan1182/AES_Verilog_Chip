library verilog;
use verilog.vl_types.all;
entity decryption is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        d_in            : in     vl_logic_vector(127 downto 0);
        key_schedule    : in     vl_logic_vector(0 to 43);
        d_out           : out    vl_logic_vector(127 downto 0)
    );
end decryption;
