-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: io_ctrl_.vhd
--
-- Date of Creation: 28.11.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 28.11.2022
--
-- Design Unit: IO Control Unit (Entity)
--
-- Description: The IO Control manages the push button / switch debouncing and
-- the forwarding of the io inputs to the vga controller logic
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity io_ctrl is

	port (
		clk_25hz_i 		: 	in 	std_logic; 						-- 25 MHz system clock
		reset_i 	: 	in 	std_logic; 						-- asynchronous reset
		pb_i 		:	in 	std_logic_vector (3 downto 0); 	-- 4 Push Buttons states
		sw_i		: 	in	std_logic_vector (15 downto 0); -- 16 input switches	
		swsync_o	:	out std_logic_vector (2 downto 0);	-- 3 debounced switches
		pbsync_o	:	out std_logic_vector (3 downto 0) 	-- 4 debounced push button
		);
 
end io_ctrl;
