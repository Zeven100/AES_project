`include "controlpath.v"
`timescale 1ns / 1ps

module aes_testbench;

// Inputs for AES
reg clk, reset_signal; // Clock and reset
reg [127:0] data, aes_key; // Input data and key

// Outputs for AES
wire [127:0] cypherText; // Output ciphertext
wire [3:0] round; 
reg start ;       // Current round

// Internal signals
wire done;

// Instantiate the AES controlpath
controlpath cp_inst (
    .clk(clk),
    .reset(reset_signal),
    .data(data),
    .key(aes_key),
    .cypherText(cypherText),
    .round(round),
    .start(start)
);

// Clock generation
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk; // 10ns clock period
end

// Test vectors (example for AES-128)
initial begin
    // Initialize control signals
    start = 0; // Hold reset high initially
    reset_signal = 0 ;
    // Waveform dump
    $dumpfile("aes_testbench.vcd");
    $dumpvars(0, aes_testbench);

    // Apply reset
    #5 start = 1; // Release reset after 10ns
    #10 start = 0 ;
    // Apply inputs
    #1 data = 128'h3243f6a8885a308d313198a2e0370734; // Example plaintext
    #1 aes_key = 128'h2b7e151628aed2a6abf7158809cf4f3c; // Example AES key

    // Wait for the encryption process to complete
    # 110 

   
    if (cypherText == 128'h3925841d02dc09fbdc118597196a0b32) begin
        $display("Test Passed! AES output matches expected ciphertext.");
    end else begin
        $display("Test Failed! AES output does not match expected ciphertext.");
        $display("Expected: 3925841d02dc09fbdc118597196a0b32, Got: %h", cypherText);
    end

    // End simulation
    #10 $finish;
end

endmodule
