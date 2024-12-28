`timescale 1ns/1ps
`include "keyExpan.v"
module keytb;

    // Parameters
    parameter KEY_WIDTH = 128;
    parameter EXPANDED_KEY_WIDTH = 1408; // 128 bits for each round key, 11 keys total

    // Inputs
    reg clk;
    reg reset_n;
    reg en;
    reg [KEY_WIDTH-1:0] initial_key;

    // Outputs
    wire [EXPANDED_KEY_WIDTH-1:0] key_reg;

    // DUT instantiation
    keyExpan uut (
        .clk(clk),
        .en(en),
        .initial_key(initial_key),
        .reset_n(reset_n),
        .key_reg(key_reg)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Testbench variables
    integer i;

    // Task to reset the DUT
    task reset_dut;
        begin
            reset_n = 0;
            en = 0;
            initial_key = 0;
            #20;
            reset_n = 1;
            #10;
        end
    endtask

    // Task to start key expansion
    task start_key_expansion(input [KEY_WIDTH-1:0] key);
        begin
            initial_key = key;
            en = 1;
            #10;
            en = 0;
        end
    endtask

    // Monitor the generated keys
    task monitor_keys;
        begin
            for (i = 0; i <= 10; i = i + 1) begin
                $display("Round %0d Key: %h", i, key_reg[(i+1)*KEY_WIDTH-1 -: KEY_WIDTH]);
            end
        end
    endtask

    // Test sequence
    initial begin
        $display("Starting Testbench for keyExpan module");

        // Apply reset
        reset_dut();

        // Test case 1: Key expansion for a sample key
        $display("Test Case 1: Key Expansion for initial key 0x2b7e151628aed2a6abf7158809cf4f3c");
        start_key_expansion(128'h2b7e151628aed2a6abf7158809cf4f3c);

        // Wait for key expansion to complete (11 keys * 1 clock cycle per key)
        #150;

        // Monitor the keys
        monitor_keys();

        // Test case 2: Key expansion for another key
        $display("Test Case 2: Key Expansion for initial key 0x2b7e151628aed2a6abf7158809cf4f3c");
        start_key_expansion(128'h2b7e151628aed2a6abf7158809cf4f3c);

        // Wait for key expansion to complete
        #150;

        // Monitor the keys
        monitor_keys();

        // End simulation
        $stop;
    end
    initial begin
     $dumpfile("keytb.vcd") ;
     $dumpvars(0, keytb) ;
    end

endmodule
