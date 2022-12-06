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
-- Design Unit: Pattern Generator (Architecture)
--
-- Description: The pattern generator 1 creates the horzintally striped screen
-- pattern to be displayed via the vga screen
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

architecture rtl of pat_gen_1 is

	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	
	type t_pat_gen_state is (RED,GREEN,BLUE,BLACK);

	signal s_pat_gen_state : t_pat_gen_state;

	
begin

	p_pat_gen_1 : process (reset_i,clk_25hz_i)
	
		variable v_px_count : natural := 0;
	
	begin
		
		if reset_i = '1' then
			
			s_red 	<=	(0 => '1', others => '0');
			s_green <= 	(0 => '1', others => '0');
			s_blue	<= 	(0 => '1', others => '0');
		
		elsif clk_25hz_i = '1' then
			
			-- 40 pix per color with 2 pix of grace period between color switches (backporch - 2 pix = 46)
			if h_sync_i = 46 or h_sync_i = 206 or h_sync_i = 366 or h_sync_i = 526 then
				s_pat_gen_state <= RED;
			elsif h_sync_i = 86 or h_sync_i = 246 or h_sync_i = 406 or h_sync_i = 566 then
				s_pat_gen_state <= GREEN;
			elsif h_sync_i = 126 or h_sync_i = 286 or h_sync_i = 446 or h_sync_i = 606 then
				s_pat_gen_state <= BLUE;
			elsif h_sync_i = 166 or h_sync_i = 326 or h_sync_i = 486 or h_sync_i = 646 then
				s_pat_gen_state <= BLACK;
			else
				s_pat_gen_state <= s_pat_gen_state;
			end if;
			
			-- change display color with moving h_sync_i increments
			case s_pat_gen_state is
			
				when RED =>
				s_red <= "1111";
				s_green <= "0000";
				s_blue <= "0000";
				
				when GREEN =>
				s_red <= "0000";
				s_green <= "1111";
				s_blue <= "0000";
				
				when BLUE =>
				s_red <= "0000";
				s_green <= "0000";
				s_blue <= "1111";
				
				when BLACK =>
				s_red <= "0000";
				s_green <= "0000";
				s_blue <= "0000";
				
				when others =>
				s_red <= "0000";
				s_green <= "0000";
				s_blue <= "0000";
				
			end case;
			
		end if;
	
	end process;
	
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;

end rtl;