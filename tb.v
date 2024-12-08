`include "controlpath.v"
`timescale 1ns / 1ps

module tb;

// Inputs for AES
reg clk, reset , clk2, clkbs , clksr , clkmc , clkka; // Clock and reset
reg [127:0] data, aes_key; // Input data and key

// Outputs for AES
wire [127:0] cypherText; // Output ciphertext
wire [3:0] round; 
reg start ;       // Current round

// Internal signals
wire done;

// Instantiate the AES controlpath
controlpath DUT(.clk(clk) ,.clkbs(clkbs), .clksr(clksr) , .clkmc(clkmc) , .clkka(clkka) , .reset(reset) , .start(start) , .data(data) , .key(aes_key) , .round( round ), .cypherText(cypherText)) ;

// Clock generation
initial begin
    clk = 1'b1;
    forever #5 clk = ~clk; // 10ns clock period
end



initial begin
    clkbs = 1'b0 ;
    #11 ;
    clkbs = 1'b1 ;
    forever #5 clkbs = ~clkbs ;   
end

initial begin
    clksr = 1'b0 ;
    #12 ;
    clksr = 1'b1 ;
    forever #5 clksr = ~clksr ;   
end

initial begin
    clkmc = 1'b0 ;
    #13 ;
    clkmc = 1'b1 ;
    forever #5 clkmc = ~clkmc ;   
end

initial begin
    clkka = 1'b0 ;
    #16 ;
    clkka = 1'b1 ;
    forever #5 clkka = ~clkka ;   
end


// Test vectors (example for AES-128)
initial begin
    // Initialize control signals
    
    reset = 1 ;
    // Waveform dump
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #4 ; reset = 0 ;
    data = 128'h3243f6a8885a308d313198a2e0370734; // Example plaintext
    aes_key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    // Apply reset
    #6 start = 1; // Release reset after 10ns
    
    wait(round == 4'ha) ;

    #1

   
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
