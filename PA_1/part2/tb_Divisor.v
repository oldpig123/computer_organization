module tb_Divisor();

reg Reset,W_ctrl;
reg [31:0]Divisor_in;
wire [31:0]Divisor_out;

Divisor divisor(
    .reset(Reset),
    .w_ctrl(W_ctrl),
    .Divisor_in(Divisor_in),
    .Divisor_out(Divisor_out)
);

initial #30 $finish;
initial fork
#0 Reset = 0; 
#0 W_ctrl = 0;
#0 Divisor_in = 32'h FFFF_FFFF; 

#10 Reset = 1;
#10 W_ctrl = 1;
#10 Divisor_in = 32'h FF00_F0F0; 

#15 Reset = 0;
#20 W_ctrl = 0;



join

endmodule
