`timescale 1ns / 1ps
module d_flip(D,CLK,Q,Qd);
    input D,CLK;
    output reg Q,Qd;
    initial begin
        Q=0;
        Qd=1;
    end
    always@(negedge CLK) begin
        Q=D;
        Qd=~D;
    end
endmodule
module non_overlapping_seqdetector_mealy(x,CLK,y);
    input x,CLK;
    output y;
    wire q1,q0,d1,d0,qd0,qd1;
    assign d1=((~x)&(~q1)&q0) | ((~x)&q1&(~q0));
    assign d0=(x&(~q1)) | (q1&(~q0));
    assign y=x&q1&q0;
    d_flip FF0(d0,CLK,q0,qd0);
    d_flip FF1(d1,CLK,q1,qd1);
endmodule

