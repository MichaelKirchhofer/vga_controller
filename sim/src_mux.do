onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_src_mux/i_src_mux/s_src_mux_state
add wave -noupdate -format Logic /tb_src_mux/s_red_o 	
add wave -noupdate -format Logic /tb_src_mux/s_green_o
add wave -noupdate -format Logic /tb_src_mux/s_blue_o 
TreeUpdate [SetDefaultTree]                  	
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
