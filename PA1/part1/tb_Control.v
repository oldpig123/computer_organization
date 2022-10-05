module tb_Control();

reg Run,Reset,clk,LSB;
wire W_ctrl,SRL_ctrl,Ready;
wire [5:0]ADDU_ctrl;

Control controller(
    .run(Run),
    .reset(Reset),
    .clk(clk),
    .lsb(LSB),
    .w_ctrl(W_ctrl),
    .addu_ctrl(ADDU_ctrl),
    .srl_ctrl(SRL_ctrl),
    .ready(Ready)
);

initial #350 $finish;

initial begin
    #0 clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    #0 LSB = 0;
    forever #10 LSB = ~LSB;
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
