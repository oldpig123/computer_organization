module Hazard_Detection (
    output reg PCWrite,
    output reg IF_ID_Write,
    output reg Stall,
    input ID_EX_MemRead,
    input [4:0] ID_EX_RtAddr,
    input [4:0] IF_ID_RsAddr,
    input [4:0] IF_ID_RtAddr
);
    initial begin
        Stall = 0;
        IF_ID_Write = 1;
        PCWrite = 1;
    end

    always @(*) begin
        if(ID_EX_MemRead && ((ID_EX_RtAddr == IF_ID_RsAddr)||(ID_EX_RtAddr == IF_ID_RtAddr)))begin
            PCWrite = 0;
            Stall = 1;
            IF_ID_Write = 0;
        end
        else begin
            PCWrite = 1;
            Stall = 0;
            IF_ID_Write = 1;
        end
    end
endmodule
