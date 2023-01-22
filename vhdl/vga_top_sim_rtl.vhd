-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: vga_top_sim_rtl.vhd
--
-- Date of Creation: 03.01.2023
--
-- Version: V 1.2
--
-- Date of Latest Version: 21.01.2023
--
-- Design Unit: Simulation Model Top Unit
--
-- Description: Simulates the VGA output on a monitor simulation model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.vga_const_pkg.all;

architecture rtl of vga_top_sim is
	
	component VGA_monitor
	port(  s_reset_i     : in std_logic;
	       s_vga_red_i   : in std_logic_vector(3 downto 0);
	       s_vga_green_i : in std_logic_vector(3 downto 0);
	       s_vga_blue_i  : in std_logic_vector(3 downto 0);
	       s_vga_hsync_i : in std_logic;
	       s_vga_vsync_i : in std_logic
    	); 
	end component;
	
	component vga_ctrl
	port(
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		red_i : in std_logic_vector (3 downto 0);
		green_i : in std_logic_vector (3 downto 0);
		blue_i : in std_logic_vector (3 downto 0);
		h_sync_o : out natural range 0 to (c_h_frame_duration-1);
		v_sync_o : out natural range 0 to (c_v_frame_duration-1);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector ( 3 downto 0);
		blue_o : out std_logic_vector ( 3 downto 0);
		h_sync_flag_o : out std_logic;
		v_sync_flag_o : out std_logic
	);
	end component vga_ctrl;
	
	component io_ctrl
	port(
		clk_25hz_i 	: 	in 	std_logic; 				
		reset_i 	: 	in 	std_logic; 					
		pb_i 		:	in 	std_logic_vector (3 downto 0); 
		sw_i		: 	in	std_logic_vector (2 downto 0);
		swsync_o	:	out std_logic_vector (2 downto 0);
		pbsync_o	:	out std_logic_vector (3 downto 0) 
	);
	end component io_ctrl;
	
	component mem_ctrl_1
	port(
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		rom_data_i : in std_logic_vector (11 downto 0);
		h_sync_i : in natural range 0 to (c_h_frame_duration-1);
		v_sync_i : in natural range 0 to (c_v_frame_duration-1);
		rom_addr_o : out std_logic_vector (16 downto 0);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector (3 downto 0);
		blue_o : out std_logic_vector (3 downto 0) 
	);
	end component mem_ctrl_1;
	
	component mem_ctrl_2
	port(
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		rom_data_i : in std_logic_vector (11 downto 0);
		h_sync_i : in natural range 0 to (c_h_frame_duration-1);
		v_sync_i : in natural range 0 to (c_v_frame_duration-1);
		x_pos_i : in natural range 0 to (c_h_vis-1);
		y_pos_i : in natural range 0 to (c_v_vis-1);
		rom_addr_o : out std_logic_vector (13 downto 0);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector (3 downto 0);
		blue_o : out std_logic_vector (3 downto 0) 
	);
	end component mem_ctrl_2;
	
	component src_mux
	port(
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		h_sync_i : in natural range 0 to (c_h_frame_duration-1);
		v_sync_i : in natural range 0 to (c_v_frame_duration-1);
		swsync_i : in std_logic_vector (2 downto 0);
		pbsync_i : in std_logic_vector (3 downto 0);
		r_pat_gen_1_i : in std_logic_vector (3 downto 0);
		g_pat_gen_1_i : in std_logic_vector (3 downto 0);
		b_pat_gen_1_i : in std_logic_vector (3 downto 0);
		r_pat_gen_2_i : in std_logic_vector (3 downto 0);
		g_pat_gen_2_i : in std_logic_vector (3 downto 0);
		b_pat_gen_2_i : in std_logic_vector (3 downto 0);
		r_mem_ctrl_1_i : in std_logic_vector (3 downto 0);
		g_mem_ctrl_1_i : in std_logic_vector (3 downto 0);
		b_mem_ctrl_1_i : in std_logic_vector (3 downto 0);
		r_mem_ctrl_2_i : in std_logic_vector (3 downto 0);
		g_mem_ctrl_2_i : in std_logic_vector (3 downto 0);
		b_mem_ctrl_2_i : in std_logic_vector (3 downto 0);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector (3 downto 0);
		blue_o : out std_logic_vector (3 downto 0);
		x_pos_o : out natural range 0 to c_h_vis-100;
		y_pos_o : out natural range 0 to c_v_vis-100
	);
	end component src_mux;
	
	component pat_gen_1
	port(
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		h_sync_i : in integer range 0 to (c_h_frame_duration-1);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector (3 downto 0);
		blue_o : out std_logic_vector (3 downto 0) 
	);
	end component pat_gen_1;
	
	component pat_gen_2
	port(
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		h_sync_i : in integer range 0 to (c_h_frame_duration-1);
		v_sync_i : in integer range 0 to (c_v_frame_duration-1);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector (3 downto 0);
		blue_o : out std_logic_vector (3 downto 0) 
	);
	end component pat_gen_2;
	
	component rom_mem_1
	port(
		clka : in STD_LOGIC;
	    addra : in STD_LOGIC_VECTOR ( 16 downto 0 );
	    douta : out STD_LOGIC_VECTOR ( 11 downto 0 )
	);
	end component rom_mem_1;
	
	component rom_mem_2
	port(
		clka : in STD_LOGIC;
	    addra : in STD_LOGIC_VECTOR ( 13 downto 0 );
	    douta : out STD_LOGIC_VECTOR ( 11 downto 0 )
	);
	end component rom_mem_2;
	
	component clk_25Mhz
	port(
		clk_in1  : in  std_logic;
	    clk_out1 : out std_logic;
	    reset    : in  std_logic;
	    locked   : out std_logic 
	);
	end component clk_25Mhz;
	
