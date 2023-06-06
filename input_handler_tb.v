`timescale 1ns / 1ps

module input_handler_tb();

    reg clk;
    reg reset;
    reg logic_0_button;
    reg logic_1_button;
    reg activity_button;
    wire [3:0] x_output, y_output, x_counter, y_counter;
    wire valid_coordinate;
	 wire [1:0] state;

    // Instantiate the input_handler module
    input_handler U1(
        .clk(clk), .reset(reset), .state(state), .logic_0_button(logic_0_button), .logic_1_button(logic_1_button), .activity_button(activity_button), 
        .x_output(x_output), .y_output(y_output), .valid_coordinate(valid_coordinate), .y_counter(y_counter),.x_counter(x_counter)
    );
    
    // Clock generator
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // Reset and button inputs
    initial begin
        reset = 0;
        logic_0_button = 1;
        logic_1_button = 1;
        activity_button = 1;
        #20 reset = 1; // Active high reset signal
        #20 reset = 0;

        // Simulate pressing the buttons for (0, 1)
		  //1000 --> 0001
		  // For '1', logic_1_button is pressed once
        #40 logic_1_button = 0;
        #40 logic_1_button = 1;
        // then logic_0_button is pressed three times
        #40 logic_0_button = 0;
        #40 logic_0_button = 1;
        #40 logic_0_button = 0;
        #40 logic_0_button = 1;
        #40 logic_0_button = 0;
        #40 logic_0_button = 1;
		  
        // For 'C,0011', logic_0_button is pressed four times(1100)
        #40 logic_1_button = 0;
        #40 logic_1_button = 1;
        // then logic_0_button is pressed three times
        #40 logic_1_button = 0;
        #40 logic_1_button = 1;
        #40 logic_0_button = 0;
        #40 logic_0_button = 1;
        #40 logic_0_button = 0;
        #40 logic_0_button = 1;
        
        // Press activity button
        #40 activity_button = 0;
        #40 activity_button = 1;
    end

    // Display the output on the console
    initial begin
        $monitor("At time %dns, x_output = %b, x_counter=%b, y_output = %b, y_counter=%b, valid_coordinate = %b, state = %b", $time, x_output, x_counter, y_output, y_counter, valid_coordinate, state);
    end

endmodule