`include "keyExpan.v"
`include "BS.v"
`include "shiftRows.v"
`include "mixCol.v"
`include "keyExpan.v"
module aes ( // aes DUT(.mck() , .sck() , .reset() , .initial_key()) ;
     input mck , sck , tck , reset , 
     input [0:127]initial_key 
);
reg [0:3]round ;
reg [0:3]pc ; 
integer r = 0 ;

reg [0:127] Mem [0:4] ; // to store the data to encrypt

reg [0:127] df_bs_data ;

reg [0:127] bs_sr_data ;
reg [0:127] sr_mc_data ;
reg [0:127] mc_ka_data ;
reg [0:127] ka_out ;


wire[0:127]byteSubOut ;
wire[0:127]srOut ;
wire[0:127]mcOut ;
wire [0:1407] key_reg; 

BS BS_inst(.in(df_bs_data) , .reset(reset) , .byteSubOut(byteSubOut)) ;
shiftRows SR_inst( .reset(reset) , .in(bs_sr_data) , .shiftRowsOut(srOut));
mixCol MC_inst(.reset(reset) , .in(sr_mc_data) , .mixColOut(mcOut)) ;
keyExpan KE_inst(.initial_key(initial_key) , .key_reg(key_reg)) ;


always @(posedge mck) begin
     if(r == 0) r <=1 ;
     else begin
          if(round == 10)
          begin
               round <= 0 ;
               pc <= pc + 1 ;          
          end

          else round <= round + 1 ;   
     end
     
end
always @(posedge sck) begin // data_fetch
     if( round == 0 )
     begin
          df_bs_data <= Mem[pc] ;
     end
     else begin
          df_bs_data <= ka_out ;
     end
     
end
always @(posedge tck) begin // bs
     if(round == 0 )begin
          bs_sr_data <= df_bs_data ;
     end
     else
          bs_sr_data <= byteSubOut ;
end

always @(negedge mck) begin // shift rows
     if(round == 0)
          sr_mc_data <= bs_sr_data ;
     else
          sr_mc_data <= srOut ;
end

always @(negedge sck) begin // mix col
     if(round == 0 || round == 10)mc_ka_data <= sr_mc_data ;
     else if(round < 10) mc_ka_data <= mcOut ;
end

always @(negedge tck) begin // key add
     ka_out <= mc_ka_data ^ key_reg[round * 128 +: 128] ;
end
     
endmodule