//CONTROL FSM TB

module control_fsm_test;

parameter ITERATION = 16;

reg clk;
reg reset;
reg start;

wire load;
wire load_init;
wire [3:0] iter;
wire done;

control_fsm #(.ITERATION(ITERATION)) uut(
              .clk(clk),
              .reset(reset),
              .start(start),
              .load(load),
              .load_init(load_init),
              .iter(iter),
              .done(done));

    always #5 clk = ~clk;

    initial begin   

        $dumpfile("dump_fsm.vcd");
        $dumpvars(0, control_fsm_test);
        $display("TIME\tSTATE\tLOAD\tINIT\tITER\tDONE");
        $monitor("%0t\t%d\t%d\t%b\t%b\t%b", $time, uut.state, load, load_init, iter, done);

        clk = 1'b0;
        reset = 1'b1;
        start = 1'b0;
        #20;

        reset = 1'b0;
        #10;

        start = 1'b1;

        wait(done == 1)

        $display("ITERATION COUNT = %d", iter);

        #20;

        start = 1'b0;
        #20;

        $finish;
    end

endmodule
    
