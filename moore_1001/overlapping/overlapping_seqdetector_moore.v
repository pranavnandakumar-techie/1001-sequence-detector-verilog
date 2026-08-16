`timescale 1ns / 1ps
module _dflip(D,CLK,q,qd);
    input D,CLK;
    output reg q,qd;
    initial begin 
        q=0;
        qd=1;
    end
    always@(negedge CLK) begin
        q=D;
        qd=~D;
    end
endmodule
module overlapping_seqdetector_moore(x,CLK,y);
    input x,CLK;
    output y;
    wire q2,q1,q0,d2,d1,d0,qd2,qd1,qd0;
    assign d2=(~x)&q1&(~q0);
    assign d1=((~x)&q0) | (x&q2);
    assign d0=x;
    assign y=q1&q0;
    _dflip flip2(d2,CLK,q2,qd2);
    _dflip flip1(d1,CLK,q1,qd1);
    _dflip flip0(d0,CLK,q0,qd0);
endmodule

