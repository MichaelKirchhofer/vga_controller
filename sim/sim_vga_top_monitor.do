vsim -novopt -t ps -L unisims_ver -lib work work.tb_vga_sim_top work.vga_monitor work.glbl 
view *
do vga_top_monitor.do
run 200 ms