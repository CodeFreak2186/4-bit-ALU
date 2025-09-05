`timescale 1ns / 1ps

module add4(
    input  [3:0] A,
    input  [3:0] B,
    output [3:0] SUM,
    output       COUT,
    output       OVF
);
    wire [4:0] full_sum;
    assign full_sum = {1'b0, A} + {1'b0, B};
    assign SUM  = full_sum[3:0];
    assign COUT = full_sum[4];
    assign OVF  = (~(A[3] ^ B[3])) & (SUM[3] ^ A[3]);
endmodule
