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
use work.vga_const_pkg.all;

architecture rtl of mem_ctrl_1 is

	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	signal s_rom_addr : std_logic_vector (15 downto 0);
	
	-- Slow down signal switch by one clock cycle
	signal s_enable_input_switch : std_logic;
	
	type t_src_mux_state is (MEM1,MEM2,PAT_GEN1,PAT_GEN2);

	signal s_src_mux_state : t_src_mux_state;
	
	constant c_rom_elem : natural := 76800;
	
	
begin

	p_mem_ctrl_1 : process (reset_i,clk_25hz_i)
	
	variable v_pix_addr : natural range 0 to c_rom_elem;
	
	begin
		
		if reset_i = '1' then
			
			s_red <= (others => '0');
			s_green <= (others => '0');
			s_blue <= (others => '0');
			s_rom_addr <= (others => '0');
		
		elsif clk_25hz_i = '1' then
			
			--Picture 1 Upper / Left
			if(h_sync_i >= c_h_backp - c_pix_offset and h_sync_i < c_h_vis /2) then
				if ( v_sync_i >= c_v_backp - c_pix_offset and v_sync_i < c_v_vis / 2) then
				
				elsif (v_sync_i >= c_v_vis - c_pix_offset) then
				
				end if;
				
			elsif () then
			
			end if;
			
		end if;
		
	end process;
		
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;
	rom_addr_o <= s_rom_addr;

end rtl;