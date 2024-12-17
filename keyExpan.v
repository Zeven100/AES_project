`ifndef KEYEXPAN_V
`define KEYEXPAN_V

`include "byteSub.v"
`include "round_cf.v"
module keyExpan ( // keyExpan KE_inst(.key_reg_filled() , .initial_key() , .key_reg()) ;
    input [0:127] initial_key,     // Input: Initial 128-bit key
    output [0:1407] key_reg        // Output: Expanded round keys (11 x 128 = 1408 bits)
);

   
    wire [0:31] circ [1:10];
    wire [0:31] sub_circ [1:10];
    wire [0:31] rc [1:10];
    wire [0:3] round_num [1:10];

    // Reverse the bits of the initial key
    genvar i;


    // Initial key assignment with the reversed key
    assign key_reg[0 +: 128] = initial_key;

    // Assign round numbers and generate the round keys
    generate
        for (i = 1; i <= 10; i = i + 1) begin : round_constants
            assign round_num[i] = i; // 4-bit round number
            assign circ[i] = {key_reg[(i-1)*128 + 104 +: 24], key_reg[(i-1)*128 + 96 +: 8]}; // RotWord
            byteSub bs(.in(circ[i]), .out(sub_circ[i]));                                     // SubWord
            round_cf rcoeff(.r(round_num[i]), .cf(rc[i]));                                   // Round constant

            // Generate 128-bit round keys
            assign key_reg[i*128 + 0 +: 32]   = key_reg[(i-1)*128 + 0 +: 32] ^ sub_circ[i] ^ rc[i]; // First word
            assign key_reg[i*128 + 32 +: 32]  = key_reg[(i-1)*128 + 32 +: 32] ^ key_reg[i*128 + 0 +: 32]; // Second word
            assign key_reg[i*128 + 64 +: 32]  = key_reg[(i-1)*128 + 64 +: 32] ^ key_reg[i*128 + 32 +: 32]; // Third word
            assign key_reg[i*128 + 96 +: 32]  = key_reg[(i-1)*128 + 96 +: 32] ^ key_reg[i*128 + 64 +: 32]; // Fourth word
        end
    endgenerate

endmodule
`endif 