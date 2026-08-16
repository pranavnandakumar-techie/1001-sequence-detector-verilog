`timescale 1ns / 1ps
module tb_nonoverlapping_seqdetector_moore();
    reg x,CLK;
    wire y;
    non_overlapping_seqdetector_moore dut(x,CLK,y);
    initial begin
        CLK=0;
        forever #5 CLK=~CLK;
    end
    initial begin
       x=1;#15;
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
       x=0;#10;
       x=1;#10;
       x=0;#10;
       x=0;#10;
       x=1;#10;
       $finish;
    end
endmodule

