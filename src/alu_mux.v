// src/alu_mux.v
`timescale 1ns / 1ps

module alu_mux(
    input  [2:0] op,
    input  [3:0] ADD_RES,
    input  [3:0] SUB_RES,
    input  [3:0] AND_R,
    input  [3:0] OR_R,
    input  [3:0] XOR_R,
    input        ADD_COUT,
    input        SUB_BORROW,
    input        ADD_OVF,
    input        SUB_OVF,
    output reg [3:0] Y,
    output reg       arith_carry_borrow,
    output reg       arith_overflow
);
    always @(*) begin
        case(op)
            3'b000: begin
                Y = ADD_RES;
                arith_carry_borrow = ADD_COUT;
                arith_overflow     = ADD_OVF;
            end
            3'b001: begin
                Y = SUB_RES;
                arith_carry_borrow = SUB_BORROW;
                arith_overflow     = SUB_OVF;
            end
            3'b010: begin
                Y = AND_R;
                arith_carry_borrow = 0;
                arith_overflow     = 0;
            end
            3'b011: begin
                Y = OR_R;
                arith_carry_borrow = 0;
                arith_overflow     = 0;
            end
            3'b100: begin
                Y = XOR_R;
                arith_carry_borrow = 0;
                arith_overflow     = 0;
            end
            default: begin
                Y = 4'b0000;
                arith_carry_borrow = 0;
                arith_overflow     = 0;
            end
        endcase
    end
endmodule
