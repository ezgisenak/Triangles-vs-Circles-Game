library verilog;
use verilog.vl_types.all;
entity TrianglesVsCircles is
    generic(
        BOARD_SIZE      : integer := 10;
        MAX_MOVES       : integer := 25;
        WINNING_PLACEMENT: integer := 4;
        IDLE            : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        TRIANGLES_TURN  : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        CIRCLES_TURN    : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        CHECK_WIN       : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        GAME_OVER       : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        EMPTY           : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        TRIANGLE        : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        CIRCLE          : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        OCCUPIED        : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        logic_0_button  : in     vl_logic;
        logic_1_button  : in     vl_logic;
        activity_button : in     vl_logic;
        vga_hsync       : out    vl_logic;
        vga_vsync       : out    vl_logic;
        vga_red         : out    vl_logic_vector(9 downto 0);
        vga_green       : out    vl_logic_vector(9 downto 0);
        vga_blue        : out    vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BOARD_SIZE : constant is 1;
    attribute mti_svvh_generic_type of MAX_MOVES : constant is 1;
    attribute mti_svvh_generic_type of WINNING_PLACEMENT : constant is 1;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of TRIANGLES_TURN : constant is 1;
    attribute mti_svvh_generic_type of CIRCLES_TURN : constant is 1;
    attribute mti_svvh_generic_type of CHECK_WIN : constant is 1;
    attribute mti_svvh_generic_type of GAME_OVER : constant is 1;
    attribute mti_svvh_generic_type of EMPTY : constant is 1;
    attribute mti_svvh_generic_type of TRIANGLE : constant is 1;
    attribute mti_svvh_generic_type of CIRCLE : constant is 1;
    attribute mti_svvh_generic_type of OCCUPIED : constant is 1;
end TrianglesVsCircles;
