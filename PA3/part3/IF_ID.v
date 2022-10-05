module IF_ID (
    output reg [31:0] Instr_out,
    input [31:0] Instr,
    input IF_ID_Write,
    input clk
);
    reg [31:0] Instr_reg;
    always @(posedge clk or negedge clk) begin
        if (clk == 1 && IF_ID_Write == 1) begin
            Instr_reg = Instr;
        end
        else
            Instr_out = Instr_reg;
    end
endmodule
