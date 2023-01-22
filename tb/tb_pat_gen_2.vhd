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

entity tb_pat_gen_2 is
end tb_pat_gen_2;

architecture sim of tb_pat_gen_2 is
	
	component pat_gen_2
		port (
			reset_i : in std_logic;
			clk_25hz_i : in std_logic;
			h_sync_i : in integer range 0 to (c_h_frame_duration-1);
			v_sync_i : in integer range 0 to (c_v_frame_duration-1);
			red_o : out std_logic_vector (3 downto 0);
			green_o : out std_logic_vector (3 downto 0);
			blue_o : out std_logic_vector (3 downto 0)
		);
	end component;
	
	signal s_clk_i 			: std_logic;
	signal s_reset_i		: std_logic;
	signal s_h_pix_count 	: integer range 0 to (c_h_frame_duration-1);
	signal s_v_pix_count	: integer range 0 to (c_v_frame_duration-1);
	signal s_red_o 			: std_logic_vector (3 downto 0);
	signal s_green_o 		: std_logic_vector ( 3 downto 0);
	signal s_blue_o 		: std_logic_vector(3 downto 0);
	
	
	begin
		
		i_pat_gen_2 : pat_gen_2
		
		port map(
			reset_i => s_reset_i,
			clk_25hz_i => s_clk_i,
			h_sync_i => s_h_pix_count,
			v_sync_i => s_v_pix_count,
			red_o => s_red_o,
			green_o => s_green_o,
			blue_o => s_blue_o
		);
	
		--25Mhz clock
	    p_clock : process
		begin
			s_clk_i <= '0';
			wait for 20 ns;
			s_clk_i <= '1';
			wait for 20 ns;
		end process p_clock;
		
		p_reset : process	
		begin
			s_reset_i <= '1';
			wait for 10 ns;
			s_reset_i <= '0';
			wait;
		end process p_reset;
		
		p_pat_gen_1_test : process
		
		begin
			
			if s_h_pix_count = c_h_frame_duration - 1 then
			
				if s_v_pix_count = c_v_frame_duration - 1 then
					s_v_pix_count <= 0;
				else
					s_v_pix_count <= s_v_pix_count + 1;
				end if;
				
				s_h_pix_count <= 0;
			
			else
				s_h_pix_count <= s_h_pix_count + 1;
			end if;
			
			wait for 40 ns;
			
		end process p_pat_gen_1_test;

end sim;