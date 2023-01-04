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
-- Date of Latest Version: 13.12.2022
--
-- Design Unit: VGA Source Multiplexer (Architecture)
--
-- Description: Drives out the RGB color signal to the VGA Controller Unit
-- according to the switch positions on the fpga. It is also responsible for
-- the parsing of the push buttons and the positional changes of the displayed
-- picture from the memory control unit 2.
--
-------------------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

architecture rtl of src_mux is

	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	
	signal s_x_pos : natural := c_def_x_pos;
	signal s_y_pos : natural := c_def_y_pos;
	
	-- Slow down signal switch by one clock cycle
	signal s_enable_input_switch : std_logic;
	
	type t_src_mux_state is (MEM_CTRL,PAT_GEN1,PAT_GEN2);

	signal s_src_mux_state : t_src_mux_state;
	
begin
	
	p_src_mux : process (reset_i,clk_25hz_i) 
	
	begin
		
		if reset_i = '1' then
			
			s_src_mux_state <= PAT_GEN1;
			s_red 	<=	(others => '0');
			s_green <= 	(others => '0');
			s_blue	<= 	(others => '0');
			s_x_pos <= c_def_x_pos;
			s_y_pos <= c_def_y_pos;
		
		elsif clk_25hz_i = '1' then
		
			case swsync_i(1 downto 0) is
				
				when "00" =>
					s_src_mux_state <= PAT_GEN1;
				when "01" => 
					s_src_mux_state <= PAT_GEN2;
				when "10" =>
					s_src_mux_state <= MEM_CTRL;
				when others =>
					s_src_mux_state <= s_src_mux_state;
			end case;
			
			
			case s_src_mux_state is 
			
				when PAT_GEN1 =>
					
					if swsync_i(2) = '1' then
						
						case pbsync_i is 
							-- BTNL
							when "1000" =>
								
								if s_x_pos > c_pic_hop_pix then
									s_x_pos <= 0;
								else
									s_x_pos <= s_x_pos - c_pic_hop_pix;
								end if;
							-- BTNU
							when "0100" =>
								if s_y_pos < (c_v_vis - 100) then
									s_y_pos <= s_y_pos + c_pic_hop_pix; 
								else
									s_y_pos <= s_y_pos;
								end if;
								
							-- BTNR	
							when "0010" =>
							-- BTND
								if s_x_pos < (c_h_vis - 100) then
									s_x_pos <= s_x_pos + c_pic_hop_pix;
								else
									s_x_pos <= s_x_pos;
								end if;	
							when "0001" =>
								if s_y_pos > c_pic_hop_pix then
								
									s_y_pos <= s_y_pos - c_pic_hop_pix;
								else
									s_y_pos <= s_y_pos;
								end if;
							when others =>
								s_y_pos <= s_y_pos;
								s_x_pos <= s_x_pos;
						end case;
						
						if h_sync_i >= s_x_pos and h_sync_i < s_x_pos + c_pic_dim then
							
							if v_sync_i >= s_y_pos and v_sync_i < s_y_pos + c_pic_dim then
	
								s_red <= r_mem_ctrl_2_i;
								s_green <= g_mem_ctrl_2_i;
								s_blue <= b_mem_ctrl_2_i;
							
							end if;	
						
						else
							s_red 	<= r_pat_gen_1_i;
							s_green <= g_pat_gen_1_i;
							s_blue 	<= b_pat_gen_1_i;
						end if;
						
					else
						s_x_pos <= c_def_x_pos;
						s_y_pos <= c_def_y_pos;
						s_red 	<= r_pat_gen_1_i;
						s_green <= g_pat_gen_1_i;
						s_blue 	<= b_pat_gen_1_i;
					end if;	
				
				when PAT_GEN2 =>
					
					if swsync_i(2) = '1' then
						
						case pbsync_i is 
							-- BTNL
							when "1000" =>
								s_x_pos <= s_x_pos - 10;
							-- BTNU
							when "0100" =>
								s_y_pos <= s_y_pos + 10;
							-- BTNR	
							when "0010" =>
							-- BTND
								s_x_pos <= s_x_pos + 10;
							when "0001" =>
								s_y_pos <= s_y_pos - 10;
							
							when others =>
								s_y_pos <= s_y_pos;
								s_x_pos <= s_x_pos;
						end case;
						
						if h_sync_i >= s_x_pos and h_sync_i < s_x_pos + c_pic_dim then
							
							if v_sync_i >= s_y_pos and v_sync_i < s_y_pos + c_pic_dim then
	
								s_red <= r_mem_ctrl_2_i;
								s_green <= g_mem_ctrl_2_i;
								s_blue <= b_mem_ctrl_2_i;
							
							end if;	
							
						else
							s_red 	<= r_pat_gen_2_i;
							s_green <= g_pat_gen_2_i;
							s_blue 	<= b_pat_gen_2_i;
						end if;
					
					else
						s_x_pos <= c_def_x_pos;
						s_y_pos <= c_def_y_pos;
						s_red 	<= r_pat_gen_2_i;
						s_green <= g_pat_gen_2_i;
						s_blue 	<= b_pat_gen_2_i;
					end if;	
					
					when MEM_CTRL =>
						s_red 	<= r_mem_ctrl_1_i;
						s_green <= g_mem_ctrl_1_i;
						s_blue 	<= b_mem_ctrl_1_i;
					
					
				when others =>
				
					s_red <= s_red;
					s_green <= s_green;
					s_blue <= s_blue;
					
			end case;
				
		end if;
		
	end process;
		
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;
	x_pos_o <= s_x_pos;
	y_pos_o <= s_y_pos;

end rtl;