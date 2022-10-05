module CompDivider (
    output [31:0] Remainder,Quotient,
    output ready,
    input [31:0] Divisor,Dividend,
    input run,
    input reset,
    input clk
);
    wire [31:0] Divisor_out,ALU_result;
    //wire [63:0] Product;
    wire [5:0] SUBU_ctrl;
    wire W_ctrl,SRL_ctrl,ALU_Carry,SLL_ctrl;

    Control ctrl(.reset(reset),.run(run),.clk(clk),.w_ctrl(W_ctrl),.srl_ctrl(SRL_ctrl),.ready(ready),.subu_ctrl(SUBU_ctrl),.sll_ctrl(SLL_ctrl));
    ALU alu(.Src1(Remainder),.Src2(Divisor_out),.Funct(SUBU_ctrl),.ALU_result(ALU_result),.ALU_Carry(ALU_Carry));
    Remainder RR(.ALU_result(ALU_result),.Dividend_in(Dividend),.ALU_Carry(ALU_Carry),.srl_ctrl(SRL_ctrl),.w_ctrl(W_ctrl),.ready(ready),.reset(reset),.clk(clk),.Remainder_out({Remainder,Quotient}),.sll_ctrl(SLL_ctrl));
    Divisor di(.Divisor_in(Divisor),.reset(reset),.w_ctrl(W_ctrl),.Divisor_out(Divisor_out));

endmodule
