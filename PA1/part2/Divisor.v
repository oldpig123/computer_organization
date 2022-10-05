module Divisor (
    input [31:0] Divisor_in,
    input reset,w_ctrl,
    output reg [31:0] Divisor_out
);
    reg [31:0] Divisor_reg;
    always @(reset or w_ctrl or Divisor_in) begin
        if (reset == 1) begin
            Divisor_out[31:0] = 0;
            Divisor_reg[31:0] = Divisor_in[31:0];
        end
        if (reset == 0 && w_ctrl == 1) begin
            Divisor_out[31:0] =  Divisor_reg[31:0];
        end
    end
endmodule

