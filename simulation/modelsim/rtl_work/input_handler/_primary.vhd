library verilog;
use verilog.vl_types.all;
entity input_handler is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        logic_0_button  : in     vl_logic;
        logic_1_button  : in     vl_logic;
        activity_button : in     vl_logic;
        x_output        : out    vl_logic_vector(3 downto 0);
        y_output        : out    vl_logic_vector(3 downto 0);
        x_counter       : out    vl_logic_vector(3 downto 0);
        y_counter       : out    vl_logic_vector(3 downto 0);
        valid_coordinate: out    vl_logic;
        state           : out    vl_logic_vector(1 downto 0)
    );
end input_handler;
