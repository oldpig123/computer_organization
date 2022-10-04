module tb_Multiplicand();

reg Reset,W_ctrl;
reg [31:0]Multiplicand_in;
wire [31:0]Multiplicand_out;

Multiplicand multiplicand(
    .reset(Reset),
    .w_ctrl(W_ctrl),
    .Multiplicand_in(Multiplicand_in),
    .Multiplicand_out(Multiplicand_out)
);

initial #30 $finish;
initial fork
#0 Reset = 0; 
#0 W_ctrl = 0;
#0 Multiplicand_in = 32'h FFFF_FFFF; 

#10 Reset = 1;
#10 W_ctrl = 1;
#12 Multiplicand_in = 32'h FF00_F0F0; 


#15 Reset = 0; 
#15 W_ctrl = 0;
#15 Multiplicand_in = 32'h 00FF_00FF;

#20 Reset = 1;
#20 W_ctrl = 1;
#20 Multiplicand_in = 32'h 00005252;

#25 Reset = 0;

join

endmodule
