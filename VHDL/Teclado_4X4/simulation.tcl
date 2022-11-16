#!/usr/bin/tclsh
quit -sim

set DIR_ROOT "."

exec vlib work

set vhdls [list \
	"$DIR_ROOT/KBD.vhd" \
	"$DIR_ROOT/KBD_tb.vhd" \
	]
	
foreach src $vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		vcom -93 -work work $src
	}
}

vsim -voptargs=+acc work.KBD_tb
do wave.do
run 32 us
