`include "try.v"
module tb ( );

reg clk;
reg start , en;
reg reset_n;
reg [127:0] plaintext;
reg [127:0] initial_key;
wire [127:0] cyphertext;

try uut(clk , reset_n, start , en , plaintext , initial_key , cyphertext ) ;

reg [127:0] test_plaintext = 128'h3243f6a8885a308d313198a2e0370734; // Example plaintext
reg [127:0] test_key = 128'h2b7e151628aed2a6abf7158809cf4f3c;    // Example AES key

initial begin
     clk = 0 ;
     forever #5 clk = ~clk ;
end

initial begin
     reset_n = 0;
     en = 0 ;
     start = 0;
     
     plaintext = test_plaintext;
     initial_key = test_key;
     #12 en = 1 ;
     #10 reset_n = 1 ;start = 1 ;
     #150 
     $stop ;

end

initial begin
     $dumpfile("tb.vcd") ;
     $dumpvars(0, tb) ;
end
     
endmodule