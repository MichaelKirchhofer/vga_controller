-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: patgen1.vhd
--
-- Date of Creation: 28.11.2022
--
-- Version: V 2.0
--
-- Date of Latest Version: 22.01.2023
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
	
		variable v_px_count : natural range 0 to 39 := 0;
	
	begin
		
		if reset_i = '1' then
			
			s_red 	<= (others => '0');
			s_green <= (others => '0');
			s_blue	<= (others => '0');
			s_pat_gen_state <= RED;
			v_px_count := 0;
		
		elsif clk_25hz_i'event and clk_25hz_i = '1' then
			
			-- Switch state according to h_sync_i input signal
			if h_sync_i > 0 and h_sync_i <= c_h_vis then
				
				if v_px_count = 39 then
					case s_pat_gen_state is
						when RED => 
							s_pat_gen_state <= GREEN;
						when GREEN =>
							s_pat_gen_state <= BLUE;
						when BLUE =>
							s_pat_gen_state <= BLACK;
						when BLACK =>
							s_pat_gen_state <= RED;
						when others =>
							s_pat_gen_state <= BLACK;
					end case;
					v_px_count := 0;
				else
					v_px_count := v_px_count + 1;
				end if;	
			end if;
			
			
			-- change display color according to state machine
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