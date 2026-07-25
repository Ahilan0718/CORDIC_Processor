//DATAPATH MODULE

module datapath #(parameter WIDTH = 16,
                  parameter ITERATION = 16) (
                  input clk,
                  input reset,
                  input load,
                  input load_init,
                  input gain_en,
                  input mode,
                  input signed [WIDTH-1 : 0] xin,
                  input signed [WIDTH-1 : 0] yin,
                  input signed [WIDTH-1 : 0] zin,
                  input [$clog2(ITERATION)-1 : 0] iter,
                  input signed [WIDTH-1 : 0] angle,
                  input dir,
                  output signed [WIDTH-1 : 0] x,
                  output signed [WIDTH-1 : 0] y,
                  output signed [WIDTH-1 : 0] z);

    wire signed [WIDTH-1 : 0] x_shift;
    wire signed [WIDTH-1 : 0] y_shift;
    wire signed [WIDTH-1 : 0] x_next;   
    wire signed [WIDTH-1 : 0] y_next;
    wire signed [WIDTH-1 : 0] z_next;
    wire signed [WIDTH-1 : 0] x_d;
    wire signed [WIDTH-1 : 0] y_d;
    wire signed [WIDTH-1 : 0] z_d;
    wire signed [WIDTH-1 : 0] x_gain;
    wire signed [WIDTH-1 : 0] y_gain;
    wire x_as;
    wire y_as;
    wire z_as;

    assign x_shift = x >>> iter;
    assign y_shift = y >>> iter;

    assign x_d = (load_init) ? xin : ((gain_en) ? x_gain : x_next);
    assign y_d = (load_init) ? yin : ((gain_en) ? y_gain : y_next);
    assign z_d = (load_init) ? zin : z_next;

    assign x_as = (mode) ? dir : ~dir;
    assign y_as = (mode) ? ~dir : dir;
    assign z_as = (mode) ? dir : ~dir;
 
    gen_reg #(.WIDTH(WIDTH)) X_reg(.clk(clk),
                  .reset(reset),
                  .load(load),
                  .d(x_d),
                  .q(x));
    
    gen_reg #(.WIDTH(WIDTH)) Y_reg(.clk(clk),
                  .reset(reset),
                  .load(load),
                  .d(y_d),
                  .q(y));

    gen_reg #(.WIDTH(WIDTH)) Z_reg(.clk(clk),
                  .reset(reset),
                  .load(load),
                  .d(z_d),
                  .q(z));

    add_sub #(.WIDTH(WIDTH)) X_addsub(
              .A(x),
              .B(y_shift),
              .sub(x_as),
              .result(x_next));

    add_sub #(.WIDTH(WIDTH)) Y_addsub(
              .A(y),
              .B(x_shift),
              .sub(y_as),
              .result(y_next));

    add_sub #(.WIDTH(WIDTH)) Z_addsub(
              .A(z),
              .B(angle),
              .sub(z_as),
              .result(z_next));

    gain_comp #(.WIDTH(WIDTH)) gain(
                .x(x),
                .y(y),
                .x_gain(x_gain),
                .y_gain(y_gain));

endmodule
    

