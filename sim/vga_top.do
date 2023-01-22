onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_vga_top/s_fpga_clk	
add wave -noupdate -format Logic /tb_vga_top/s_reset 		
add wave -noupdate -format Logic /tb_vga_top/s_sw 		
add wave -noupdate -format Logic /tb_vga_top/s_pb 		
add wave -noupdate -format Logic /tb_vga_top/s_h_sync_flag
add wave -noupdate -format Logic /tb_vga_top/s_v_sync_flag
add wave -noupdate -format Logic /tb_vga_top/s_red		
add wave -noupdate -format Logic /tb_vga_top/s_green		
add wave -noupdate -format Logic /tb_vga_top/s_blue 		
TreeUpdate [SetDefaultTree]                  	
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
