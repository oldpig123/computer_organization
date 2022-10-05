module ID_EX (
    output reg [1:0] ALUOp_out,
    output reg RegDst_out,
    output reg RegWrite_out,
    output reg ALUSrc_out,
    output reg MemWrite_out,
    output reg MemRead_out,
    output reg MemToReg_out,
    input [1:0] ALUOp,
    input RegDst,
    input RegWrite,
    input ALUSrc,
    input MemWrite,
    input MemRead,
    input MemToReg,

    output reg [31:0] RsData_out,
    output reg [31:0] RtData_out,
    output reg [31:0] immediate_out,
    output reg [4:0] RtAddr_out,
    output reg [4:0] RdAddr_out,
    output reg [4:0] RsAddr_out,
    input [31:0] RsData,
    input [31:0] RtData,
    input [31:0] immediate,
    input [4:0] RtAddr,
    input [4:0] RdAddr,
    input [4:0] RsAddr,

    input clk
);
    reg [1:0] ALUOp_reg;
    reg RegDst_reg;
    reg RegWrite_reg;
    reg ALUSrc_reg;
    reg MemWrite_reg;
    reg MemRead_reg;
    reg MemToReg_reg;
    reg [31:0] RsData_reg;
    reg [31:0] RtData_reg;
    reg [31:0] immediate_reg;
    reg [4:0] RtAddr_reg;
    reg [4:0] RdAddr_reg;
    reg [4:0] RsAddr_reg;

    always @(posedge clk or negedge clk) begin
        if (clk == 1) begin
            ALUOp_reg = ALUOp;
            RegDst_reg = RegDst;
            RegWrite_reg = RegWrite;
            ALUSrc_reg = ALUSrc;
            MemWrite_reg = MemWrite;
            MemRead_reg = MemRead;
            MemToReg_reg = MemToReg;
            RsData_reg = RsData;
            RtData_reg = RtData;
            immediate_reg = immediate;
            RtAddr_reg = RtAddr;
            RdAddr_reg = RdAddr;
            RsAddr_reg = RsAddr;
        end
        else begin
            ALUOp_out = ALUOp_reg;
            RegDst_out = RegDst_reg;
            RegWrite_out = RegWrite_reg;
            ALUSrc_out = ALUSrc_reg;
            MemWrite_out = MemWrite_reg;
            MemRead_out = MemRead_reg;
            MemToReg_out = MemToReg_reg;
            RsData_out = RsData_reg;
            RtData_out = RtData_reg;
            immediate_out = immediate_reg;
            RtAddr_out = RtAddr_reg;
            RdAddr_out = RdAddr_reg;
            RsAddr_out = RsAddr_reg;
        end
    end
endmodule
