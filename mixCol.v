module mixCol ( // mixCol mixCol_inst ( .reset(reset) ,  .in(mixColIn) , .mixColOut(mixColOut))
    input reset,
    input [0:127] in,
    output reg [0:127] mixColOut
);
     integer i;
    always @(*) begin
        if (reset) 
            mixColOut <= 128'b0;
        else begin
           
                
                for (i = 0; i < 4; i = i + 1) begin
                    mixColOut[32 * i +: 8]     <= mulTwo(in[32*i +: 8]) ^ mulThree(in[32*i + 8 +: 8]) ^ in[32*i + 16 +: 8] ^ in[32*i + 24 +: 8];
                    mixColOut[32 * i + 8 +: 8] <= in[32*i +: 8] ^ mulTwo(in[32*i + 8 +: 8]) ^ mulThree(in[32*i + 16 +: 8]) ^ in[32*i + 24 +: 8];
                    mixColOut[32 * i + 16 +: 8] <= in[32*i +: 8] ^ in[32*i + 8 +: 8] ^ mulTwo(in[32*i + 16 +: 8]) ^ mulThree(in[32*i + 24 +: 8]);
                    mixColOut[32 * i + 24 +: 8] <= mulThree(in[32*i +: 8]) ^ in[32*i + 8 +: 8] ^ in[32*i + 16 +: 8] ^ mulTwo(in[32*i + 24 +: 8]);
               
            end
            
        end
    end

    // Multiply by 2 in GF(2^8) for AES
    function [7:0] mulTwo;
        input [7:0] x;
        begin
            if (x[7] == 1) 
                mulTwo = (x << 1) ^ 8'h1b; // x * 2 in GF(2^8)
            else 
                mulTwo = x << 1;
        end
    endfunction

    // Multiply by 3 in GF(2^8) for AES
    function [7:0] mulThree;
        input [7:0] x;
        begin
            mulThree = mulTwo(x) ^ x; // x * 3 = (x * 2) + x
        end
    endfunction

endmodule
