/*module Debouncer (
    input wire clk, reset, button_in,
    output reg button_out
);
    reg [3:0] count;
    reg button_in_d;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
            button_in_d <= 0;
            button_out <= 0;
        end else begin
            if (button_in != button_in_d) begin
                count <= count + 1;
                if (count == 4'b1111) begin
                    button_out <= ~button_out;
                    count <= 4'b0000;
                end
            end else begin
                count <= 4'b0000;
            end
            button_in_d <= button_in;
        end
    end
endmodule
*/