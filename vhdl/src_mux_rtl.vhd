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
	
	signal s_x_pos : natural := 160;
	signal s_y_pos : natural := 120;
	
	constant c_pic_dim : natural := 100;
	
	-- Slow down signal switch by one clock cycle
	signal s_enable_input_switch : std_logic;
	
	type t_src_mux_state is (MEM_CTRL,PAT_GEN1,PAT_GEN2);

	signal s_src_mux_state : t_src_mux_state;
	
	procedure p_pars_pbsync (
		signal r_IN  : in  std_logic_vector(7 downto 0);
		signal r_OUT : out std_logic_vector(7 downto 0)
		) 
	is
	
	begin
		
		
	end p_INCREMENT_SLV;
	
	
begin
	
	p_src_mux : process (reset_i,clk_25hz_i) 
	
	begin
		
		if reset_i = '1' then
			
			s_src_mux_state <= PAT_GEN1;
			s_red 	<=	(others => '0');
			s_green <= 	(others => '0');
			s_blue	<= 	(others => '0');
			s_x_pos <= 160;
			s_y_pos <= 120;
		
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
						
						if hsync_i >= s_x_pos and hsync_i < s_x_pos + c_pic_dim then
							
							if vsync_i >= s_y_pos and vsync_i < s_y_pos + c_pic_dim then
	
								s_red <= r_mem_ctrl_2_i;
								s_green <= g_mem_ctr_2_i;
								s_blue <= b_mem_ctrl_2_i;
							
							end if;	
						
						else
							s_red 	<= r_pat_gen_1_i;
							s_green <= g_pat_gen_1_i;
							s_blue 	<= b_pat_gen_1_i;
						end if;
						
					else 
						s_red 	<= r_pat_gen_1_i;
						s_green <= g_pat_gen_1_i;
						s_blue 	<= b_pat_gen_1_i;
					end if;	
				
				when PAT_GEN2 =>
					
					if swsync_i(2) = '1' then
					
						if hsync_i >= s_x_pos and hsync_i < s_x_pos + c_pic_dim then
							
							if vsync_i >= s_y_pos and vsync_i < s_y_pos + c_pic_dim then
	
								s_red <= r_mem_ctrl_2_i;
								s_green <= g_mem_ctr_2_i;
								s_blue <= b_mem_ctrl_2_i;
							
							end if;	
							
						else
							s_red 	<= r_pat_gen_2_i;
							s_green <= g_pat_gen_2_i;
							s_blue 	<= b_pat_gen_2_i;
						end if;
					
					else 
						s_red 	<= r_pat_gen_2_i;
						s_green <= g_pat_gen_2_i;
						s_blue 	<= b_pat_gen_2_i;
					end if;	
					
				when MEM_CTRL =>
						s_red 	<= r_mem_ctrl_1_i;
						s_green <= g_mem_ctrl_1_i;
						s_blue 	<= b_mem_ctrl_1_i;
					end if;
					
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

end rtl;