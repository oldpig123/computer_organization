
module tb_Product();
reg SRL_ctrl;
reg W_ctrl;
reg Ready;
reg Reset;
reg clk;
reg ALU_carry;
reg [31:0]ALU_result;
reg [31:0]Multiplier_in;
wire [63:0]Product_out;

Product pro
(
    .srl_ctrl(SRL_ctrl),
    .w_ctrl(W_ctrl),
    .ready(Ready),
    .reset(Reset),
    .clk(clk),
    .ALU_Carry(ALU_carry),
    .ALU_result(ALU_result),
    .Multiplier_in(Multiplier_in),
    .Product_out(Product_out)
);

initial #100 $finish;

initial begin
#0 clk = 0;
forever #5 clk = ~clk;
end

initial fork
    
    #0 ALU_result = 32'd10; 
    #0 W_ctrl = 0;
    #0 Reset = 0;
    #0 Ready = 0;
    #0 SRL_ctrl = 0;
    #0 ALU_carry = 0;
    #0 Multiplier_in = 0;
 
    
    #15 Reset = 1;
    #15 W_ctrl =1;
    #15 Multiplier_in = 32'h FFFF_FFFF;

    
    #25 Reset = 0;
    #30 W_ctrl = 0;
    #30 SRL_ctrl = 1;
    #30 ALU_carry = 1; 
    
    #40 ALU_carry = 0; 
    #40 Reset = 1; 
    #40 W_ctrl = 1;
    
    #50 Reset = 0;
    #50 W_ctrl = 0;
    #50 Ready = 0; 

    #80 Ready = 1; 

join    

endmodule