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
-- Design Unit: ROM Controller 1 (Entity)
--
-- Description: The ROM Controller fetches the picture pixel data from the ROM1
-- Block of the FPGA Board
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

entity mem_ctrl_1 is

	port ( 
		reset_i : in std_logic;
		clk_25hz_i : in std_logic;
		rgb_data_i : in std_logic_vector (11 downto 0);
		h_sync_i : in integer range 0 to (c_h_frame_duration-1);
		v_sync_i : in integer range 0 to (c_v_frame_duration-1);
		
		rom_addr_o : out std_logic_vector (15 downto 0);
		red_o : out std_logic_vector (3 downto 0);
		green_o : out std_logic_vector (3 downto 0);
		blue_o : out std_logic_vector (3 downto 0) 
		);
		
end mem_ctrl_1;