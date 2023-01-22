vsim -novopt -t ps -L unisims_ver -lib work work.tb_vga_top work.glbl work.clk_25Mhz
view *
do vga_top.do
run 68 ms
