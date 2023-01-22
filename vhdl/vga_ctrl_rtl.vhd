-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: vga_ctrl_rtl.vhd
--
-- Date of Creation: 06.12.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 19.01.2022
--
-- Design Unit: VGA Controller (Architecture)
--
-- Description: Controls all screen sync signals and drives out the color signals
-- from the multiplexer to the vga screen. 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.vga_const_pkg.all;

architecture rtl of vga_ctrl is

	signal s_green : std_logic_vector (3 downto 0);
	signal s_red : std_logic_vector (3 downto 0);
	signal s_blue : std_logic_vector(3 downto 0);
	signal s_h_sync : natural range 0 to (c_h_frame_duration-1);
	signal s_v_sync : natural range 0 to (c_v_frame_duration-1);
	signal s_h_sync_flag : std_logic;
	signal s_v_sync_flag : std_logic;
	
begin

	p_vga_ctrl : process (reset_i,clk_25hz_i)
	
	begin
		
		if reset_i = '1' then
			
			s_red <= (others => '0');
			s_green <= (others => '0');
			s_blue <= (others => '0');
			s_h_sync <= 0;
			s_v_sync <= 0;
			s_h_sync_flag <= '0';
			s_v_sync_flag <= '0';
		
		elsif clk_25hz_i'event and clk_25hz_i = '1' then
			
			-- horizontal / vertical sync counters
			if s_h_sync < c_h_frame_duration-1 then
				s_h_sync <= s_h_sync + 1 ;
			else 
				s_h_sync <= 0;
					if s_v_sync < c_v_frame_duration-1 then
						s_v_sync <= s_v_sync + 1;
					else
						s_v_sync <= 0;
					end if;
			end if;
			
			-- vga sync pulses (slide reset flags)	
			if (s_h_sync > c_h_frontp + c_h_vis) and (s_h_sync < c_h_frontp+c_h_vis+c_h_sync_t) then
				s_h_sync_flag <= '1';
			else
				s_h_sync_flag <= '0';
			end if;
			
			if(s_v_sync > c_v_frontp + c_v_vis) and (s_v_sync < c_v_frontp+c_v_vis+c_v_sync_t) then
				s_v_sync_flag <= '1';
			else
				s_v_sync_flag <= '0';
			end if;
			
			--display color signals if sync counter is in the visible screen area
			if s_h_sync > c_h_frontp and s_h_sync <= (c_h_frontp+c_h_vis) then
				s_red <= red_i;
				s_green <= green_i;
				s_blue <= blue_i;
			else
				s_red <= (others => '0');
				s_green <= (others => '0');
				s_blue <= (others => '0');
			end if;
			s_red <= red_i;
			s_green <= green_i;
			s_blue <= blue_i;
		end if;
		
	end process;
	
	red_o <= s_red;
	green_o <= s_green;
	blue_o <= s_blue;
	h_sync_flag_o <= s_h_sync_flag;
	v_sync_flag_o <= s_v_sync_flag;
	h_sync_o <= s_h_sync;
	v_sync_o <= s_v_sync;
	
end rtl;