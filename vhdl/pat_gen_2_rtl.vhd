-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: patgen2.vhd
--
-- Date of Creation: 28.11.2022
--
-- Version: V 1.3
--
-- Date of Latest Version: 22.01.2023
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
	
	begin
		
		if reset_i = '1' then
			s_gen_line_state <= LINE_RED;
			s_pat_gen_state <= RED;
			s_red 	<=	(others => '0');
			s_green <= 	(others => '0');
			s_blue	<= 	(others => '0');
		
		elsif clk_25hz_i'event and clk_25hz_i = '1' then
			
			-- Set line state machine according to the vertical input signal
			if (v_sync_i > 0 and v_sync_i <= 48) or (v_sync_i > 144 and v_sync_i <= 192) or (v_sync_i > 288 and v_sync_i <= 336) or (v_sync_i > 432 and v_sync_i <= 480) or v_sync_i >= 576 then
			
				s_gen_line_state <= LINE_RED;
				
			elsif (v_sync_i > 48 and v_sync_i <= 96) or (v_sync_i > 192 and v_sync_i <= 240) or (v_sync_i > 336 and v_sync_i <= 384) or (v_sync_i > 480 and v_sync_i <= 528)  then
			
				s_gen_line_state <= LINE_GREEN;
			
			elsif (v_sync_i > 96 and v_sync_i <= 144) or (v_sync_i > 240 and v_sync_i <= 288) or (v_sync_i > 384 and v_sync_i <= 432) or (v_sync_i > 528 and v_sync_i <= 576)  then
				
				s_gen_line_state <= LINE_BLUE;
				
			end if;
			
			-- Set color state machine according to the line state machine and the horizontal input signal
			if (h_sync_i > 0 and h_sync_i <= 64) or (h_sync_i > 192 and h_sync_i <= 256) or (h_sync_i > 384 and h_sync_i <= 448) or (h_sync_i > 576 and h_sync_i <= 640) or h_sync_i >= 768 then
				
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
				
			-- Set color state machine according to the line state machine and the horizontal input signal	
			elsif (h_sync_i > 64 and h_sync_i <= 128) or (h_sync_i > 256 and h_sync_i <= 320) or (h_sync_i > 448 and h_sync_i <= 512) or ( h_sync_i > 640 and h_sync_i <= 704) then
			
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
			
			-- Set color state machine according to the line state machine and the horizontal input signal
			elsif (h_sync_i > 128 and h_sync_i <= 192) or (h_sync_i > 320 and h_sync_i <= 384) or (h_sync_i > 512 and h_sync_i <= 576) or (h_sync_i > 704 and h_sync_i <= 768) then
			
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
			end if;
			
			-- Color state machine
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