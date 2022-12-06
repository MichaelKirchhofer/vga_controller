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
-- Design Unit: VGA Source Multiplexer (Architecture)
--
-- Description: The source multiplexer switches the display inputs according to
-- the switch position on the fpga board
--
-------------------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

architecture rtl of src_mux is

	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	
	-- Slow down signal switch by one clock cycle
	signal s_enable_input_switch : std_logic;
	
	type t_src_mux_state is (MEM1,MEM2,PAT_GEN1,PAT_GEN2);

	signal s_src_mux_state : t_src_mux_state;
	
begin

	p_src_mux : process (reset_i,clk_25hz_i)
	
	begin
		
		if reset_i = '1' then
			
			s_src_mux_state <= PAT_GEN1;
			s_enable_input_switch <= '1';
			s_red 	<=	(others => '0');
			s_green <= 	(others => '0');
			s_blue	<= 	(others => '0');
		
		elsif clk_25hz_i = '1' then
		
			case swsync_i is
				
				when "000" =>
					s_src_mux_state <= PAT_GEN1;
					s_enable_input_switch <= '1';
				when "001" => 
					s_src_mux_state <= PAT_GEN2;
					s_enable_input_switch <= '1';
				when "010" =>
					s_src_mux_state <= MEM1;
					s_enable_input_switch <= '1';
				when "100" =>
					s_src_mux_state <= MEM2;
					s_enable_input_switch <= '1';
				when others =>
					s_src_mux_state <= s_src_mux_state;
					s_enable_input_switch <= '0';
			end case;
			
			if s_enable_input_switch = '1' then
				
				s_enable_input_switch <= '0';
				
				case s_src_mux_state is 
				
					when PAT_GEN1 =>
						s_red 	<= r_pat_gen_1_i;
						s_green <= g_pat_gen_1_i;
						s_blue 	<= b_pat_gen_1_i;
					when PAT_GEN2 =>
						s_red 	<= r_pat_gen_2_i;
						s_green <= g_pat_gen_2_i;
						s_blue 	<= b_pat_gen_2_i;
					when MEM1 =>
						s_red 	<= r_mem_ctrl_1_i;
						s_green <= g_mem_ctrl_1_i;
						s_blue 	<= b_mem_ctrl_1_i;
					when MEM2 =>
						s_red 	<= r_mem_ctrl_2_i;
						s_green <= g_mem_ctrl_2_i;
						s_blue 	<= b_mem_ctrl_2_i;
					when others =>
						s_red <= s_red;
						s_green <= s_green;
						s_blue <= s_blue;
					end case;
				
			end if;
			
		end if;
		
	end process;
		
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;

end rtl;