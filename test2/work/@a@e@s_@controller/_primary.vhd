library verilog;
use verilog.vl_types.all;
entity AES_Controller is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        start           : in     vl_logic;
        usr_key         : in     vl_logic_vector(127 downto 0);
        usr_addr        : in     vl_logic_vector(7 downto 0);
        usr_loc         : in     vl_logic_vector(7 downto 0);
        mode            : in     vl_logic;
        en_d            : in     vl_logic;
        de_d            : in     vl_logic;
        key_d           : in     vl_logic;
        key             : out    vl_logic_vector(127 downto 0);
        s_addr          : out    vl_logic_vector(7 downto 0);
        loc             : out    vl_logic_vector(7 downto 0);
        en_or_de        : out    vl_logic;
        key_en          : out    vl_logic;
        con_en          : out    vl_logic;
        AES_done        : out    vl_logic;
        aes_clk         : out    vl_logic;
        mem_clr         : out    vl_logic;
        co_n_rst        : out    vl_logic
    );
end AES_Controller;
