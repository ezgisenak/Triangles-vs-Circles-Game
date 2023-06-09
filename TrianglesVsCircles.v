module TrianglesVsCircles (
  input wire clk, 
  input wire reset,
  input wire logic_0_button,
  input wire logic_1_button,
  input wire activity_button,
  output wire vga_hsync,
  output wire vga_vsync,
  output wire [9:0] vga_red,
  output wire [9:0] vga_green,
  output wire [9:0] vga_blue
);

  // Game parameters
  parameter BOARD_SIZE = 10;
  parameter MAX_MOVES = 25;
  parameter WINNING_PLACEMENT = 4;
  
  typedef enum logic [2:0] {IDLE, TRIANGLES_TURN, CIRCLES_TURN, CHECK_WIN, GAME_OVER} state_t;
	state_t state, next_state;
	
	 typedef enum logic [1:0] {EMPTY = 2'b00, TRIANGLE = 2'b01, CIRCLE = 2'b10, OCCUPIED = 2'b11} piece_t;
	
  // Game state variables
  reg [1:0] board [0:BOARD_SIZE-1][0:BOARD_SIZE-1];
  reg current_player; // 0 for circle 1 for triangle
  reg [9:0] total_moves_triangles;
  reg [9:0] total_moves_circles;
  reg [9:0] recent_position_triangles;
  reg [9:0] recent_position_circles;
  reg [9:0] winning_placement_start_x;
  reg [9:0] winning_placement_start_y;
  reg [0:1] game_outcome;
  reg [3:0] move_counter;
  reg [9:0] erase_square_x;
  reg [9:0] erase_square_y;

  // VGA timing variables
  reg [10:0] hcount;
  reg [10:0] vcount;

  // Other internal signals
  wire [3:0] player_shape;
  
  // Game state initialization
  initial begin
    reset_game_state();
  end

  always_comb begin
    case(state)
        IDLE: begin
            if (activity_button_d) begin
                current_player <= 0; // Start with circles
                reset_game_state();
                next_state = TRIANGLES_TURN;
            end else begin
                next_state = IDLE;
            end
        end

        TRIANGLES_TURN: begin
            if (activity_button_d) begin
                if (is_valid_move(x_output, y_output)) begin
                    board[x_output][y_output] <= TRIANGLE;
                    total_moves_triangles <= total_moves_triangles + 1;
                    recent_position_triangles <= {x_output, y_output};
                    next_state = CHECK_WIN;
                end
            end else begin
                next_state = TRIANGLES_TURN;
            end
        end

        CIRCLES_TURN: begin
            if (activity_button_d) begin
                if (is_valid_move(x_output, y_output)) begin
                    board[x_output][y_output] <= CIRCLE;
                    total_moves_circles <= total_moves_circles + 1;
                    recent_position_circles <= {x_output, y_output};
                    next_state = CHECK_WIN;
                end
            end else begin
                next_state = CIRCLES_TURN;
            end
        end

        CHECK_WIN: begin
            if (current_player == 0) begin // Check if circles won
                if (check_win_condition(CIRCLE, recent_position_circles)) begin
                    game_outcome <= 0;
                    next_state = GAME_OVER;
                end else if (total_moves_circles == MAX_MOVES) begin
                    game_outcome <= 1; // Draw
                    next_state = GAME_OVER;
                end else begin
                    current_player <= 1; // Switch to triangles
                    next_state = TRIANGLES_TURN;
                end
            end else begin // Check if triangles won
                if (check_win_condition(TRIANGLE, recent_position_triangles)) begin
                    game_outcome <= 2;
                    next_state = GAME_OVER;
                end else if (total_moves_triangles == MAX_MOVES) begin
                    game_outcome <= 1; // Draw
                    next_state = GAME_OVER;
                end else begin
                    current_player <= 0; // Switch to circles
                    next_state = CIRCLES_TURN;
                end
            end
        end

        GAME_OVER: begin
            if (activity_button_d) begin
                reset_game_state();
                next_state = IDLE;
            end else begin
                next_state = GAME_OVER;
            end
        end
    endcase
end

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

  
    always_ff @(posedge clk) begin
    if (reset) begin
      // reset logic
    end else if (logic_0_button) begin
      // add a '0' to the input buffer
    end else if (logic_1_button) begin
      // add a '1' to the input buffer
    end else if (activity_button) begin
      // interpret the input buffer as a move and make the move
    end
  end
	 
	/*   always_ff @(posedge clk) begin
    if (reset) begin
      // reset the display
    end else begin
      // update the display based on the game state
    end
  end */

  // Reset game state
  task reset_game_state;
    integer i, j;

    for (i = 0; i < BOARD_SIZE; i = i + 1) begin
      for (j = 0; j < BOARD_SIZE; j = j + 1) begin
        board[i][j] = 2'b00;
      end
	end
    endtask

function [0:0] check_win_condition;
  input [3:0] recent_x, recent_y;
  input [1:0] current_piece;
  
  integer dx, dy;
  integer count;
  
  // Initialize output to false (no winning condition)
  check_win_condition = 1'b0;
  
  // Vertical check
  count = 0;
  for (dy = -3; dy <= 3; dy = dy + 1) begin
    if (recent_y + dy >= 0 && recent_y + dy < BOARD_SIZE && board[recent_x][recent_y + dy] == current_piece) begin
      count = count + 1;
      if (count >= WINNING_PLACEMENT)
        check_win_condition = 1'b1;
    end else
      count = 0;
  end

  // Horizontal check
  count = 0;
  for (dx = -3; dx <= 3; dx = dx + 1) begin
    if (recent_x + dx >= 0 && recent_x + dx < BOARD_SIZE && board[recent_x + dx][recent_y] == current_piece) begin
      count = count + 1;
      if (count >= WINNING_PLACEMENT)
        check_win_condition = 1'b1;
    end else
      count = 0;
  end

  // Diagonal check (/)
  count = 0;
  for (dx = -3, dy = -3; dx <= 3 && dy <= 3; dx = dx + 1, dy = dy + 1) begin
    if (recent_x + dx >= 0 && recent_x + dx < BOARD_SIZE && recent_y + dy >= 0 && recent_y + dy < BOARD_SIZE && board[recent_x + dx][recent_y + dy] == current_piece) begin
      count = count + 1;
      if (count >= WINNING_PLACEMENT)
        check_win_condition = 1'b1;
    end else
      count = 0;
  end

  // Diagonal check (\)
  count = 0;
  for (dx = -3, dy = 3; dx <= 3 && dy >= -3; dx = dx + 1, dy = dy - 1) begin
    if (recent_x + dx >= 0 && recent_x + dx < BOARD_SIZE && recent_y + dy >= 0 && recent_y + dy < BOARD_SIZE && board[recent_x + dx][recent_y + dy] == current_piece) begin
      count = count + 1;
      if (count >= WINNING_PLACEMENT)
        check_win_condition = 1'b1;
    end else
      count = 0;
  end
endfunction

function [0:0] is_valid_move;
  input [3:0] x; 
  input [3:0] y; 

  begin
    if (x >= BOARD_SIZE || y >= BOARD_SIZE || board[x][y] != EMPTY)
      is_valid_move = 1'b0; // Invalid move
    else
      is_valid_move = 1'b1; // Valid move
  end
endfunction

endmodule