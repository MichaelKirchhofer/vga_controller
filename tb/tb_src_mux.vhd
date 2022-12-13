-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: tb_pat_gen_2.vhd
--
-- Date of Creation: 21.11.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 29.11.2022
--
-- Design Unit: Pattern generator 1 (Testbench)
--
-- Description: Testbench implementation for the horizontal line pattern
-- generator
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.vga_const_pkg.all;

entity tb_src_mux is
end tb_src_mux;

architecture sim of tb_src_mux is
	
	component src_mux
		port (
			reset_i : in std_logic;
			clk_25hz_i : in std_logic;
			swsync_i : in std_logic_vector (2 downto 0);
			
			r_pat_gen_1_i : in std_logic_vector (3 downto 0);
			g_pat_gen_1_i : in std_logic_vector (3 downto 0);
			b_pat_gen_1_i : in std_logic_vector (3 downto 0);
			
			r_pat_gen_2_i : in std_logic_vector (3 downto 0);
			g_pat_gen_2_i : in std_logic_vector (3 downto 0);
			b_pat_gen_2_i : in std_logic_vector (3 downto 0);
			
			r_mem_ctrl_1_i : in std_logic_vector (3 downto 0);
			g_mem_ctrl_1_i : in std_logic_vector (3 downto 0);
			b_mem_ctrl_1_i : in std_logic_vector (3 downto 0);
			
			r_mem_ctrl_2_i : in std_logic_vector (3 downto 0);
			g_mem_ctrl_2_i : in std_logic_vector (3 downto 0);
			b_mem_ctrl_2_i : in std_logic_vector (3 downto 0);
			
			
			red_o : out std_logic_vector (3 downto 0);
			green_o : out std_logic_vector (3 downto 0);
			blue_o : out std_logic_vector (3 downto 0);
			movable_obj_o : out std_logic
		);
	end component;
	
	signal s_clk_i 			: std_logic;
	signal s_reset_i		: std_logic;
	signal s_swsync_i		: std_logic_vector (2 downto 0);
	
	signal s_red_o 			: std_logic_vector (3 downto 0);
	signal s_green_o 		: std_logic_vector ( 3 downto 0);
	signal s_blue_o 		: std_logic_vector(3 downto 0);
	
	signal	s_r_pat_gen_1_i : std_logic_vector (3 downto 0) := "1111";
	signal	s_g_pat_gen_1_i : std_logic_vector (3 downto 0) := "1111";
	signal	s_b_pat_gen_1_i : std_logic_vector (3 downto 0) := "1111";
			
	signal	s_r_pat_gen_2_i : std_logic_vector (3 downto 0) := "0000";
	signal	s_g_pat_gen_2_i : std_logic_vector (3 downto 0) := "0000";
	signal	s_b_pat_gen_2_i : std_logic_vector (3 downto 0) := "0000";
			
	signal	s_r_mem_ctrl_1_i : std_logic_vector (3 downto 0) := "0101";
	signal	s_g_mem_ctrl_1_i : std_logic_vector (3 downto 0) := "0101";
	signal	s_b_mem_ctrl_1_i : std_logic_vector (3 downto 0) := "0101";
			
	signal	s_r_mem_ctrl_2_i : std_logic_vector (3 downto 0) := "1010";
	signal	s_g_mem_ctrl_2_i : std_logic_vector (3 downto 0) := "1010";
	signal	s_b_mem_ctrl_2_i : std_logic_vector (3 downto 0) := "1010";
	
	signal s_movable_obj 	 : std_logic;
	
	
	begin
		
		i_src_mux : src_mux
		
		port map(
			reset_i => s_reset_i,
			clk_25hz_i => s_clk_i,
			swsync_i => s_swsync_i,
			red_o => s_red_o,
			green_o => s_green_o,
			blue_o => s_blue_o,
			r_pat_gen_1_i  =>  s_r_pat_gen_1_i,
			g_pat_gen_1_i  =>  s_g_pat_gen_1_i,
			b_pat_gen_1_i  =>  s_b_pat_gen_1_i,
			r_pat_gen_2_i  =>  s_r_pat_gen_2_i,
			g_pat_gen_2_i  =>  s_g_pat_gen_2_i,
			b_pat_gen_2_i  =>  s_b_pat_gen_2_i,
			r_mem_ctrl_1_i =>  s_r_mem_ctrl_1_i,
			g_mem_ctrl_1_i =>  s_g_mem_ctrl_1_i,
			b_mem_ctrl_1_i =>  s_b_mem_ctrl_1_i,
			r_mem_ctrl_2_i => s_r_mem_ctrl_2_i,
			g_mem_ctrl_2_i => s_g_mem_ctrl_2_i,
			b_mem_ctrl_2_i => s_b_mem_ctrl_2_i
			
		);
	
		--25Mhz clock
	    p_clock : process
		begin
			s_clk_i <= '0';
			wait for 40 ns;
			s_clk_i <= '1';
			wait for 40 ns;
		end process p_clock;
		
		p_reset : process	
		begin
			s_reset_i <= '1';
			wait for 10 ns;
			s_reset_i <= '0';
			wait;
		end process p_reset;
		
		p_src_mux_test : process
		
		begin
			
			-- Pattern generator 1 to be driven out
			s_swsync_i <= "000";
			wait for 1 ms;
			assert (s_red_o = "1111" and s_green_o = "1111" and s_blue_o = "1111" and s_movable_obj = '0')
				report "The value of pattern generator 1 is not driven correctly to the output pins AND/OR Movable object flag has been set!"
					severity ERROR;
			wait for 1 ms;
			
			-- Pattern generator 2 to be driven out
			s_swsync_i <= "010";
			wait for 1 ms;
			assert (s_red_o = "0000" and s_green_o = "0000" and s_blue_o = "0000" and s_movable_obj = '0')
				report "The value of pattern generator 2 is not driven correctly to the output pins AND/OR Movable object flag has been set!"
					severity ERROR;			
			wait for 1 ms;
			
			-- Memory control unit 1 to be driven out
			s_swsync_i <= "001";
			wait for 1 ms;
			assert (s_red_o = "0101" and s_green_o = "0101" and s_blue_o = "0101" and s_movable_obj = '0')
				report "The value of the memory control 1 input is not driven correctly to the output pins AND/OR Movable object flag has been set!"
					severity ERROR;
			wait for 1 ms;
			
			-- Memory control unit 2 to be driven out
			s_swsync_i <= "100";
			wait for 1 ms;
			assert (s_red_o = "1010" and s_green_o = "1010" and s_blue_o = "1010" and s_movable_obj = '1')
				report "The value of the memory control 2 input is not driven correctly to the output pins AND/OR Movable object flag has not been set!"
					severity ERROR;	
			wait;
			
		end process p_src_mux_test;

end sim;