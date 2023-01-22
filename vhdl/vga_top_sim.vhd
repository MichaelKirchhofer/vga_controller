-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: vga_top_sim.vhd
--
-- Date of Creation: 16.01.2023
--
-- Version: V 1.0
--
-- Date of Latest Version: 16.01.2023
--
-- Design Unit: VGA top level unit for simulation
--
-- Description: Top level vga controller unit for the simulation model
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

entity vga_top_sim is

	port ( 
			fpga_clk_i : in std_logic;
			reset_i : in std_logic;
			sw_i : in std_logic_vector(2 downto 0);
			pb_i : in std_logic_vector(3 downto 0)
		);
		
end vga_top_sim;