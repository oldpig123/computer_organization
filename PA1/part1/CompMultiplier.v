module CompMultiplier (
    output [63:0] Product,
    output ready,
    input [31:0] Multiplicand,
    input [31:0] Multiplier,
    input run,
    input reset,
    input clk
);
    wire [31:0] Multiplicand_out,ALU_result;
    //wire [63:0] Product;
    wire [5:0] ADDU_ctrl;
    wire W_ctrl,SRL_ctrl,ALU_Carry,lsb;

    Control ctrl(.reset(reset),.run(run),.clk(clk),.lsb(Product[0]),.w_ctrl(W_ctrl),.srl_ctrl(SRL_ctrl),.ready(ready),.addu_ctrl(ADDU_ctrl));
    ALU alu(.Src1(Product[63:32]),.Src2(Multiplicand_out),.Funct(ADDU_ctrl),.ALU_result(ALU_result),.ALU_Carry(ALU_Carry));
    Product PR(.ALU_result(ALU_result),.Multiplier_in(Multiplier),.ALU_Carry(ALU_Carry),.srl_ctrl(SRL_ctrl),.w_ctrl(W_ctrl),.ready(ready),.reset(reset),.clk(clk),.Product_out(Product),.lsb(lsb));
    Multiplicand mu(.Multiplicand_in(Multiplicand),.reset(reset),.w_ctrl(W_ctrl),.Multiplicand_out(Multiplicand_out));

endmodule