module tb_Control ();
    reg [5:0] Opcode;
    wire [1:0] ALUOp;
    wire RegDst;
    wire Branch;
    wire RegWrite;
    wire ALUSrc;
    wire MemWrite;
    wire MemRead;
    wire MemToReg;
    wire Jump;

    Control ctrl(
        .Opcode(Opcode),
        .ALUOp(ALUOp),
        .RegDst(RegDst),
        .Branch(Branch),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemToReg(MemToReg),
        .Jump(Jump)
    );

    initial fork
        #0 Opcode = 6'd0;
        #5 Opcode = 6'b001100;
        #10 Opcode = 6'b001101;
        #15 Opcode = 6'b010000;
        #20 Opcode = 6'b010001;
        #25 Opcode = 6'b010011;
        #30 Opcode = 6'b011100;
        #35 Opcode = 6'b111111;
        #40 $finish;
    join
endmodule