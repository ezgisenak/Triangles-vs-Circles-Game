module debounced_input_handler (
    input wire clk, reset,
    input wire logic_0_button, logic_1_button, activity_button,
    output reg [3:0] x_output, y_output,
    output reg valid_coordinate
);

	 reg [3:0] x_counter, y_counter;
    reg [1:0] state, next_state;
    localparam IDLE = 2'b00, X_INPUT = 2'b01, Y_INPUT = 2'b10, VALIDATE = 2'b11;
    
    // Debounce registers
    reg [3:0] count_0, count_1, count_activity;
    reg logic_0_button_d, logic_1_button_d, activity_button_d;

    // Debouncing logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count_0 <= 4'b0000;
            count_1 <= 4'b0000;
            count_activity <= 4'b0000;
            logic_0_button_d <= 0;
            logic_1_button_d <= 0;
            activity_button_d <= 0;
        end else begin
            // Debouncing for logic_0_button
            if (logic_0_button != logic_0_button_d) begin
                count_0 <= count_0 + 1;
                if (count_0 == 4'b1111) begin
                    logic_0_button_d <= ~logic_0_button_d;
                    count_0 <= 4'b0000;
                end
            end else begin
                count_0 <= 4'b0000;
            end

            // Debouncing for logic_1_button
            if (logic_1_button != logic_1_button_d) begin
                count_1 <= count_1 + 1;
                if (count_1 == 4'b1111) begin
                    logic_1_button_d <= ~logic_1_button_d;
                    count_1 <= 4'b0000;
                end
            end else begin
                count_1 <= 4'b0000;
            end

            // Debouncing for activity_button
            if (activity_button != activity_button_d) begin
                count_activity <= count_activity + 1;
                if (count_activity == 4'b1111) begin
                    activity_button_d <= ~activity_button_d;
                    count_activity <= 4'b0000;
                end
            end else begin
                count_activity <= 4'b0000;
            end
        end
    end
	 
	 
    always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
         x_counter <= 4'b0000;
         y_counter <= 4'b0000;
         x_output <= 4'b0000;
         y_output <= 4'b0000;
         valid_coordinate <= 0;
		end else begin
         state <= next_state;
         if (state == X_INPUT) begin
				if (~logic_0_button_d) begin
					x_counter <= x_counter + 1'b1;
               x_output <= (x_output >> 1);
            end 
				else if (~logic_1_button_d) begin
               x_counter <= x_counter + 1'b1;
               x_output <= (x_output >> 1) + 4'b1000;
            end
         end 
			else if (state == Y_INPUT) begin
            if (~logic_1_button_d) begin
					y_output <= (y_output >> 1) + 4'b1000;
               y_counter <= y_counter + 1'b1;
            end 
				else if (~logic_0_button_d) begin
               y_output <= (y_output >> 1);
               y_counter <= y_counter + 1'b1;                    
            end
         end
         if (state == VALIDATE && ~activity_button)
				valid_coordinate <= 1'b1;
         else
            valid_coordinate <= 0;
         end
      end
		
		
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
