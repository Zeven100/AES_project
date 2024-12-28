`ifndef BYTESUB_V
`define BYTESUB_V
`include "sbox.v"
module byteSub (
     input [31:0]in ,
     output [31:0]out
);
genvar i ;
generate
     for(i = 1 ; i <= 4 ; i = i + 1)begin
          sbox sbox_inst(.in(in[i*8 -1 -:8 ]) , .out(out[i*8 -1 -: 8])) ;
     end
endgenerate

     
endmodule
`endif 