--------------------------------------------------------------
--vga_top unit to all other units signals
--------------------------------------------------------------		
	--signal s_reset : std_logic;
	--signal s_clk_25hz : std_logic;
--------------------------------------------------------------
--vga_top to io_ctrl unit signals
--------------------------------------------------------------		
	--signal s_sw : std_logic;
	--signal s_pb : std_logic;
--------------------------------------------------------------
--vga_ctrl unit to all other units signals
--------------------------------------------------------------	
	signal s_h_sync : natural range 0 to (c_h_frame_duration-1);
	signal s_v_sync : natural range 0 to (c_v_frame_duration-1);
--------------------------------------------------------------
--vga_ctrl unit to monitor signals
--------------------------------------------------------------	
	signal s_h_sync_flag : std_logic;
	signal s_v_sync_flag : std_logic;
	signal s_to_screen_red : std_logic_vector ( 3 downto 0);
	signal s_to_screen_green : std_logic_vector (3 downto 0);
	signal s_to_screen_blue : std_logic_vector (3 downto 0);
--------------------------------------------------------------
--io_ctrl to src_mux signals
--------------------------------------------------------------
	signal s_swsync : std_logic_vector (2 downto 0);
	signal s_pbsync : std_logic_vector (3 downto 0);
--------------------------------------------------------------
--src mux to pat_gen / mem_ctrl unit signals
--------------------------------------------------------------
	signal s_r_pat_gen_1 : std_logic_vector (3 downto 0);
	signal s_g_pat_gen_1 : std_logic_vector (3 downto 0);
	signal s_b_pat_gen_1 : std_logic_vector (3 downto 0);
	signal s_r_pat_gen_2 : std_logic_vector (3 downto 0);
	signal s_g_pat_gen_2 : std_logic_vector (3 downto 0);
	signal s_b_pat_gen_2 : std_logic_vector (3 downto 0);
	signal s_r_mem_ctrl_1 : std_logic_vector (3 downto 0);
	signal s_g_mem_ctrl_1 : std_logic_vector (3 downto 0);
	signal s_b_mem_ctrl_1 : std_logic_vector (3 downto 0);
	signal s_r_mem_ctrl_2 : std_logic_vector (3 downto 0);
	signal s_g_mem_ctrl_2 : std_logic_vector (3 downto 0);
	signal s_b_mem_ctrl_2 : std_logic_vector (3 downto 0);
--------------------------------------------------------------
--src mux to vga_ctrl unit signals
--------------------------------------------------------------	
	signal s_to_ctrl_red :  std_logic_vector (3 downto 0);
	signal s_to_ctrl_green :  std_logic_vector (3 downto 0);
	signal s_to_ctrl_blue :  std_logic_vector (3 downto 0);
--------------------------------------------------------------
--src mux to mem_ctrl_2 unit signals
--------------------------------------------------------------
	signal s_x_pos :  natural range 0 to c_h_vis - 100;
	signal s_y_pos :  natural range 0 to c_v_vis - 100;
--------------------------------------------------------------
--mem_ctrl_1 signals
--------------------------------------------------------------		
	signal s_rom_addr_1 : std_logic_vector (16 downto 0);
	signal s_rom_data_1 : std_logic_vector (11 downto 0);
--------------------------------------------------------------
--mem_ctrl_2 signals
--------------------------------------------------------------		
	signal s_rom_addr_2 : std_logic_vector (13 downto 0);
	signal s_rom_data_2 : std_logic_vector (11 downto 0);

