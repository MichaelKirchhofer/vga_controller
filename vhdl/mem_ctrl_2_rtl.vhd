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
use IEEE.numeric_std.all;
use work.vga_const_pkg.all;

architecture rtl of mem_ctrl_2 is
	
	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	signal s_rom_addr : std_logic_vector (15 downto 0);
	signal s_rom_data : std_logic_vector (11 downto 0);
	
	constant c_last_rom_addr : natural := 9999;
	
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
			
			-- Sync signal indicates that the picture is currently requested to be displayed
			if (h_sync_i >= x_pos_i and h_sync_i < (x_pos_i+c_pic_dim)) then
				
				if(v_sync_i >= y_pos_i and v_sync_i < (y_pos_i+c_pic_dim)) then
					
					if( v_rom_addr = c_last_rom_addr) then
					
						v_rom_addr := 0;
					
					else
					
						v_rom_addr := v_rom_addr + 1;
					
					end if;
					
				else
				
					v_rom_addr := v_rom_addr;
					
				end if;
				
			else
				
				v_rom_addr := v_rom_addr;

			end if;
			
			s_rom_addr <= std_logic_vector(to_unsigned(v_rom_addr,s_rom_addr'length));
			s_red <= rom_data_i (11 downto 8);
			s_green <= rom_data_i (7 downto 4);
			s_blue <= rom_data_i (3 downto 0);
			
		end if;
	
	end process;
	
	rom_addr_o <= s_rom_addr;
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;
end rtl;