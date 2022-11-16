onerror {resume}
quietly WaveActivateNextPane {} 0
radix -hexadecimal -showbase


add wave -noupdate -label In_Display /Display_7seg_tb/DUT/segm_in
add wave -noupdate -label Out_Display /Display_7seg_tb/DUT/segm_out