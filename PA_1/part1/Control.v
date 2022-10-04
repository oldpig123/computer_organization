module Control (
    input reset,run,clk,lsb,
    output reg w_ctrl,srl_ctrl,ready,
    output reg [5:0] addu_ctrl
);
    reg [5:0] counter;

    assign addu_ctrl = {5'b00000,lsb};
    always @(posedge clk or posedge reset) begin
        if(reset == 1) begin
            w_ctrl = 1;
            counter = 0;
            srl_ctrl = 0;
            addu_ctrl = 6'b0;
            ready = 0;
        end
        else if (run == 1 && ready == 0) begin
            if (counter < 32) begin
                w_ctrl = 0;
                srl_ctrl = 1;
                // if (lsb == 1) begin
                //     addu_ctrl = 6'b000001;
                // end
                // else begin
                //     addu_ctrl = 6'b000000;
                // end
                counter = counter + 1;
            end
            else if (counter == 32)begin
                ready = 1;
                counter = 0;
                srl_ctrl = 0;
            end
        end

    end
endmodule
