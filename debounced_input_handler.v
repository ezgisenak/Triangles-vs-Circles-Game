module debounced_input_handler(
    input wire clk, reset,
    input wire logic_0_button, logic_1_button, activity_button,
    output reg [3:0] x_output, y_output,
    output reg valid_coordinate
);
    reg [3:0] x_counter, y_counter;
    reg [1:0] state, next_state;
    localparam IDLE = 2'b00, X_INPUT = 2'b01, Y_INPUT = 2'b10, VALIDATE = 2'b11;

    // Debounce counters
    reg [7:0] count_0, count_1, count_activity;
    
    // Debounced button states
    reg logic_0_button_d, logic_1_button_d, activity_button_d;

    /*always @(posedge clk or posedge reset) begin
    if (reset) begin
        count_0 <= 8'b00000000;
        count_1 <= 8'b00000000;
        count_activity <= 8'b00000000;
        logic_0_button_d <= 1;
        logic_1_button_d <= 1;
        activity_button_d <= 1;
    end else begin
        // Debouncing for logic_0_button
        if (logic_0_button == 0 && count_0 < 8'd10) begin
            count_0 <= count_0 + 1;
            if (count_0 == 8'd9) begin
                logic_0_button_d <= 0;
            end
        end else if (logic_0_button == 1) begin
            count_0 <= 8'b00000000;
            logic_0_button_d <= 1;
        end

        // Debouncing for logic_1_button
        if (logic_1_button == 0 && count_1 < 8'd10) begin
            count_1 <= count_1 + 1;
            if (count_1 == 8'd9) begin
                logic_1_button_d <= 0;
            end
        end else if (logic_1_button == 1) begin
            count_1 <= 8'b00000000;
            logic_1_button_d <= 1;
        end

        // Debouncing for activity_button
        if (activity_button == 0 && count_activity < 8'd10) begin
            count_activity <= count_activity + 1;
            if (count_activity == 8'd9) begin
                activity_button_d <= 0;
            end
        end else if (activity_button == 1) begin
            count_activity <= 8'b00000000;
            activity_button_d <= 1;
        end
    end
end */

    always @* begin
		if (reset) next_state = IDLE;
      
		else begin
			case (state)
				IDLE: begin
                  if (~logic_0_button_d || ~logic_1_button_d) begin
							if (x_counter == 4'b0100)
								next_state = Y_INPUT;
							else 
								next_state = X_INPUT;
							end
                  else
                        next_state = IDLE;
						end
            X_INPUT: begin
					if (x_counter == 4'b0100)
						next_state = Y_INPUT;
               else if (~logic_0_button_d || ~logic_1_button_d)
                  next_state = X_INPUT;
               else
                  next_state = IDLE;
               end
            Y_INPUT: begin
               if (y_counter == 4'b0100)
						next_state = VALIDATE;
					else if (~logic_0_button_d || ~logic_1_button_d)
                  next_state = Y_INPUT;
					else
                  next_state = IDLE;
               end
            VALIDATE: begin
               if (~activity_button)
                  next_state = IDLE;
               else
                  next_state = VALIDATE;
               end
         endcase
      end
    end
endmodule
