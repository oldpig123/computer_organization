module tb_Control();

reg Run,Reset,clk,MSB;
wire W_ctrl,SRL_ctrl,SLL_ctrl,Ready;
wire [5:0]SUBU_ctrl;

Control controller(
    .run(Run),
    .reset(Reset),
    .clk(clk),
    .w_ctrl(W_ctrl),
    .subu_ctrl(SUBU_ctrl),
    .srl_ctrl(SRL_ctrl),
    .sll_ctrl(SLL_ctrl),
    .ready(Ready)
);

initial #400 $finish;

initial begin
    #0 clk = 0;
    forever #5 clk = ~clk;
end


initial fork
    #0 Run = 0;
    #0 Reset = 0;

    #5 Reset = 1;   
    #5 Run = 1;

    #15 Reset = 0;
    #15 Run = 0; 

    #25 Run = 1;    
join

endmodule
