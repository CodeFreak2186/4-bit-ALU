
`timescale 1ns / 1ps

module logic4(
    input  [3:0] A,
    input  [3:0] B,
    output [3:0] AND_R,
    output [3:0] OR_R,
    output [3:0] XOR_R
);
    assign AND_R = A & B;
    assign OR_R  = A | B;
    assign XOR_R = A ^ B;
endmodule
