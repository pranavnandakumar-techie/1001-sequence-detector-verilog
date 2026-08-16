`timescale 1ns / 1ps
module tb_overlapping_seqdetector_mealy();
    reg x,CLK;
    wire y;
    overlapping_seqdetector_mealy dut(x,CLK,y);
    initial begin 
        CLK=0;
        forever #5 CLK=~CLK;
    end
    initial begin
        x=1;#5;
        x=1;#10;
        x=0;#10;
        x=0;#10;
        x=1;#10;
        x=0;#10;
        x=0;#10;
        x=1;#10;
        x=0;#10;
        x=0;#10;
        x=1;#10;
        x=0;#10;
        x=0;#10;
        x=0;#10;
        x=0;#10;
        x=1;#10;
        x=0;#10;
        x=0;#10;
        x=1;#10;
        $finish;
    end
endmodule

