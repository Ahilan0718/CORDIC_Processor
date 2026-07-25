//ARCTAN ROM TB
module atan_rom_test;

parameter WIDTH = 16;
parameter ADDR_WIDTH = 4;

reg [ADDR_WIDTH-1 : 0] addr;

wire signed [WIDTH-1 : 0] angle;

integer i;

atan_rom uut(.addr(addr),
             .angle(angle));
    
    initial begin

        $dumpfile("dump_rom.vcd");
        $dumpvars(0, atan_rom_test);

        for(i=0 ; i<16 ; i=i+1) begin

            addr = i;
            #10;

            $display("|    %2d    |    %5d    |    %h    |", addr, angle, angle);
        end
    
    end

endmodule


