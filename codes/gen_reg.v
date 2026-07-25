//GENERAL REGISTER MODULE
module gen_reg #(parameter WIDTH = 16) (
                 input clk,
                 input reset,
                 input load,
                 input signed [WIDTH-1 : 0] d,
                 output reg signed [WIDTH-1 : 0] q);

    always @(posedge clk) begin

        if(reset) begin

            q <= 0;
        end

        else if(load) begin

            q <= d;
        end
    end

endmodule

