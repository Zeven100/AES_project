module mux (
     input [0:127] data_in , key ,
     input sel_in , 
     output reg [0:127] bus 
);
always @(*) begin
     bus = sel_in ? data_in : bus ;
end
     
endmodule