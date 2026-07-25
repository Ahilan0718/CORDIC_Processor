//CORDIC TOP INTEGRATION TB

module cordic_top_test;

parameter WIDTH = 16;
parameter ITERATION = 16;

reg clk;
reg reset;
reg start;
reg mode;
reg signed [WIDTH-1 : 0] xin;
reg signed [WIDTH-1 : 0] yin;
reg signed [WIDTH-1 : 0] zin;

wire signed [WIDTH-1 : 0] x;
wire signed [WIDTH-1 : 0] y;
wire signed [WIDTH-1 : 0] z;
wire done;

cordic_top #(.WIDTH(WIDTH),
             .ITERATION(ITERATION)) uut(
             .clk(clk),
             .reset(reset),
             .start(start),
             .mode(mode),
             .xin(xin),
             .yin(yin),
             .zin(zin),
             .x(x),
             .y(y),
             .z(z),
             .done(done));
    
    always #5 clk = ~clk;

    task check_rotation;

        input signed [15:0] x_in;
        input signed [15:0] y_in;
        input signed [15:0] z_in;

        input signed [15:0] e_xo;
        input signed [15:0] e_yo;
        input signed [15:0] e_zo;
    
    begin

        mode = 1'b0;

        xin = x_in;
        yin = y_in;
        zin = z_in;

        @(posedge clk);
        start = 1'b1;

        @(posedge clk);
        start = 1'b0;

        wait(done);

        #1;

        $display("Expected:");
        $display("X = %f", $itor(e_xo)/8192.0);
        $display("Y = %f", $itor(e_yo)/8192.0);
        $display("Z = %f", $itor(e_zo)/8192.0);

        $display("Actual:");
        $display("X = %f", $itor(x)/8192.0);
        $display("Y = %f", $itor(y)/8192.0);
        $display("Z = %f", $itor(z)/8192.0);

        if((x == e_xo) && (y == e_yo) && (z == e_zo)) begin

            $display("PASS");
        end

        else begin

            $display("FAIL");
        end

        @(posedge clk);
    end
    endtask

    task check_vectoring;

        input signed [15:0] x_in;
        input signed [15:0] y_in;

        input signed [15:0] e_mag;
        input signed [15:0] e_angle;
    
    begin

        mode = 1'b1;

        xin = x_in;
        yin = y_in;
        zin = 16'd0;

        @(posedge clk);
        start = 1'b1;

        @(posedge clk);
        start = 1'b0;

        wait(done);

        #1;

        $display("Expected Magnitude = %f", $itor(e_mag)/8192.0);
        $display("Actual   Magnitude = %f", $itor(x)/8192.0);

        $display("Expected Angle = %f", $itor(e_angle)/8192.0);
        $display("Actual   Angle = %f", $itor(z)/8192.0);

        if((x == e_mag) && (y == 0) && (z == e_angle)) begin

            $display("PASS");
        end

        else begin

            $display("FAIL");
        end

        @(posedge clk);
    end
    endtask

    initial begin

        $dumpfile("dump_top.vcd");
        $dumpvars(0, cordic_top_test);

        clk = 1'b0;
        reset = 1'b1;
        start = 1'b0;
        xin = 16'd0; // 1/1.646760258 = 0.607252935, 0.607252935*8192 = 4975
        yin = 16'd0; // 0/1.646760258 = 0, 0*8192 = 0000
        zin = 16'd0; // pi/3 = 1.04716966, 1.04716966*8192

        #10;

        reset = 1'b0;
        #10; 

        check_rotation(8192,0,0,8192,0,0);
        check_rotation(8192,0,4289,7094,4096,0);
        check_rotation(8192,0,6434,5793,5793,0);
        check_rotation(8192,0,8578,4096,7094,0);
        check_rotation(8192,0,12868,0,8192,0);
        check_rotation(8192,0,-4289,7094,-4096,0);
        check_rotation(8192,0,-6434,5793,-5793,0);
        check_rotation(8192,0,-8578,4096,-7094,0);

        check_vectoring(8192,0,8192,0);
        check_vectoring(8192,8192,11585,6434);
        check_vectoring(16384,8192,18318,3805);
        check_vectoring(4096,4096,5793,6434);
        check_vectoring(0,8192,8192,12868);
        check_vectoring(0,-8192,8192,-12868);
        check_vectoring(8192,-8192,11585,-6434);
        check_vectoring(16384,-8192,18318,-3805);

        #30;
        $finish;
    end

endmodule


