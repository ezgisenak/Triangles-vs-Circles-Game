module input_handler (
    input wire clk, reset,
    input wire logic_0_button, logic_1_button, activity_button,
    output reg [3:0] x_output, y_output,
    output reg valid_coordinate
);

    reg [3:0] x_counter, y_counter;
    localparam IDLE = 2'b00, X_INPUT = 2'b01, Y_INPUT = 2'b10, VALIDATE = 2'b11;
    reg [1:0] state, next_state;

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
                if (~logic_0_button) begin
                    x_counter <= x_counter + 1'b1;
                    x_output <= (x_output >> 1) + 4'b1000;
                end else if (~logic_1_button) begin
                    x_counter <= x_counter + 1'b1;
                    x_output <= (x_output >> 1);
                end
            end else if (state == Y_INPUT) begin
                if (~logic_0_button) begin
                    y_counter <= y_counter + 1'b1;
                    y_output <= (y_output >> 1) + 4'b1000;
                end else if (~logic_1_button) begin
                    y_counter <= y_counter + 1'b1;
                    y_output <= (y_output >> 1);
                end
            end
            if (state == VALIDATE && ~activity_button)
                valid_coordinate <= 1'b1;
            else
                valid_coordinate <= 0;
        end
    end

    always @(state or logic_0_button or logic_1_button or activity_button) begin
        case (state)
            IDLE: begin
                if (~logic_0_button || ~logic_1_button)
                    next_state = X_INPUT;
                else
                    next_state = IDLE;
            end
            X_INPUT: begin
                if (x_counter == 4'b0100)
                    next_state = Y_INPUT;
                else if (~logic_0_button || ~logic_1_button)
                    next_state = X_INPUT;
                else
                    next_state = IDLE;
            end
            Y_INPUT: begin
                if (y_counter == 4'b0100)
                    next_state = VALIDATE;
                else if (~logic_0_button || ~logic_1_button)
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
endmodule
