module reg_data (
     input [0:127] data , 
     input l_data ,reset , clk ,
     output reg [0:127] data_out
);
always @(posedge clk ) begin
     if(reset)data_out <= 128'b0 ;
     else begin
          if(l_data)data_out <= data ;
     end
end
     
endmodule