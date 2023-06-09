`timescale 1ns / 1ps

module is_valid_move_tb;

  parameter BOARD_SIZE = 10; // Modify this to the actual size
  reg [3:0] x, y;
  reg [1:0] board [0:BOARD_SIZE-1][0:BOARD_SIZE-1];
  
    integer i, j;

  initial begin

    // Set all board positions to EMPTY
    for (i = 0; i < BOARD_SIZE; i = i + 1) begin
      for (j = 0; j < BOARD_SIZE; j = j + 1) begin
        board[i][j] = 2'b00;
      end
    end

	 #200;
    // Test case 1: Valid move
    x = 2; y = 2;
    if (is_valid_move(x, y) == 1'b1)
      $display("Test case 1: Pass");
    else
      $display("Test case 1: Fail");
	#200;
	

    // Test case 2: Move outside board boundaries
    x = BOARD_SIZE; y = 2;
    if (is_valid_move(x, y) == 1'b0)
      $display("Test case 2: Pass");
    else
      $display("Test case 2: Fail");
	#200;
    // Test case 3: Position already occupied
    board[2][2] = 2'b01; // Assume 2'b01 is not EMPTY
    x = 2; y = 2;
    if (is_valid_move(x, y) == 1'b0)
      $display("Test case 3: Pass");
    else
      $display("Test case 3: Fail");
  end

  function [0:0] is_valid_move;
    input [3:0] x, y;

    begin
      if (x >= BOARD_SIZE || y >= BOARD_SIZE || board[x][y] != 2'b00)
        is_valid_move = 1'b0; // Invalid move
      else
        is_valid_move = 1'b1; // Valid move
    end
  endfunction
endmodule
