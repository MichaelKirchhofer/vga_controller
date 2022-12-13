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
-- Design Unit: ROM Controller 1 (Architecture)
--
-- Description: The ROM Controller fetches the picture pixel data from the ROM1
-- Block of the FPGA Board
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.vga_const_pkg.all;

architecture rtl of mem_ctrl_1 is

	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	signal s_rom_addr : std_logic_vector (15 downto 0);
	signal s_rom_data : std_logic_vector (11 downto 0);
	
	constant c_last_rom_addr : natural := 76800;
	
begin

	p_mem_ctrl_1 : process (reset_i,clk_25hz_i)
	
	variable v_rom_addr : natural range 0 to c_last_rom_addr;
	
	begin
		
		if reset_i = '1' then
			
			s_red <= (others => '0');
			s_green <= (others => '0');
			s_blue <= (others => '0');
			s_rom_addr <= (others => '0');
			s_rom_data <= (others => '0');
		
		elsif clk_25hz_i = '1' then
			
			
			if(h_sync_i >= c_h_backp  and h_sync_i < c_h_vis /2 ) then
				
				--Picture 1 Upper / Left
				if ( v_sync_i >= c_v_backp  and v_sync_i < c_v_backp + c_v_vis / 2  ) then
					
					v_rom_addr := (h_sync_i-c_h_backp) * (v_sync_i-c_v_backp);
					
					
				-- Picture 2 Lower / Left
				elsif (v_sync_i >= c_v_backp + c_v_vis / 2 ) then
					
					v_rom_addr := (h_sync_i - c_h_backp) * ( v_sync_i - c_v_backp - c_v_vis / 2);
					
				end if;
				
			elsif (h_sync_i >= c_h_backp + c_h_vis / 2 ) then
				
				--Picture 3 Upper / Right
				if ( v_sync_i >= c_v_backp  and v_sync_i < c_v_backp + c_v_vis / 2  ) then
					
					v_rom_addr := (h_sync_i - c_h_backp - c_h_vis / 2) * (v_sync_i - c_v_backp);
					
				-- Picture 2 Lower / Right
				elsif (v_sync_i >= c_v_backp + c_v_vis / 2 ) then
					
					v_rom_addr := (h_sync_i - c_h_backp - c_h_vis / 2) * (v_sync_i - c_v_backp - c_v_vis / 2);
					
				end if;
				
			end if;
			
			s_rom_addr <= std_logic_vector(to_unsigned(v_rom_addr,s_rom_addr'length));
			
			s_red <= rom_data_i(11 downto 8);
			s_green <= rom_data_i(7 downto 4);
			s_blue <= rom_data_i(3 downto 0);
			
		end if;
		
	end process;
	
	rom_addr_o <= s_rom_addr;
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;
	rom_addr_o <= s_rom_addr;

end rtl;