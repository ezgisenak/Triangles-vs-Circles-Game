module check_win_condition_wrapper #(parameter BOARD_SIZE = 10)(input wire [3:0] recent_x, input wire [3:0] recent_y, input wire [1:0] piece_type, output wire win);
  
  reg [1:0] board [0:BOARD_SIZE-1][0:BOARD_SIZE-1];
  
  assign win = check_win_condition(recent_x, recent_y, piece_type);

  
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

endmodule
