-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: patgen1.vhd
--
-- Date of Creation: 28.11.2022
--
-- Version: V 1.3
--
-- Date of Latest Version: 22.01.2023
--
-- Design Unit: Pattern Generator (Entity)
--
-- Description: The pattern generator 2 creates the chess board screen
-- pattern to be displayed on the vga screen
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

entity pat_gen_2 is

	port ( 
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		h_sync_i : in integer range 0 to (c_h_frame_duration-1);
		v_sync_i : in integer range 0 to (c_v_frame_duration-1);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector (3 downto 0);
		blue_o : out std_logic_vector (3 downto 0) );
		
end pat_gen_2;