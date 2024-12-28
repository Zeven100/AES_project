`include "decrypt.v"
module dtb ();
reg clk , reset_n_ka , reset_n ,start , en  ;

reg [127:0]test_cyphertext = 128'h3925841d02dc09fbdc118597196a0b32 ;
reg [127:0]cyphertext;
reg [127:0]test_key = 128'h2b7e151628aed2a6abf7158809cf4f3c; 
reg [127:0] initial_key;
wire [127:0]plaintext ;


decrypt uut(clk , reset_n_ka, reset_n , start , en , cyphertext , initial_key , plaintext) ;

initial begin
     clk = 0 ;
     forever #5 clk = ~clk ;
end 

initial begin
     reset_n = 0 ;reset_n_ka = 0 ;
     start = 0 ;
     en = 0 ;
     cyphertext = test_cyphertext ;
     initial_key = test_key ;
     #12 reset_n_ka = 1 ;en = 1 ;
     #120 
     reset_n = 1 ;start = 1 ;
     #120;
     $stop ;

end

initial begin
     $dumpfile("dtb.vcd") ;
     $dumpvars(0, dtb) ;
end
     
endmodule