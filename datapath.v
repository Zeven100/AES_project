`include "keyAdd.v"
`include "mixCol.v"
`include "shiftRows.v"
`include "mux.v"
`include "reg_key.v"
`include "reg_data.v"
`include "BS.v"

module datapath ( // datapath dp(.round() , .reset() , .roundkey() , .data_in() , .data_out())
     input [0:3]round ,  
     input reset ,clk ,clkbs , clksr , clkmc , clkka ,
     input [0:127 ] roundKey , data_in , nrk ,
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
reg [0:127]newOut ;
reg[0:127] next_round_data ;

keyAdd keyAdd_inst( .key(nrk) , .in(keyAddData_in) , .keyAddEn(keyAddEn) , .reset(reset) , .keyAddOut(keyAddOut) ) ;
BS BS_inst(.in(byteSubIn) , .enBS(enBS) , .reset(reset) , .byteSubOut(byteSubOut)) ;
shiftRows shiftRows_inst(.shiftEn(shiftEn) , .reset(reset) , .in(shiftRowsIn) , .shiftRowsOut(shiftRowsOut)) ;
mixCol mixCol_inst (.mixEn(mixEn) , .reset(reset) , .round(round) , .in(mixColIn) , .mixColOut(mixColOut)) ;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 128'b0; // Clear on reset
    end else if (round == 0) begin
        data_out <= data_in ^ roundKey; 
        next_round_data  = data_in ^ roundKey; 
    end else if (round >= 1 && round <= 10) begin
        data_out <= keyAddOut; 
        next_round_data = keyAddOut ;
    end
end

always @ (clkbs)begin
     
     if(clkbs && round >= 0 && round <= 10)
     begin
          enBS = 1 ;
          byteSubIn = next_round_data ;          
     end

end
always @(clksr) begin
     if( clksr && round >= 0 && round <= 10)
     begin
          shiftEn = 1 ;
          shiftRowsIn = byteSubOut ;          
     end
end
always @( clkmc) begin
     if(clkmc && round >= 0 && round <= 10)
     begin
          mixEn = 1 ;
          mixColIn = shiftRowsOut ;          
     end
end
always @(clkka) begin
     if(clkka && round >= 0 && round <= 10)
     begin
          keyAddEn = 1 ;
          keyAddData_in = mixColOut ;          
     end
end


endmodule
