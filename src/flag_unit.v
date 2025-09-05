// src/flag_unit.v
`timescale 1ns / 1ps

module flag_unit(
    input  [3:0] Y,
    input        arith_carry_borrow,
    input        arith_overflow,
    input  [2:0] op,
    output       carry_out,
    output       zero,
    output       sign,
    output       overflow
);
    assign zero  = (Y == 4'b0000);
    assign sign  = Y[3];
    assign carry_out = arith_carry_borrow;
    assign overflow  = arith_overflow;
endmodule
