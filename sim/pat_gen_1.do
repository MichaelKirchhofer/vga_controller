onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_pat_gen_1/s_clk_i 		 
add wave -noupdate -format Logic /tb_pat_gen_1/s_reset_i	
add wave -noupdate -format Logic /tb_pat_gen_1/s_h_pix_count
add wave -noupdate -format Logic /tb_pat_gen_1/i_pat_gen_1/s_pat_gen_state
add wave -noupdate -format Logic /tb_pat_gen_1/s_red_o 	
add wave -noupdate -format Logic /tb_pat_gen_1/s_green_o
add wave -noupdate -format Logic /tb_pat_gen_1/s_blue_o 
TreeUpdate [SetDefaultTree]                  	
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
