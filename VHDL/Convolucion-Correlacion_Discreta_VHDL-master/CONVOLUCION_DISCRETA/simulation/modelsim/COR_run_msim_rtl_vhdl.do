transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/FullAdder_8x8.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/DMUX_7_3.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/DMUX.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/pipo.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/FFT.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/FA.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/control_unit.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/CONTADOR.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/Bloque_multiplicacion.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/COR.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/Multiplier.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/MooreMachineState.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/DMUX_15.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/DMUX_15_3.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/contador_v4.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/Sumador_11_bits.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/Sumador_10_bits.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/Sumador_9_bits.vhd}
vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/Sumador_8_bits.vhd}

vcom -93 -work work {C:/Users/USUARIO/Desktop/UPTC/Semestre_10/DSP/Laboratorio2/CONVOLUCION_DISCRETA/COR_TB.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L max -L rtl_work -L work -voptargs="+acc"  COR_TB

add wave *
view structure
view signals
run 10 us
