module shiftRows ( // .shiftEn() , .reset() , .in() , .shiftRowsOut()
     input reset ,
     input [0:127] in ,
     output reg [0:127] shiftRowsOut 
);
always @(*) begin
     if(reset) shiftRowsOut <= 128'b0 ;
     else
     begin
       
          shiftRowsOut[0 +: 32] <= {in[0+:8] , in[5*8 +: 8] ,  in[10*8 +: 8] , in[15*8 +: 8]} ;
          shiftRowsOut[32 +: 32] <= {in[4*8 +: 8] , in[9 * 8 +: 8] ,  in[14*8 +: 8] , in[3*8 +: 8]} ;
          shiftRowsOut[64 +: 32] <= {in[8*8 +: 8] , in[13*8 +: 8] ,  in[2*8 +: 8] , in[7*8 +: 8]} ;
          shiftRowsOut[96 +: 32] <= {in[12*8 +: 8] , in[1*8 +: 8] ,  in[6*8 +: 8] , in[11*8 +: 8]} ;
        
     end
     
end
     
endmodule