module Forwarding (
    output reg [1:0]ForwardA,
    output reg [1:0]ForwardB,
    input EX_MEM_RegWrite,
    input [4:0] EX_MEM_RdAddr,
    input [4:0] ID_EX_RsAddr,
    input [4:0] ID_EX_RtAddr,
    input MEM_WB_Regwrite,
    input [4:0] MEM_WB_RdAddr

);
    always @(*) begin
        ForwardA = 2'b00;
        ForwardB = 2'b00;
        if (EX_MEM_RegWrite && (EX_MEM_RdAddr != 0) && (EX_MEM_RdAddr == ID_EX_RsAddr))begin
            ForwardA = 2'b10;
        end
        
        if (EX_MEM_RegWrite && (EX_MEM_RdAddr != 0) && (EX_MEM_RdAddr == ID_EX_RtAddr)) begin
            ForwardB = 2'b10;
        end

        if (MEM_WB_Regwrite && (MEM_WB_RdAddr != 0) && (MEM_WB_RdAddr == ID_EX_RsAddr)/* && (EX_MEM_RdAddr != ID_EX_RsAddr)*/) begin
            ForwardA = 2'b01;
        end

        if (MEM_WB_Regwrite && (MEM_WB_RdAddr != 0) && (MEM_WB_RdAddr == ID_EX_RtAddr)/* && (EX_MEM_RdAddr != ID_EX_RtAddr)*/) begin
            ForwardB = 2'b01;
        end
    end
endmodule
