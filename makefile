compile :
	iverilog -o aes_simulation tb.v datapath.v controlpath.v keyExpansion.v keyAdd.v shiftRows.v mux.v reg_key.v reg_data.v BS.v sbox.v round_cf.v byteSub.v

run :
	vvp aes_simulation
wave :
	gtkwave aes_testbench.vcd
