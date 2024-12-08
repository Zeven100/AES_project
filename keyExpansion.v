`include "byteSub.v"
`include "round_cf.v"
module keyExpansion ( // .expanEn() , .clk() , .reset() , .round() , .currentKey() , .keyExpansionOut()
     input expanEn , reset , clk , 
     input [0:3] round , 
     input [0:127] inputKey ,
     output reg [0:127] keyExpansionOut 
);
     reg [0:127]currentKey ; 

     wire [0:31] circ = {currentKey[104 +: 24] , currentKey[96 +: 8]} ;
     wire [0:31] sub_circ ;
     wire [0:31] rc ;
     wire [0:3]round_corr = round + 1;
     byteSub bs(.in(circ) , .out(sub_circ)) ;
     round_cf rcoeff(.r(round_corr) , .cf(rc)) ;

     always @( negedge clk ) begin
          if(reset) keyExpansionOut = 128'b0 ;
          else 
          begin
               
             if(expanEn)begin
               keyExpansionOut[0 +:32] = currentKey[0 +: 32] ^ sub_circ ^ rc ;
               keyExpansionOut[32 +: 32] = currentKey[32 +: 32] ^ keyExpansionOut[0 +: 32] ;
               keyExpansionOut[64 +: 32] = currentKey[64 +: 32] ^ keyExpansionOut[32 +: 32] ;
               keyExpansionOut[96 +: 32] = currentKey[96 +: 32] ^ keyExpansionOut[64 +: 32] ;
               
          end 
          else if(round == 0)begin
               currentKey = inputKey ;
          end
          
          end
          
          
     end


endmodule