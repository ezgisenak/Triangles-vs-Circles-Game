library verilog;
use verilog.vl_types.all;
entity is_valid_move_tb is
    generic(
        BOARD_SIZE      : integer := 10
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BOARD_SIZE : constant is 1;
end is_valid_move_tb;
