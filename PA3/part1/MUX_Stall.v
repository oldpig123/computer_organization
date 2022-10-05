module MUX_Stall (
    output reg [1:0] ALUOp_result,
    output reg RegDst_result,
    output reg RegWrite_result,
    output reg ALUSrc_result,
    output reg MemWrite_result,
    output reg MemRead_result,
    output reg MemToReg_result,
    input Stall,
    input [1:0] ALUOp,
    input RegDst,
    input RegWrite,
    input ALUSrc,
    input MemWrite,
    input MemRead,
    input MemToReg
);
    assign ALUOp_result = Stall?2'b00:ALUOp;
    assign RegDst_result = Stall?0:RegDst;
    assign RegWrite_result = Stall?0:RegWrite;
    assign ALUSrc_result = Stall?0:ALUSrc;
    assign MemWrite_result = Stall?0:MemWrite;
    assign MemRead_result = Stall?0:MemRead;
    assign MemToReg_result = Stall?0:MemToReg;
endmodule
