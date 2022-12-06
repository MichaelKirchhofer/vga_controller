-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: patgen2.vhd
--
-- Date of Creation: 28.11.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 28.11.2022
--
-- Design Unit: Pattern Generator (Architecture)
--
-- Description: The pattern generator 2 creates the chess board screen
-- pattern to be displayed on the vga screen
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

architecture rtl of pat_gen_2 is

	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	
	type t_pat_gen_state is (RED,GREEN,BLUE);
	type t_gen_line_state is (LINE_RED,LINE_GREEN,LINE_BLUE);

	signal s_pat_gen_state : t_pat_gen_state;
	signal s_gen_line_state : t_gen_line_state;
	
begin

	p_pat_gen_2 : process (reset_i,clk_25hz_i)
	
		variable v_px_count : natural := 0;
	
	begin
		
		if reset_i = '1' then
			s_gen_line_state <= LINE_RED;
			s_pat_gen_state <= RED;
			s_red 	<=	(others => '0');
			s_green <= 	(others => '0');
			s_blue	<= 	(others => '0');
		
		elsif clk_25hz_i = '1' then
			
			-- 48 pix per color with 2 pix grace period
			if (v_sync_i >= 31 and v_sync_i < 79) or (v_sync_i >= 175 and v_sync_i < 223) or (v_sync_i >= 319 and v_sync_i < 361) or v_sync_i >= 463 then
			
				s_gen_line_state <= LINE_RED;
				
			elsif (v_sync_i >= 79 and v_sync_i < 127) or (v_sync_i >= 223 and v_sync_i < 271) or (v_sync_i >= 361 and v_sync_i < 415) then

				s_gen_line_state <= LINE_GREEN;
			
			elsif (v_sync_i >= 127 and v_sync_i < 175) or (v_sync_i >= 271 and v_sync_i < 319) or (v_sync_i >= 415 and v_sync_i < 463) then
				
				s_gen_line_state <= LINE_BLUE;
			else
				s_gen_line_state <= s_gen_line_state;
				
			end if;
			
			-- 64 pix per color with 2 pix of grace period between color switches
			if (h_sync_i >= 46 and h_sync_i < 110) or (h_sync_i >= 232 and h_sync_i < 302) or (h_sync_i >= 430 and h_sync_i < 494) or h_sync_i >= 622 then
				
				case s_gen_line_state is
					when LINE_RED =>
						s_pat_gen_state <= RED;
					when LINE_GREEN =>
						s_pat_gen_state <= GREEN;
					when LINE_BLUE =>
						s_pat_gen_state <= BLUE;
					when others =>
						s_pat_gen_state <= s_pat_gen_state;
				end case;		
				
			elsif (h_sync_i >= 110 and h_sync_i < 174) or (h_sync_i >= 302 and h_sync_i < 366) or (h_sync_i >= 494 and h_sync_i < 558) then
			
				case s_gen_line_state is
					when LINE_RED =>
						s_pat_gen_state <= GREEN;
					when LINE_GREEN =>
						s_pat_gen_state <= BLUE;
					when LINE_BLUE =>
						s_pat_gen_state <= RED;
					when others =>
						s_pat_gen_state <= s_pat_gen_state;
				end case;
				
			elsif (h_sync_i >= 174 and h_sync_i < 232) or (h_sync_i >= 366 and h_sync_i < 430) or (h_sync_i >= 558 and h_sync_i < 622) then
			
				case s_gen_line_state is
					when LINE_RED =>
						s_pat_gen_state <= BLUE;
					when LINE_GREEN =>
						s_pat_gen_state <= RED;
					when LINE_BLUE =>
						s_pat_gen_state <= GREEN;
					when others =>
						s_pat_gen_state <= s_pat_gen_state;
				end case;
				
			else
				s_pat_gen_state <= s_pat_gen_state;
				s_gen_line_state <= s_gen_line_state;
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