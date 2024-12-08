`timescale 1ns / 1ps
`include "datapath.v"

module datapath_tb ();
reg clk ;
reg [0:3] round ;
reg reset ;
reg [0:127]roundKey ;
reg [0:127]data_in ;
wire [0:127]data_out ;
datapath dp(.round(round) , .reset(reset)  , .roundKey(roundKey) , .data_in(data_in) , .data_out(data_out)) ;
initial begin
     clk = 1'b1 ;
     forever #5 clk = ~clk ;
end     
initial begin
     $dumpfile("dp.vcd");
     $dumpvars(0, datapath_tb);
     reset = 1 ;
     #4 ; reset = 0 ;
      
     data_in = 128'h3243f6a8885a308d313198a2e0370734 ;
     roundKey = 128'h2b7e151628aed2a6abf7158809cf4f3c ;
     #6 ;
     round = 0 ;
     #10 ;
     roundKey = 128'ha0fafe1788542cb123a339392a6c7605 ;
     data_in =  128'h193de3bea0f4e22b9ac68d2ae9f84808 ;
     round = 1 ;
     
     #20 ;
     $finish ;


      
end
endmodule