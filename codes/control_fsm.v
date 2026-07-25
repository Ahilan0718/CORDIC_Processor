//CONTROL FSM MODULE

module control_fsm #(parameter ITERATION = 16) (
                   input clk,
                   input reset,
                   input start,
                   output reg load,
                   output reg load_init,
                   output reg [$clog2(ITERATION)-1 : 0] iter,
                   output reg gain_en,
                   output reg done);
    
    localparam IDLE = 3'd0;
    localparam LOAD = 3'd1;
    localparam ITERATE = 3'd2;
    localparam GAIN = 3'd3;
    localparam DONE = 3'd4;

    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk) begin //STATE REGISTER

        if(reset) begin

            state <= IDLE;
        end

        else begin

            state <= next_state;
        end
    end

    always @(*) begin //NEXT STATE LOGIC

        next_state = state;

        case(state) 

            IDLE: begin
                if(start) begin

                    next_state = LOAD;
                end

                else begin

                    next_state = IDLE;
                end
            end

            LOAD: begin

                next_state = ITERATE;
            end

            ITERATE: begin

                if(iter == ITERATION-1) begin    

                    next_state = GAIN;
                end

                else begin

                    next_state = ITERATE;
                end
            end

            GAIN: begin

                next_state = DONE;
            end

            DONE: begin 

                if(~start) begin
                
                    next_state = IDLE;
                end

                else begin

                    next_state = DONE;
                end
            end

            default: begin

                next_state = IDLE;
            end
        endcase
    end

    always @(*) begin //OUTPUT LOGIC

        load = 1'b0;
        load_init = 1'b0;
        gain_en = 1'b0;
        done = 1'b0;

        case(state) 

            IDLE: begin
            end

            LOAD: begin 

                load = 1'b1;
                load_init = 1'b1;
            end

            ITERATE: begin

                load = 1'b1;
                load_init = 1'b0;
            end

            GAIN: begin

                load = 1'b1;
                gain_en = 1'b1;
            end

            DONE: begin

                load = 1'b0;
                load_init = 1'b0;
                done = 1'b1;
            end
        endcase
    end

    always @(posedge clk) begin //ITERATION COUNTER LOGIC

        if(reset) begin

            iter <= 0;
        end

        else if(state == LOAD) begin

            iter <= 0;
        end

        else if((state == ITERATE) && (iter < ITERATION-1)) begin

            iter <= iter + 1;
        end
    end

endmodule

        



