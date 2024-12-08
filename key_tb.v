`timescale 1ns / 1ps
`include "keyExpan.v"

module key_tb();

    // Inputs
    reg clk;
    reg expanEn;
    reg reset;
    reg [0:3] round;
    reg [0:127] inputKey;
    // Outputs
    wire [0:127] roundKey;

    keyExpan keyExpan_inst(
        .clk(clk),
        .expanEn(expanEn),
        .reset(reset),
        .round(round),
        .inputKey(inputKey),
        .roundKey(roundKey)
    );

    // Clock generation
    initial begin
        clk = 1'b1;
        forever #5 clk = ~clk; // Generates a clock with a period of 10 time units
    end

    // Test procedure
    initial begin
        $dumpfile("key_tb.vcd");
        $dumpvars(0, key_tb);

        expanEn = 0;
        reset = 1;
        #4;
        reset = 0;
        inputKey = 128'h2b7e151628aed2a6abf7158809cf4f3c;

        // Enable key expansion
        expanEn = 1;

        // Test case 1: Round 0
        #6;
        round = 4'b0000;
        #10;

        // Test case 2: Round 1
        round = 4'b0001;
        #10;

        // Test case 3: Round 2
        round = 4'b0010;
        #10;

        // Test case 4: Round 3
        round = 4'b0011;
        #10;

        // Disable key expansion
        expanEn = 0;
        #20;

        $finish;
    end

endmodule
