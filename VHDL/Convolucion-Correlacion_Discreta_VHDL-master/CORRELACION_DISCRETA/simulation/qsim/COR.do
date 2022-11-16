onerror {quit -f}
vlib work
vlog -work work COR.vo
vlog -work work COR.vt
vsim -novopt -c -t 1ps -L max3000a_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.COR_vlg_vec_tst
vcd file -direction COR.msim.vcd
vcd add -internal COR_vlg_vec_tst/*
vcd add -internal COR_vlg_vec_tst/i1/*
add wave /*
run -all
