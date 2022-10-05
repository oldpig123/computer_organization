module Remainder (
    input [31:0] ALU_result,
    input [31:0] Dividend_in,
    input ALU_Carry,srl_ctrl,sll_ctrl,w_ctrl,ready,reset,clk,
    output reg[63:0] Remainder_out
);

    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            Remainder_out = 64'b0;
        end
        else if (w_ctrl == 1) begin
            Remainder_out[63:0] = {31'd0,Dividend_in[31:0],1'b0};
        end
        else if (ready == 0 && sll_ctrl == 1) begin
            Remainder_out = {ALU_result[30:0],Remainder_out[31:0],~ALU_Carry};
        end
        else if (ready == 0 && srl_ctrl == 1) begin
            Remainder_out = {1'b0,Remainder_out[63:33],Remainder_out[31:0]};
        end
    end
endmodule

