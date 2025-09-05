// tb/alu4_tb.v
`timescale 1ns / 1ps

module alu4_tb;

    reg [3:0] A, B;
    reg [2:0] op;

    wire [3:0] Y;
    wire carry_out, overflow, zero, sign;

    alu_4bit dut (
        .A(A),
        .B(B),
        .op(op),
        .Y(Y),
        .carry_out(carry_out),
        .overflow(overflow),
        .zero(zero),
        .sign(sign)
    );

    integer i, j;
    integer outfile;  // file handle
    reg [4:0] expected_sum, expected_diff;
    reg [3:0] expected_logic;
    reg expected_carry, expected_ovf, expected_zero, expected_sign;

    initial begin
        $dumpfile("alu4_tb.vcd");
        $dumpvars(0, alu4_tb);

        // Open file for writing
        outfile = $fopen("alu4_results.txt", "w");
        if (!outfile) begin
            $display("Error: Could not open file!");
            $finish;
        end

        $fdisplay(outfile, "Starting ALU Testbench...");

        for (op = 3'b000; op <= 3'b100; op = op + 1) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    A = i;
                    B = j;
                    #5;  // propagate

                    // Compute expected results
                    case(op)
                        3'b000: begin // ADD
                            expected_sum = A + B;
                            expected_logic = expected_sum[3:0];
                            expected_carry = expected_sum[4];
                            expected_ovf = (~(A[3] ^ B[3])) & (expected_logic[3] ^ A[3]);
                        end
                        3'b001: begin // SUB
                            expected_diff = A - B;
                            expected_logic = expected_diff[3:0];
                            expected_carry = ~expected_diff[4]; // borrow
                            expected_ovf = (A[3] ^ B[3]) & (expected_logic[3] ^ A[3]);
                        end
                        3'b010: expected_logic = A & B;
                        3'b011: expected_logic = A | B;
                        3'b100: expected_logic = A ^ B;
                        default: expected_logic = 4'b0000;
                    endcase

                    if (op > 3'b001) begin
                        expected_carry = 0;
                        expected_ovf = 0;
                    end

                    expected_zero = (expected_logic == 0);
                    expected_sign = expected_logic[3];

                    // Write to file
                    $fdisplay(outfile, "op=%b, A=%d, B=%d => Y=%b, C=%b, OVF=%b, Z=%b, S=%b",
                        op, A, B, Y, carry_out, overflow, zero, sign
                    );
                end
            end
        end

        $fdisplay(outfile, "ALU Testbench completed.");
        $fclose(outfile);
        $finish;
    end
endmodule
