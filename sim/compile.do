# compile Xilinx GLBL module (required for proper initialization
# of all generated  Xilinx macros during simulation)
vlog ../generate/glbl.v

# compile simulation model of generated clock PLL
vlog ../generate/clk_25Mhz/clkgen_clk_wiz.v
vlog ../generate/clk_25Mhz/clkgen.v

# copy .mif file (which holds content of ROM1) into ModelSim simulation directory
file copy -force ../generate/rom_mem_1/rom_mem_1.mif ./

# compile simulation model of generated ROM1
vlog ../generate/rom_mem_1/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom_mem_1/synth/rom_mem_1.vhd

# copy .mif file (which holds content of ROM2) into ModelSim simulation directory
file copy -force ../generate/rom_mem_2/rom_mem_2.mif ./

# compile simulation model of generated ROM2
vlog ../generate/rom_mem_2/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom_mem_2/synth/rom_mem_2.vhd

# compile created vhdl files (entities and architectures)
vcom ../vhdl/vga_const_pkg.vhd
vcom ../vhdl/io_ctrl.vhd
vcom ../vhdl/io_ctrl_rtl.vhd
vcom ../vhdl/pat_gen_1.vhd
vcom ../vhdl/pat_gen_1_rtl.vhd
vcom ../vhdl/pat_gen_2.vhd
vcom ../vhdl/pat_gen_2_rtl.vhd
vcom ../vhdl/src_mux.vhd
vcom ../vhdl/src_mux_rtl.vhd
vcom ../vhdl/mem_ctrl_1.vhd
vcom ../vhdl/mem_ctrl_1_rtl.vhd
vcom ../vhdl/mem_ctrl_2.vhd
vcom ../vhdl/mem_ctrl_2_rtl.vhd
vcom ../vhdl/vga_ctrl.vhd
vcom ../vhdl/vga_ctrl_rtl.vhd
vcom ../vhdl/vga_top.vhd
vcom ../vhdl/vga_top_rtl.vhd

# compile testbenches for testing
vcom ../tb/tb_pat_gen_1.vhd
vcom ../tb/tb_pat_gen_2.vhd