begin
	
	-- vga_ctrl instance
	i_vga_ctrl : vga_ctrl
	port map(
		reset_i 	=> reset_i,
		clk_25hz_i 	=> fpga_clk_i,
		red_i 		=> s_to_ctrl_red,
		green_i 	=> s_to_ctrl_green,
		blue_i 		=> s_to_ctrl_blue,
		h_sync_o	=> s_h_sync,
		v_sync_o	=> s_v_sync,
		red_o 		=> s_to_screen_red,
		green_o 	=> s_to_screen_green,
		blue_o 		=> s_to_screen_blue,
		h_sync_flag_o => s_h_sync_flag,
		v_sync_flag_o => s_v_sync_flag
	);
	
	i_vga_monitor : VGA_monitor 
	port map(	
		s_reset_i    	=> reset_i,
		s_vga_hsync_i   => s_h_sync_flag,
		s_vga_vsync_i   => s_v_sync_flag,
		s_vga_red_i		=> s_to_screen_red,
		s_vga_green_i	=> s_to_screen_green,
		s_vga_blue_i	=> s_to_ctrl_blue  
	);
	
	-- src_mux instance
	i_src_mux : src_mux
	port map(
		reset_i => reset_i,
		clk_25hz_i => fpga_clk_i,
		h_sync_i => s_h_sync,
		v_sync_i => s_v_sync,
		swsync_i => s_swsync,
		pbsync_i => s_pbsync,
		r_pat_gen_1_i => s_r_pat_gen_1,
		g_pat_gen_1_i => s_g_pat_gen_1,
		b_pat_gen_1_i => s_b_pat_gen_1,
		r_pat_gen_2_i => s_r_pat_gen_2,
		g_pat_gen_2_i => s_g_pat_gen_2,
		b_pat_gen_2_i => s_b_pat_gen_2,
		r_mem_ctrl_1_i => s_r_mem_ctrl_1,
		g_mem_ctrl_1_i => s_g_mem_ctrl_1,
		b_mem_ctrl_1_i => s_b_mem_ctrl_1,
		r_mem_ctrl_2_i => s_r_mem_ctrl_2,
		g_mem_ctrl_2_i => s_g_mem_ctrl_2,
		b_mem_ctrl_2_i => s_b_mem_ctrl_2,
		red_o 	=> s_to_ctrl_red,
		green_o => s_to_ctrl_green,
		blue_o 	=> s_to_ctrl_blue,
		x_pos_o => s_x_pos,
		y_pos_o => s_y_pos
	);
	
	--io_ctrl instance
	
	i_io_ctrl : io_ctrl
	port map(
		reset_i 	=> reset_i,
		clk_25hz_i 	=> fpga_clk_i,
		pb_i 		=> pb_i,
		sw_i		=> sw_i,
		swsync_o	=> s_swsync,
		pbsync_o	=> s_pbsync
	);
	
	-- pat_gen_1 instance
	i_pat_gen_1 : pat_gen_1
	port map(
		reset_i 	=> reset_i,
		clk_25hz_i  => fpga_clk_i,
		h_sync_i    => s_h_sync,
		red_o       => s_r_pat_gen_1,
		green_o     => s_g_pat_gen_1,
		blue_o      => s_b_pat_gen_1
	);
	
	-- pat_gen_2 instance
	i_pat_gen_2 : pat_gen_2
	port map(
		reset_i 	=> reset_i,
		clk_25hz_i  => fpga_clk_i,
		h_sync_i    => s_h_sync,
		v_sync_i	=> s_v_sync,
		red_o       => s_r_pat_gen_2,
		green_o     => s_g_pat_gen_2,
		blue_o      => s_b_pat_gen_2
	);
	
	-- mem_ctrl_1 instance
	i_mem_ctrl_1 : mem_ctrl_1
	port map(
		reset_i 	=> reset_i,
		clk_25hz_i  => fpga_clk_i,
		rom_data_i  => s_rom_data_1,
		h_sync_i    => s_h_sync,
		v_sync_i    => s_v_sync,
		rom_addr_o  => s_rom_addr_1,
		red_o       => s_r_mem_ctrl_1,
		green_o     => s_g_mem_ctrl_1,
		blue_o      => s_b_mem_ctrl_1
	);
	
	-- mem_ctrl_2 instance
	i_mem_ctrl_2 : mem_ctrl_2
	port map(
		reset_i 	=> reset_i,
		clk_25hz_i  => fpga_clk_i,
		rom_data_i  => s_rom_data_2,
		h_sync_i    => s_h_sync,
		v_sync_i    => s_v_sync,
		x_pos_i		=> s_x_pos,
		y_pos_i		=> s_y_pos,
		rom_addr_o  => s_rom_addr_2,
		red_o       => s_r_mem_ctrl_2,
		green_o     => s_g_mem_ctrl_2,
		blue_o      => s_b_mem_ctrl_2
	);
	
	-- rom_1 instance
	i_rom_mem_1 : rom_mem_1
	port map(
		clka => fpga_clk_i,
		addra => s_rom_addr_1,
		douta => s_rom_data_1
	);
	
	-- rom_2 instance
	i_rom_mem_2 : rom_mem_2
	port map (
		clka => fpga_clk_i,
		addra => s_rom_addr_2,
		douta => s_rom_data_2
	);
	
end rtl;