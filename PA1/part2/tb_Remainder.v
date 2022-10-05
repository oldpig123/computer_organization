module tb_Remainder();
reg SRL_ctrl;
reg SLL_ctrl;
reg W_ctrl;
reg Ready;
reg Reset;
reg clk;
reg ALU_carry;
reg [31:0]ALU_result;
reg [31:0]Dividend_in;
wire [63:0]Remainder_out;

Remainder remain
(
    .srl_ctrl(SRL_ctrl),
    .sll_ctrl(SLL_ctrl),
    .w_ctrl(W_ctrl),
    .ready(Ready),
    .reset(Reset),
    .clk(clk),
    .ALU_Carry(ALU_carry),
    .ALU_result(ALU_result),
    .Dividend_in(Dividend_in),
    .Remainder_out(Remainder_out)
);

initial #100 $finish;


initial begin
#0 clk = 0;
forever #5 clk = ~clk;
end


initial fork
    // 初始化
    #0 ALU_result = 32'd10;
    #0 W_ctrl = 0;
    #0 Reset = 0;
    #0 Ready = 0;
    #0 SRL_ctrl = 0;
    #0 SLL_ctrl = 0;
    #0 ALU_carry = 0;
    #0 Dividend_in = 0;

    #15 Reset = 1;
    #15 W_ctrl =1;
    #15 Dividend_in = 32'h FFFF_FFFF;
    #15 SLL_ctrl = 1; 
    

    #20 Reset = 0;
    #26 W_ctrl = 0;
    #30 SRL_ctrl = 0;
    #35 SLL_ctrl = 1; 
    #40 ALU_result = 32'h FF00_F0F0; 
    #40 ALU_carry = 0; 

    #50 ALU_carry = 1; 

    #60 SRL_ctrl = 1; 
    #60 SLL_ctrl = 0; 
    #80 Ready = 1;

join    



endmodule
