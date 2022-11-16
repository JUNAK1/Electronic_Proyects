#!/usr/bin/tclsh
quit -sim

set DIR_ROOT "."

exec vlib work

set vhdls [list \
	"$DIR_ROOT/FIR.vhd" \
	"$DIR_ROOT/FIR_tb.vhd" \
	]
	
foreach src $vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		vcom -93 -work work $src
	}
}

vsim -voptargs=+acc work.FIR_tb
do wave.do
run 1 ms
