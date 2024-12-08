`include "byteSub.v"
`include "round_cf.v"

module keyExpan ( // ( .expanEn() , .reset() , .clk() , .round() , .inputKey() , .roundKey() ) ;
    input expanEn,    // Enable signal for expansion
    input reset,      // Reset signal
    input clk,        // Clock signal
    input [0:3] round,   // Round number
    input [0:127] inputKey,  // Initial input key
    output reg [0:127] roundKey , // Output the current round key,
    output reg[0:127]nextRoundKey
);

    reg [0:127] currentKey;  // Store the current key
    reg [0:127] newKey;      // Store the newly calculated key
    wire [0:31] circ;        // Temporary register for word rotation
    wire [0:31] sub_circ;    // Output of byte substitution
    wire [0:31] rc;          // Round constant
     reg [0:3] i = 4'b0001 ;
    // Calculate the rotated word and use byte substitution and round constant calculation
    assign circ = {currentKey[104 +: 24], currentKey[96 +: 8]}; // Rotate last word
    byteSub bs(.in(circ), .out(sub_circ)); // Perform byte substitution
    round_cf rcoeff(.r(i), .cf(rc)); // Get round constant based on round

    // Initialize roundKey and currentKey
    always @(inputKey) begin
        roundKey = inputKey;
        currentKey = inputKey;
    end

    // Handle round logic
    always @(round) begin
        if (reset) begin
            currentKey = 0;
            newKey = 0;
            roundKey = 0;
        end else if (expanEn) begin
            if (round == 0) begin
                roundKey = inputKey; // At round 0, the round key is the input key
            end else if (round >= 1 && round <= 10) begin
                roundKey = newKey; // For subsequent rounds, use the newKey
            end
        end
    end

    // Calculate new key on negative clock edge
    always @(negedge clk) begin
        if (expanEn && round <= 10) begin
            // Compute the new round key based on the AES key expansion formula
            newKey[0 +: 32] = currentKey[0 +: 32] ^ sub_circ ^ rc; // First word
            newKey[32 +: 32] = currentKey[32 +: 32] ^ newKey[0 +: 32]; // Second word
            newKey[64 +: 32] = currentKey[64 +: 32] ^ newKey[32 +: 32]; // Third word
            newKey[96 +: 32] = currentKey[96 +: 32] ^ newKey[64 +: 32]; // Fourth word

            // Update currentKey for the next round
            currentKey = newKey;
            nextRoundKey = newKey ;
            i <= i + 1 ;
        end
    end
endmodule
