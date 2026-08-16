`timescale 1ns / 1ps
module __dflip(D,CLK,q,qd);
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
module non_overlapping_seqdetector_moore(x,CLK,y);
    input x,CLK;
    output y;
    wire q2,q1,q0,d2,d1,d0,qd2,qd1,qd0;
    assign d2=x&q1&q0;
    assign d1=((~x)&(~q1)&(q0)) | ((~x)&q1&(~q0));
    assign d0=(x&(~q1)) | (q1&(~q0));
    assign y=q2;
    __dflip flip2(d2,CLK,q2,qd2);
    __dflip flip1(d1,CLK,q1,qd1);
    __dflip flip0(d0,CLK,q0,qd0);
endmodule

