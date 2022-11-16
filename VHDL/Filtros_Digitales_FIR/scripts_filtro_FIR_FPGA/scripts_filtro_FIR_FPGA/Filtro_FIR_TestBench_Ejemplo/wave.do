onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider Filter_Behaviour
add wave -noupdate -format analog-step -height 100 -min -8388608 -max 8388607 -label Input_signal -radix decimal /FIR_tb/sinput_filter
add wave -noupdate -format analog-step -height 100 -min -8388608 -max 8388607 -label Out_Filter -radix decimal /FIR_tb/sresponse_filter

add wave -noupdate -divider FIR_Signals
add wave -noupdate -radix hexadecimal /FIR_tb/*

