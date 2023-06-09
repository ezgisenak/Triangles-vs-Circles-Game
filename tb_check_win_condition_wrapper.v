module tb_check_win_condition_wrapper;

  // Parameters
  parameter BOARD_SIZE = 10;
  
  // Inputs
  reg [3:0] recent_x, recent_y;
  reg [1:0] piece_type;
  
  // Outputs
  wire win;
  
  // Instantiate the Unit Under Test (UUT)
  check_win_condition_wrapper #(BOARD_SIZE) UUT (
    .recent_x(recent_x), 
    .recent_y(recent_y), 
    .piece_type(piece_type), 
    .win(win)
  );

  initial begin
    // Initialize Inputs
    recent_x <= 4'b0;
    recent_y <= 4'b0;
    piece_type <= 2'b0;
    
    // Wait for the UUT to stabilize
    #100;
    
    // Test case 1
    recent_x <= 4'b0001; // x = 1
    recent_y <= 4'b0001; // y = 1
    piece_type <= 2'b01; // TRIANGLE
    #100;
    $display("Test 1 - Win: %b", win);
    
    // Test case 2
    recent_x <= 4'b1010; // x = 10
    recent_y <= 4'b1010; // y = 10
    piece_type <= 2'b10; // CIRCLE
    #100;
    $display("Test 2 - Win: %b", win);

    // Add more tests as needed

    $finish;
  end
  
endmodule
