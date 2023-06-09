`timescale 1ns / 1ps

module reset_game_tb();
  // Size of the board.
  parameter BOARD_SIZE = 10;
  
  // The game board, for this example we are just using 2D array of 2 bit values.
  reg [1:0] board [0:BOARD_SIZE-1][0:BOARD_SIZE-1];

  // Declare i and j here
  integer i, j;

  initial begin
    // Set all pieces on the board to a non-empty value.
    for (i = 0; i < BOARD_SIZE; i = i + 1) begin
      for (j = 0; j < BOARD_SIZE; j = j + 1) begin
        board[i][j] = 2'b01;  // Set all to TRIANGLE
      end
    end
	 
	 
	 #200;
  
    // Call the reset game state task
    reset_game_state;
  
    // Check if all the positions on the board are now empty.
    for (i = 0; i < BOARD_SIZE; i = i + 1) begin
      for (j = 0; j < BOARD_SIZE; j = j + 1) begin
        if(board[i][j] != 2'b00) begin
          $display("Test failed at position %0d, %0d", i, j);
        end
      end
    end
  
    $display("Test passed");
  end

  // Task under test
  task reset_game_state;
    integer i, j;
    for (i = 0; i < BOARD_SIZE; i = i + 1) begin
      for (j = 0; j < BOARD_SIZE; j = j + 1) begin
        board[i][j] = 2'b00; // Set to EMPTY
      end
    end
  endtask
endmodule
