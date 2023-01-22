onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_vga_sim_top/i_vga_top_sim/i_vga_monitor/*
add wave -noupdate -format Logic /tb_vga_sim_top/i_vga_top_sim/i_vga_ctrl/*
add wave -noupdate -format Logic /tb_vga_sim_top/i_vga_top_sim/i_src_mux/*
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 04
configure wave -justifyvalue left