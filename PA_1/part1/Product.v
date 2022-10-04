module Product (
    input [31:0] ALU_result,
    input [31:0] Multiplier_in,
    input ALU_Carry,srl_ctrl,w_ctrl,ready,reset,clk,
    output reg[63:0] Product_out,
    output reg lsb
);
    reg[63:0] Product_reg; 

    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            Product_out = 64'b0;
            Product_reg[31:0] = Multiplier_in[31:0];
        end
        else if (w_ctrl == 1) begin
            Product_out[31:0] = Product_reg[31:0];
        end
        else if (ready == 0 && srl_ctrl == 1) begin
            if (Product_out[0] == 1) begin
                Product_out[63:32] = ALU_result[31:0];
            end
            Product_out = {ALU_Carry,Product_out[63:1]};
            if (Product_out[0] == 1) begin
                lsb = 1;
            end
            else begin
                lsb = 0;
            end
        end
        
    end
endmodule
