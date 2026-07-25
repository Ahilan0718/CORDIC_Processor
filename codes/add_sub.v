//ADDER SUBTRACTOR MODULE
module add_sub #(parameter WIDTH  = 16) (
                 input signed [WIDTH-1 : 0] A,
                 input signed [WIDTH-1 : 0] B,
                 input sub,
                 output signed [WIDTH-1 : 0] result);

    assign result = (sub) ? (A - B) : (A + B);

endmodule