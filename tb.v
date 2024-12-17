`include "aes.v"
module tb ();
reg mck , sck , tck , reset ;
reg [0:127] inputKey ;
aes DUT(.mck(mck) , .sck(sck) , .tck(tck), .reset(reset) , .initial_key(inputKey)) ;

initial begin
     mck = 0 ;sck = 0 ; tck = 0 ; reset = 1 ;
     DUT.Mem[0] = 128'h3243f6a8885a308d313198a2e0370734;
     DUT.Mem[1] = 128'h3243f6a8885a308d313198a2e0370734;
     DUT.Mem[2] = 128'h3243f6a8885a308d313198a2e0370734;
     DUT.Mem[3] = 128'h3243f6a8885a308d313198a2e0370734;
     DUT.pc = 0 ;
     inputKey = 128'h2b7e151628aed2a6abf7158809cf4f3c;
     DUT.round = 0 ;
     #2 reset = 0 ;
     
end
initial 
begin
     repeat(50) begin
          #5 mck = 1 ; #5 mck = 0 ;
     end
     
end
initial begin
     #2
     repeat(50)begin
         #5 sck = 1 ; #5 sck = 0 ;  
     end
end
initial begin
     #3
     repeat(50)begin
         #5 tck = 1 ; #5 tck = 0 ;  
     end
end
initial begin
     $dumpfile("tb.vcd") ;
     $dumpvars(0, tb) ;
end
     
endmodule