module tb_ALU_Control ();
    reg [5:0] funct_ctrl;
    reg [1:0] ALUOp;
    wire [5:0] funct;
    ALU_Control alu_ctrl(
        .funct_ctrl(funct_ctrl),
        .ALUOp(ALUOp),
        .funct(funct)
    );

    initial fork
        #0 funct_ctrl = 6'b001011;
        #0 ALUOp = 2'b10;
        #5 funct_ctrl = 6'b001101;
        #10 funct_ctrl = 6'b100101;
        #15 funct_ctrl = 6'b000010;
        #20 ALUOp = 2'b00;
        #25 ALUOp = 2'b01;
        #30 $finish;
    join
endmodule
