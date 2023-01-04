-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: vga_ctrl.vhd
--
-- Date of Creation: 06.12.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 13.12.2022
--
-- Design Unit: VGA Controller (Entity)
--
-- Description: Controls all screen sync signals and drives out the color signals
-- from the multiplexer to the vga screen. 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

entity vga_ctrl is

	port ( 
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
		
end vga_ctrl;