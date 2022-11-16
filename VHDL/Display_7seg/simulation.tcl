#!/usr/bin/tclsh
quit -sim

set DIR_ROOT "."

exec vlib work

set vhdls [list \
	"$DIR_ROOT/Display_7seg.vhd" \
	"$DIR_ROOT/Display_7seg_tb.vhd" \
	]
	
foreach src $vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		vcom -2008 -work work $src
	}
}

vsim -voptargs=+acc work.Display_7seg_tb
do wave.do
run 1 us
