-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: src_mux.vhd
--
-- Date of Creation: 06.12.2022
--
-- Version: V 3.2
--
-- Date of Latest Version: 22.01.2023
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
	
	signal s_x_pos : natural;
	signal s_y_pos : natural;
	
	-- Slow down signal switch by one clock cycle
	signal s_enable_input_switch : std_logic;
	signal s_btn_rdy : std_logic;
	
	type t_src_mux_state is (MEM_CTRL,PAT_GEN1,PAT_GEN2);

	signal s_src_mux_state : t_src_mux_state;
	
begin
	
	p_src_mux : process (reset_i,clk_25hz_i) 
	
	variable v_x_pos : natural range 0 to 540 := 100;
	variable v_y_pos : natural range 0 to 380 := 100;
	
	begin
		
		if reset_i = '1' then
			
			s_src_mux_state <= PAT_GEN1;
			s_red 	<=	(others => '0');
			s_green <= 	(others => '0');
			s_blue	<= 	(others => '0');
			v_x_pos := c_def_x_pos;
			v_y_pos := c_def_y_pos;
			s_btn_rdy <= '1';
		
		elsif clk_25hz_i'event and clk_25hz_i = '1' then
			
			-- Parse button input to set new position for the movable object
			case pbsync_i is 
				-- BTNL
				--when "1000" =>
				when "1000" =>
					if s_btn_rdy = '1' then
						s_btn_rdy <= '0';
						if v_x_pos >= 40 then
							v_x_pos := v_x_pos - c_pic_hop_pix;
						else
							v_x_pos := 0;
						end if;
					end if;
				-- BTNU
				when "0100" =>
					if s_btn_rdy = '1' then
						s_btn_rdy <= '0';
						if v_y_pos >= 40 then
							v_y_pos := v_y_pos - c_pic_hop_pix; 
						else
							v_y_pos := 0;
						end if;
					end if;
				-- BTNR	when "0010" =>
				when "0010" =>
					if s_btn_rdy <= '1' then
						s_btn_rdy <= '0';
						if v_x_pos = 540 then
							v_x_pos := v_x_pos;
						else
							v_x_pos := v_x_pos - c_pic_hop_pix;
						end if;
					end if;
				-- BTND
				when "0001" =>
					if s_btn_rdy <= '1' then
						s_btn_rdy <= '0';
						if v_y_pos = 360 then
							v_y_pos := v_y_pos;
						else
							v_y_pos := v_y_pos + c_pic_hop_pix;
						end if;
					end if;	
				when others =>
					s_btn_rdy <= '1';
					v_y_pos := v_y_pos;
					v_x_pos := v_x_pos;
			end case;
			
			-- Parse switch 1 and 0 to set multiplexer state machine
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
			
			-- Multiplexer state machine
			case s_src_mux_state is 
				
				-- Pattern generator 1 input / moveable object over the pattern
				when PAT_GEN1 =>
					
					if swsync_i(2) = '1' then
						
						if h_sync_i >= v_x_pos and h_sync_i < (v_x_pos + c_pic_dim) then
							
							if v_sync_i >= v_y_pos and v_sync_i < (v_y_pos + c_pic_dim)then
								-- Only display ROM 2 content while inside the x_pos and y_pos coordinates
								s_red 	<= r_mem_ctrl_2_i;
								s_green <= g_mem_ctrl_2_i;
								s_blue 	<= b_mem_ctrl_2_i;
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
						
					else
						v_x_pos := c_def_x_pos;
						v_y_pos := c_def_y_pos;
						s_red 	<= r_pat_gen_1_i;
						s_green <= g_pat_gen_1_i;
						s_blue 	<= b_pat_gen_1_i;
					end if;	
					
				-- Pattern generator 2 input / moveable object over the pattern
				when PAT_GEN2 =>
					
					if swsync_i(2) = '1' then
						
						if h_sync_i >= v_x_pos and h_sync_i < (v_x_pos + c_pic_dim) then
							
							if v_sync_i >= v_y_pos and v_sync_i < (v_y_pos + c_pic_dim) then
							-- Only display ROM 2 content while inside the x_pos and y_pos coordinates
								s_red <= r_mem_ctrl_2_i;
								s_green <= g_mem_ctrl_2_i;
								s_blue <= b_mem_ctrl_2_i;
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
					
					else
						v_x_pos := c_def_x_pos;
						v_y_pos := c_def_y_pos;
						s_red 	<= r_pat_gen_2_i;
						s_green <= g_pat_gen_2_i;
						s_blue 	<= b_pat_gen_2_i;
					end if;	
					
				-- ROM Memory 1 input / moveable object over the ROM contents	
				when MEM_CTRL =>
					if swsync_i(2) = '1' then
					
					if h_sync_i >= v_x_pos and h_sync_i < (v_x_pos + c_pic_dim) then
						
						if v_sync_i >= v_y_pos and v_sync_i < (v_y_pos + c_pic_dim) then
							-- Only display ROM 2 content while inside the x_pos and y_pos coordinates
							s_red 	<= r_mem_ctrl_2_i;
							s_green <= g_mem_ctrl_2_i;
							s_blue 	<= b_mem_ctrl_2_i;
						else
							s_red 	<=  r_mem_ctrl_1_i;
							s_green <=  g_mem_ctrl_1_i;
							s_blue 	<=  b_mem_ctrl_1_i;
						end if;	
					
					else
						s_red 	<= r_mem_ctrl_1_i;
						s_green <= g_mem_ctrl_1_i;
						s_blue 	<= b_mem_ctrl_1_i;
					end if;
					
					else
						v_x_pos := c_def_x_pos;
						v_y_pos := c_def_y_pos;
						s_red 	<= r_mem_ctrl_1_i;
						s_green <= g_mem_ctrl_1_i;
						s_blue 	<= b_mem_ctrl_1_i;
					end if;	
					
				when others =>
					s_red 	<= s_red;
					s_green <= s_green;
					s_blue 	<= s_blue;
					
			end case;
			s_x_pos <= v_x_pos;
			s_y_pos <= v_y_pos;
		end if;
		
	end process;
		
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;
	x_pos_o <= s_x_pos;
	y_pos_o <= s_y_pos;

end rtl;