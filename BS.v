`include "byteSub.v"
module BS ( // .in() , .enBS() , .reset() , .byteSubOut()
     input [0:127] in ,
     input reset ,
     output reg [0:127] byteSubOut 
);

wire [0:127]bs_out ;

byteSub s0(.in(in[0 +: 32]) , .out(bs_out[0 +: 32])) ; 
byteSub s1(.in(in[32 +: 32]) , .out(bs_out[32 +: 32])) ; 
byteSub s2(.in(in[64 +: 32]) , .out(bs_out[64 +: 32])) ; 
byteSub s3(.in(in[96 +: 32]) , .out(bs_out[96 +: 32])) ; 

always @(*) begin
     if(reset) byteSubOut <= 128'b0 ;
     else 
               byteSubOut <= bs_out ;
        
end


     
endmodule