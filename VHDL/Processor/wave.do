onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processor_tb/CLOK
add wave -noupdate /processor_tb/DUT/S_CLK_M
add wave -noupdate /processor_tb/Reset
add wave -noupdate -radix unsigned /processor_tb/Salida
add wave -noupdate -radix unsigned /processor_tb/DUT/S_ADDRAM
add wave -noupdate -radix unsigned /processor_tb/DUT/S_ADDROM
add wave -noupdate /processor_tb/DUT/S_WE_M
add wave -noupdate -radix unsigned /processor_tb/DUT/ALU_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {36365 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 209
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {477944 ps}
