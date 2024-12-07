`include "keyAdd.v"
`include "mixCol.v"
`include "shiftRows.v"
`include "mux.v"
`include "reg_key.v"
`include "reg_data.v"
`include "BS.v"

module datapath ( // datapath dp(.round() , .reset() , .reset() , .roundkey() , .data_in() , .data_out())
     input [0:3]round ,  
     input reset ,
     input [0:127 ] roundKey , data_in ,
     output reg [0:127] data_out  
);
reg keyAddEn = 0 ,enBS = 0,shiftEn = 0, mixEn = 0 ;
reg [0:127] keyAddKey_In ;
reg [0:127] keyAddData_in ;
reg [0:127] byteSubIn ;
reg [0:127] mixColIn ;
wire [0:127] mixColOut ;
wire [0:127] byteSubOut ;
wire [0:127] keyAddOut ;
reg[0:127] shiftRowsIn ;
wire [0:127]shiftRowsOut ;
keyAdd keyAdd_inst( .key(keyAddKey_In) , .in(keyAddData_in) , .keyAddEn(keyAddEn) , .reset(reset) , .keyAddOut(keyAddOut) ) ;
BS BS_inst(.in(byteSubIn) , .enBS(enBS) , .reset(reset) , .byteSubOut(byteSubOut)) ;
shiftRows shiftRows_inst(.shiftEn(shiftEn) , .reset(reset) , .in(shiftRowsIn) , .shiftRowsOut(shiftRowsOut)) ;
mixCol mixCol_inst (.mixEn(mixEn) , .reset(reset) , .round(round) , .in(mixColIn) , .mixColOut(mixColOut)) ;

always @(*) begin
     keyAddEn = 0  ;enBS = 0  ;shiftEn = 0 ; mixEn = 0 ;
     data_out = 0 ;
     if( round >=1 && round < 10)begin
          enBS = 1 ;
          byteSubIn = data_in ;
          shiftEn = 1 ;
          shiftRowsIn = byteSubOut ;
          mixEn = 1 ;
          mixColIn = shiftRowsOut ;
          keyAddEn = 1 ;
          keyAddData_in = mixColOut ;
          keyAddKey_In = roundKey ;
          data_out = keyAddOut ;
          
     end
     else if(round ==10 )begin
          enBS = 1 ;
          byteSubIn = data_in ;
          shiftEn = 1 ;
          shiftRowsIn = byteSubOut ;
          keyAddEn = 1 ;
          keyAddData_in = shiftRowsOut ;
          keyAddKey_In = roundKey ;
          data_out = keyAddOut ;
          
     end
     else begin
          data_out = 0 ;
     end
end



endmodule
