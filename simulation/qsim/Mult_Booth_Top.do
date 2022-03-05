onerror {quit -f}
vlib work
vlog -work work Mult_Booth_Top.vo
vlog -work work Mult_Booth_Top.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Mult_Booth_PO_vlg_vec_tst
vcd file -direction Mult_Booth_Top.msim.vcd
vcd add -internal Mult_Booth_PO_vlg_vec_tst/*
vcd add -internal Mult_Booth_PO_vlg_vec_tst/i1/*
add wave /*
run -all
