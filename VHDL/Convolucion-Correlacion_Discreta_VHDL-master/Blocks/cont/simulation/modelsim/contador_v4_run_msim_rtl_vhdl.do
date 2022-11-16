transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/Blocks/cont/contador_v4.vhd}

vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/Blocks/cont/contador_v4_TB.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L max -L rtl_work -L work -voptargs="+acc"  contador_v4_TB

add wave *
view structure
view signals
run 100 ns
