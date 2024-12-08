// `include "datapath.v"
`include "keyExpan.v"
`include "datapath.v"
module controlpath ( // controlpath DUT(.clk() , .reset() , .start() , .data() , .key() , .cypherText())
     input clk , clkbs , clksr , clkmc , clkka , reset , start , 
     
     input [0 : 127] data , key ,
     output reg [0 : 3] round ,
     output [0 : 127] cypherText 
);
wire [0:127] keyExpan_out ;
reg [0:127] datapath_in ;
wire [0:127]datapath_out ;
reg [0:127] datapath_KeyIn ;
wire[0:127]nrk ;
reg expanEn ;
integer i = 0 ;

keyExpan keyExpan_inst( .expanEn(expanEn) , .reset(reset) , .clk(clk) , .round(round) , .inputKey(key) , .roundKey(keyExpan_out), .nextRoundKey(nrk) ) ;
datapath dp(.round(round) ,.nrk(nrk) ,.reset(reset) , .clk(clk) , .clkbs(clkbs), .clksr(clksr) , .clkmc(clkmc) , .clkka(clkka)  , .roundKey(keyExpan_out) , .data_in(data) , .data_out(datapath_out)) ;
// datapath_2 dp(.round(round) , .clk(clk) , .reset(reset) , .roundKey(datapath_KeyIn) , .data_in(datapath_in) , .data_out(datapath_out)) ;
assign cypherText = datapath_out ;
always @( round ) begin
     if(reset)begin
          datapath_KeyIn = 0 ;
          expanEn = 0 ;
     end
     
end

always @( posedge clk ) begin
     if(i <= 1 )
     i = i + 1 ;
     else
     begin
          if(round >= 0 && round <= 9)
          round = round + 1 ;
     end
end
always @(start)begin
     expanEn = 1 ;
     round = 0 ;

end



endmodule