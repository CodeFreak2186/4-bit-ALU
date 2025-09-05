
`timescale 1ns / 1ps

module alu_4bit(
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] op,
    output [3:0] Y,
    output       carry_out,
    output       zero,
    output       sign,
    output       overflow
);

    // Wires for intermediate results
    wire [3:0] add_res, sub_res, and_r, or_r, xor_r;
    wire       add_cout, sub_borrow, add_ovf, sub_ovf;
    wire       arith_carry_borrow, arith_overflow;

    // Instantiate submodules
    add4 u_add (
        .A(A),
        .B(B),
        .SUM(add_res),
        .COUT(add_cout),
        .OVF(add_ovf)
    );

    sub4 u_sub (
        .A(A),
        .B(B),
        .DIFF(sub_res),
        .BORROW(sub_borrow),
        .OVF(sub_ovf)
    );

    logic4 u_logic (
        .A(A),
        .B(B),
        .AND_R(and_r),
        .OR_R(or_r),
        .XOR_R(xor_r)
    );

    alu_mux u_mux (
        .op(op),
        .ADD_RES(add_res),
        .SUB_RES(sub_res),
        .AND_R(and_r),
        .OR_R(or_r),
        .XOR_R(xor_r),
        .ADD_COUT(add_cout),
        .SUB_BORROW(sub_borrow),
        .ADD_OVF(add_ovf),
        .SUB_OVF(sub_ovf),
        .Y(Y),
        .arith_carry_borrow(arith_carry_borrow),
        .arith_overflow(arith_overflow)
    );

    flag_unit u_flags (
        .Y(Y),
        .arith_carry_borrow(arith_carry_borrow),
        .arith_overflow(arith_overflow),
        .op(op),
        .carry_out(carry_out),
        .zero(zero),
        .sign(sign),
        .overflow(overflow)
    );

endmodule
