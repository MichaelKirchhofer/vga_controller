-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: mem_ctrl_2.vhd
--
-- Date of Creation: 06.12.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 13.12.2022
--
-- Design Unit: ROM Controller 2 (Entity)
--
-- Description: The ROM Controller fetches the picture pixel data from the ROM2
-- which contains the picture data of the movable object to be displayed on
-- screen
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

architecture rtl of mem_ctrl_2 is
	
	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	signal s_rom_addr : std_logic_vector (15 downto 0);
	signal s_rom_data : std_logic_vector (11 downto 0);
	
	constant c_last_rom_addr : natural := 76800;
	
begin

	p_mem_ctrl_2 : process(reset_i,clk_25hz_i)
	
	variable v_rom_addr : natural range 0 to c_last_rom_addr;
	
	begin
		
		if reset_i = '1' then
			
			s_red <= (others => '0');
			s_green <= (others => '0');
			s_blue <= (others => '0');
			s_rom_addr <= (others => '0');
			s_rom_data <= (others => '0');
		
		elsif clk_25hz_i = '1' then
			
			if h_sync_i
		
		end if;
		
		
	end process;
	
	rom_addr_o <= s_rom_addr;
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;
	rom_addr_o <= s_rom_addr;
	
end rtl;