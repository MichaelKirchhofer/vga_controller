-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: vga_top.vhd
--
-- Date of Creation: 06.12.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 13.12.2022
--
-- Design Unit: VGA top level unit (entity)
--
-- Description: Top level vga controller unit that contains all the wiring
-- for the 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

entity src_mux is

	port ( 
			fpga_clk_i : in std_logic;
			reset_i : in std_logic;
			sw_i : in std_logic_vector(2 downto 0);
			pb_i : in std_logic_vector(3 downto 0);
			red_o : out std_logic_vector (3 downto 0);
			green_o : out std_logic_vector ( 3 downto 0);
			blue_o : out std_logic_vector ( 3 downto 0);
			h_sync_flag_o : out std_logic;
			v_sync_flag_o : out std_logic
		);
		
end src_mux;