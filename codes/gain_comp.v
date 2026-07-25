//GAIN COMPENSATOR MODULE

module gain_comp #(parameter WIDTH = 16) (
                   input signed [WIDTH-1 : 0] x,
                   input signed [WIDTH-1 : 0] y,
                   output signed [WIDTH-1 : 0] x_gain,
                   output signed [WIDTH-1 : 0] y_gain);
    
    localparam signed K_inverse = 16'd4975; //inverse value to be multiplier with initial values

    wire signed [(2*WIDTH)-1 : 0] x_multi;
    wire signed [(2*WIDTH)-1 : 0] y_multi;

    assign x_multi = x * K_inverse;
    assign y_multi = y * K_inverse;

    assign x_gain = x_multi >>> 13;
    assign y_gain = y_multi >>> 13;

endmodule
