module Multiplicand (
    input [31:0] Multiplicand_in,
    input reset,w_ctrl,
    output reg [31:0] Multiplicand_out
);
    reg [31:0] multiplicand_reg;
    always @(reset or w_ctrl or Multiplicand_in) begin
        if (reset == 1) begin
            Multiplicand_out[31:0] = 0;
            multiplicand_reg[31:0] = Multiplicand_in[31:0];
        end
        else if (reset == 0 && w_ctrl == 1) begin
            Multiplicand_out[31:0] =  multiplicand_reg[31:0];
        end
    end
endmodule
