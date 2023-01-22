-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: tb_vga_top.vhd
--
-- Date of Creation: 16.01.2023
--
-- Version: V 1.0
--
-- Date of Latest Version: 16.01.2023
--
-- Design Unit: VGA Top Level Unit (Testbench)
--
-- Description: Signal and Input for test runs using the VGA monitor simulation
-- model
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.vga_const_pkg.all;

entity tb_vga_sim_top is
end tb_vga_sim_top;

architecture sim of tb_vga_sim_top is

	-- clock generator test design
	component vga_top_sim is
	 port ( 
			fpga_clk_i : in std_logic;
			reset_i : in std_logic;
			sw_i : in std_logic_vector(2 downto 0);
			pb_i : in std_logic_vector(3 downto 0)
		);
	end component;

	signal s_fpga_clk		: std_logic := '0';
	signal s_reset 			: std_logic := '0';
	signal s_sw 			: std_logic_vector(2 downto 0) := "001"; 
	signal s_pb 			: std_logic_vector(3 downto 0) := "0000";
	
	begin

	-- simulate 100 MHz clock oscillator
	p_osc : process
	begin
	    s_fpga_clk <= '1';
	    wait for 20 ns;
	    s_fpga_clk <= '0';
	    wait for 20 ns;
	end process p_osc;

	-- instantiate clock generator test design
	i_vga_top_sim : vga_top_sim
	  port map(
	    	fpga_clk_i => s_fpga_clk,
	    	reset_i	  => s_reset,
			sw_i 	=> s_sw,
			pb_i  	=> s_pb
	    );    
 
    -- input pattern for switches
	  p_sw : process
	  begin
	  s_reset <= '1';
	  wait for 5 ms;
	  s_reset <= '0';
	  wait for 1 ms;
	  s_sw <= "010";
      wait for 31 ms;
      s_sw <= "010";
      wait for 31 ms;  
      s_sw <= "010";
      wait for 31 ms;
      s_sw <= "010";  
      wait for 31 ms;
      s_sw <= "010";  
	  wait;
	  end process;
    
    -- input pattern for buttons
		p_pb : process
	  begin
      s_pb <= "0000";
      wait for 60 ms; 
      s_pb <= "0001";
      wait for 31 ms;
      s_pb <= "0000";
      wait for 31 ms; 
      s_pb <= "0100";     
	  
	  wait;
	  end process;

end sim;