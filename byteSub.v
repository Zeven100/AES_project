`ifndef BYTESUB_V
`define BYTESUB_V

`include "sbox.v"
module byteSub (
     input [31:0] in ,
     output  [31:0] out
);
genvar i ;
generate
     for(i = 0 ; i <32 ; i = i + 8 )begin
          sbox s(.in(in[i +: 8]) , .out(out[i +: 8])) ;
     end
endgenerate

endmodule

`endif