module reg_key (
     input [0:127] key , 
     input l_key ,reset , clk ,
     output reg [0:127] key_out
);
always @(posedge clk ) begin
     if(reset)key_out <= 128'b0 ;
     else begin
          if(l_key)key_out <= key ;
     end
end
     
endmodule