`ifndef BYTESUB_V
`define BYTESUB_V

`include "sbox.v"
module byteSub (
     input [0:31] in ,
     output  [0:31] out
);
genvar i ;
generate
     for(i = 31 ; i >0 ; i = i - 8 )begin
          sbox s(.in(in[i -: 8]) , .out(out[i -: 8])) ;
     end
endgenerate

endmodule

`endif