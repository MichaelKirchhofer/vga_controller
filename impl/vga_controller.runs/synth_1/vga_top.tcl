# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config  -ruleid {1}  -id {DRC 23-20}  -suppress 
set_msg_config  -ruleid {2}  -id {Synth 8-3331}  -string {{WARNING: [Synth 8-3331] design blk_mem_gen_mux__parameterized2 has unconnected port MUX_RST[0]}}  -suppress 
set_msg_config  -ruleid {3}  -id {Synth 8-3331}  -suppress 
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_controller.cache/wt [current_project]
set_property parent.project_path C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_controller.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
add_files C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/res/pat_gen_1.coe
add_files C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/res/pat_gen_2.coe
add_files C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/res/RainForest_320x240.coe
add_files -quiet c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.dcp
set_property used_in_implementation false [get_files c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.dcp]
add_files -quiet c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_1/rom_mem_1.dcp
set_property used_in_implementation false [get_files c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_1/rom_mem_1.dcp]
add_files -quiet c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_2/rom_mem_2.dcp
set_property used_in_implementation false [get_files c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_2/rom_mem_2.dcp]
read_ip -quiet C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.xci
set_property used_in_implementation false [get_files -all c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz_ooc.xdc]
set_property is_locked true [get_files C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.xci]

read_ip -quiet C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_1/rom_mem_1.xci
set_property used_in_implementation false [get_files -all c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_1/rom_mem_1_ooc.xdc]
set_property is_locked true [get_files C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_1/rom_mem_1.xci]

read_ip -quiet C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_2/rom_mem_2.xci
set_property used_in_implementation false [get_files -all c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_2/rom_mem_2_ooc.xdc]
set_property is_locked true [get_files C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_2/rom_mem_2.xci]

read_vhdl -library xil_defaultlib {
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/vga_const_pkg.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/src_mux.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/pat_gen_2.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/pat_gen_1.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/io_ctrl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/vga_ctrl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/mem_ctrl_1.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/mem_ctrl_2.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/src_mux_rtl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/pat_gen_2_rtl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/pat_gen_1_rtl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/mem_ctrl_1_rtl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/vga_ctrl_rtl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/vga_top.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/mem_ctrl_2_rtl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/io_ctrl_rtl.vhd
  C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/vhdl/vga_top_rtl.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_monitor_constrs.xdc
set_property used_in_implementation false [get_files C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_monitor_constrs.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top vga_top -part xc7a35tcpg236-1


write_checkpoint -force -noxdef vga_top.dcp

catch { report_utilization -file vga_top_utilization_synth.rpt -pb vga_top_utilization_synth.pb }