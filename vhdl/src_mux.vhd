-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: src_mux.vhd
--
-- Date of Creation: 06.12.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 06.12.2022
--
-- Design Unit: VGA Source Multiplexer (Entity)
--
-- Description: The source multiplexer switches the display inputs according to
-- the switch position on the fpga board
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

entity src_mux is

	port ( 
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		h_sync_i : in integer range 0 to (c_h_frame_duration-1);
		v_sync_i : in integer range 0 to (c_v_frame_duration-1);
		
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
		blue_o : out std_logic_vector (3 downto 0) 
		);
		
end src_mux;