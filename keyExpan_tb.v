`timescale 1ps/1ps
`include "keyExpan.v"

module keyExpan_tb();
     
    reg [0:127] initial_key;
    wire [0:1407] key_reg;
     integer k ;
    // Instantiate the keyExpan module
    keyExpan DUT (
        .initial_key(initial_key),
        .key_reg(key_reg)
    );

    initial begin
        // Input initial key
        $dumpfile("tb.vcd");
     $dumpvars(0, keyExpan_tb);
        initial_key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

        #10;

        // Display all 11 round keys
        $display("AES Key Expansion Results:");
        for ( k = 0; k < 11; k = k + 1) begin
            $display("RoundKey %0d: %h", k, key_reg[k*128 +: 128]);
        end

        #10;
        $finish;
    end
endmodule
