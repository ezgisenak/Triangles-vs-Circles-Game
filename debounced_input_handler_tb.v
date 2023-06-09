`timescale 1ns / 1ps

module debounced_input_handler_tb();

    reg clk;
    reg reset;
    reg logic_0_button;
    reg logic_1_button;
    reg activity_button;
    wire [3:0] x_output, y_output;
    wire valid_coordinate;

    // Instantiate the input_handler module
    debounced_input_handler U1(
        .clk(clk), .reset(reset), .logic_0_button(logic_0_button), .logic_1_button(logic_1_button), .activity_button(activity_button), 
        .x_output(x_output), .y_output(y_output), .valid_coordinate(valid_coordinate)
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
        #200 reset = 0;

        // Simulate pressing the buttons for (1, c)
        // For '0001'(0001), logic_1_button is pressed once
        #200 logic_1_button = 0;
        #300 logic_1_button = 1;
        // then logic_0_button is pressed three times
        #200 logic_0_button = 0;
        #300 logic_0_button = 1;
        #200 logic_0_button = 0;
        #300 logic_0_button = 1;
        #200 logic_0_button = 0;
        #300 logic_0_button = 1;
        
        // For 'C,0011'(1100), logic_1_button is pressed two times
        #200 logic_1_button = 0;
        #300 logic_1_button = 1;
        #200 logic_1_button = 0;
        #300 logic_1_button = 1;
        // then logic_0_button is pressed two times
        #200 logic_0_button = 0;
        #300 logic_0_button = 1;
        #200 logic_0_button = 0;
        #300 logic_0_button = 1;
        
        // Press activity button
        #200 activity_button = 0;
        #300 activity_button = 1;

    end

    // Display the output on the console
    initial begin
        $monitor("At time %dns, x_output = %b, y_output = %b, valid_coordinate = %b", $time, x_output, y_output, valid_coordinate);
    end

endmodule
