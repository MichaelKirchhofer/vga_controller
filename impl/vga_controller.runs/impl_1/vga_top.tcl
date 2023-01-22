proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config  -ruleid {1}  -id {DRC 23-20}  -suppress 
set_msg_config  -ruleid {2}  -id {Synth 8-3331}  -string {{WARNING: [Synth 8-3331] design blk_mem_gen_mux__parameterized2 has unconnected port MUX_RST[0]}}  -suppress 
set_msg_config  -ruleid {3}  -id {Synth 8-3331}  -suppress 

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_controller.cache/wt [current_project]
  set_property parent.project_path C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_controller.xpr [current_project]
  set_property ip_repo_paths c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_controller.cache/ip [current_project]
  set_property ip_output_repo c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_controller.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_controller.runs/synth_1/vga_top.dcp
  add_files -quiet c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.dcp
  set_property netlist_only true [get_files c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.dcp]
  add_files -quiet c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_1/rom_mem_1.dcp
  set_property netlist_only true [get_files c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_1/rom_mem_1.dcp]
  add_files -quiet c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_2/rom_mem_2.dcp
  set_property netlist_only true [get_files c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/rom_mem_2/rom_mem_2.dcp]
  read_xdc -prop_thru_buffers -ref clk_25Mhz -cells inst c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz_board.xdc
  set_property processing_order EARLY [get_files c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz_board.xdc]
  read_xdc -ref clk_25Mhz -cells inst c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.xdc
  set_property processing_order EARLY [get_files c:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/generate/clk_25Mhz/clk_25Mhz.xdc]
  read_xdc C:/Users/Michael/Desktop/Elektronik/Wintersemester_2022/CHIP/vga_controller/impl/vga_monitor_constrs.xdc
  link_design -top vga_top -part xc7a35tcpg236-1
  write_hwdef -file vga_top.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force vga_top_opt.dcp
  report_drc -file vga_top_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force vga_top_placed.dcp
  report_io -file vga_top_io_placed.rpt
  report_utilization -file vga_top_utilization_placed.rpt -pb vga_top_utilization_placed.pb
  report_control_sets -verbose -file vga_top_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force vga_top_routed.dcp
  report_drc -file vga_top_drc_routed.rpt -pb vga_top_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file vga_top_timing_summary_routed.rpt -rpx vga_top_timing_summary_routed.rpx
  report_power -file vga_top_power_routed.rpt -pb vga_top_power_summary_routed.pb -rpx vga_top_power_routed.rpx
  report_route_status -file vga_top_route_status.rpt -pb vga_top_route_status.pb
  report_clock_utilization -file vga_top_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force vga_top.mmi }
  write_bitstream -force vga_top.bit 
  catch { write_sysdef -hwdef vga_top.hwdef -bitfile vga_top.bit -meminfo vga_top.mmi -file vga_top.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

