module Control (
    input reset,run,clk,
    output reg w_ctrl,srl_ctrl,ready,sll_ctrl,
    output reg [5:0] subu_ctrl
);
    reg [5:0] counter;
    always @(posedge clk or posedge reset) begin
        if(reset == 1) begin
            w_ctrl = 1;
            counter = 0;
            srl_ctrl = 0;
            sll_ctrl = 0;
            subu_ctrl = 6'b0;
            ready = 0;
        end
        else if (run == 1 && ready == 0) begin
            if (counter < 32) begin
                w_ctrl = 0;
                sll_ctrl = 1;
                subu_ctrl = 6'b000010;
                counter = counter + 1;
            end
            else if (counter == 32)begin
                sll_ctrl = 0;
                srl_ctrl = 1;
                counter = counter +1;
            end
            else begin
                ready = 1;
                srl_ctrl = 0;
            end
        end

    end
endmodule

