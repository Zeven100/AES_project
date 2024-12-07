`include "datapath.v"
`include "keyExpansion.v"
module controlpath ( // controlpath DUT(.clk() , .data() , .key() , .cypherText())
     input clk , reset , start ,
     input [0 : 127] data , key ,
     output reg [0 : 127] cypherText ,
     output reg [0:3]round 
);
reg expanEn = 0 ;

reg [0 : 127] roundKey ;
reg [0:127 ] data_in ;
wire [0:127] datapath_out ;
reg [0:127] currentKey ;
wire [0:127]keyExpansionOut ;
datapath datapath_inst( .round(round) , .roundKey(roundKey) , .data_in(data_in), .reset(reset) ,.data_out(datapath_out) ) ;
keyExpansion keyExpansion_inst(.expanEn(expanEn) , .clk(clk) , .reset(reset) , .round(round) , .currentKey(currentKey) , .keyExpansionOut(keyExpansionOut)) ;

always @ (posedge clk )begin
     if(reset)begin
          data_in <= 0 ; 
          roundKey <= 0 ;
          currentKey <= 0 ;
          cypherText <= 0 ;
          expanEn <= 0 ;
     end
     else if(start)begin
          round <=0 ;
          data_in <= 0 ; 
          roundKey <= 0 ;
          currentKey <= 0 ;
          cypherText <= 0 ;
          expanEn <= 0 ;
     end
     else begin
          if(round == 0)begin
               data_in <= data ^ key ;
               currentKey <= key ;
               roundKey <= keyExpansionOut ; 
               expanEn<=1 ;
               round <= round + 1 ;
          end
          else if(round <= 9)begin
               data_in <= datapath_out ;
               currentKey <= roundKey ;
               roundKey <= keyExpansionOut ;
               expanEn<=1 ;
               round <= round + 1 ;
          end
          else if(round == 10)begin
               cypherText <= datapath_out ;
               expanEn <= 0 ;
          end
     end
end
endmodule