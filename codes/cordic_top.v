//CORDIC TOP INTEGRATION MODULE

module cordic_top #(parameter WIDTH = 16, parameter ITERATION = 16) (
                    input clk,
                    input reset,
                    input start,
                    input mode,
                    input signed [WIDTH-1 : 0] xin,
                    input signed [WIDTH-1 : 0] yin,
                    input signed [WIDTH-1 : 0] zin,
                    output signed [WIDTH-1 : 0] x,
                    output signed [WIDTH-1 : 0] y,
                    output signed [WIDTH-1 : 0] z,
                    output done);
    
    wire load;
    wire load_init;
    wire [$clog2(ITERATION)-1 : 0] iter;
    wire signed [WIDTH-1 : 0] angle;
    wire dir;
    wire gain_en;

    assign dir = (mode) ? y[WIDTH-1] : z[WIDTH-1];

    control_fsm #(.ITERATION(ITERATION)) FSM(
                  .clk(clk),
                  .reset(reset),
                  .start(start),
                  .load(load),
                  .load_init(load_init),
                  .iter(iter),
                  .gain_en(gain_en),
                  .done(done));

    atan_rom #(.WIDTH(WIDTH),
               .ADDR_WIDTH($clog2(ITERATION))) ATR(
               .addr(iter),
               .angle(angle));
    
    datapath #(.WIDTH(WIDTH)) DP(
               .clk(clk),
               .reset(reset),
               .load(load),
               .load_init(load_init),
               .gain_en(gain_en),
               .mode(mode),
               .xin(xin),
               .yin(yin),
               .zin(zin),
               .iter(iter),
               .angle(angle),
               .dir(dir),
               .x(x),
               .y(y),
               .z(z));
    
endmodule