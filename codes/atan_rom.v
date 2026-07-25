//ARCTAN ROM ITERATION VALUES MODULE

module atan_rom #(WIDTH = 16,
                  ADDR_WIDTH = 4)
                 (input [ADDR_WIDTH-1 : 0] addr,
                  output reg signed [WIDTH-1 : 0] angle);
    
    always @(*) begin

        case(addr) //Q3.13 fixed point values for each iteration

            4'd0: angle = 16'h1922;
            4'd1: angle = 16'h0ED6;
            4'd2: angle = 16'h07D7;
            4'd3: angle = 16'h03FB;
            4'd4: angle = 16'h01FF;
            4'd5: angle = 16'h0100;
            4'd6: angle = 16'h0080;
            4'd7: angle = 16'h0040;
            4'd8: angle = 16'h0020;
            4'd9: angle = 16'h0010;
            4'd10: angle = 16'h0008;
            4'd11: angle = 16'h0004;
            4'd12: angle = 16'h0002;
            4'd13: angle = 16'h0001;
            4'd14: angle = 16'h0000;
            4'd15: angle = 16'h0000;
        endcase
    end

endmodule