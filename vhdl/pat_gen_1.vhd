-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: patgen1.vhd
--
-- Date of Creation: 28.11.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 28.11.2022
--
-- Design Unit: Pattern Generator (Entity)
--
-- Description: The pattern generator 1 creates the horzintally striped screen
-- pattern to be displayed on the vga screen
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

entity pat_gen_1 is

	port ( 
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		h_sync_i : in integer range 0 to (c_h_frame_duration-1);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector (3 downto 0);
		blue_o : out std_logic_vector (3 downto 0) );
		
end pat_gen_1;