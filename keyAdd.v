module keyAdd ( // .key() , .in() , .keyAddEn() , .reset() , .keyAddOut()
     input[0:127] key , in , 
     input keyAddEn , reset , 
     output reg [0:127] keyAddOut 
);
always @(*) begin
     if(reset) keyAddOut <=  128'b0 ;
     else
     begin
        if(keyAddEn)begin
          keyAddOut <= key ^ in ;
     end  
     end
     
end
     
endmodule