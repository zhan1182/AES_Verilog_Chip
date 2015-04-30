library verilog;
use verilog.vl_types.all;
entity AES_Chip is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        r_data          : in     vl_logic_vector(127 downto 0);
        mosi            : in     vl_logic;
        ss              : in     vl_logic;
        miso            : out    vl_logic;
        w_data          : out    vl_logic_vector(127 downto 0);
        r_addr          : out    vl_logic_vector(7 downto 0);
        w_addr          : out    vl_logic_vector(7 downto 0);
        r_en            : out    vl_logic;
        w_en            : out    vl_logic
    );
end AES_Chip;
