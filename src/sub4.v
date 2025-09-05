// src/sub4.v
`timescale 1ns / 1ps

module sub4(
    input  [3:0] A,
    input  [3:0] B,
    output [3:0] DIFF,
    output       BORROW,
    output       OVF
);
    wire [4:0] full_diff;
    assign full_diff = {1'b0, A} - {1'b0, B};
    assign DIFF   = full_diff[3:0];
    assign BORROW = ~full_diff[4];  // borrow if MSB=0
    assign OVF    = (A[3] ^ B[3]) & (DIFF[3] ^ A[3]);
endmodule
