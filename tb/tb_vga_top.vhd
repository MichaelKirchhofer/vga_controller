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
-- Description: Signal and Input for test runs using the finished controler
-- with all plls and rom instances
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.vga_const_pkg.all;

entity tb_vga_top is
end tb_vga_top;

architecture sim of tb_vga_top is

	-- clock generator test design
	component vga_top is
	 port ( 
			fpga_clk_i : in std_logic;
			reset_i : in std_logic;
			sw_i : in std_logic_vector(2 downto 0);
			pb_i : in std_logic_vector(3 downto 0);
			red_o : out std_logic_vector (3 downto 0);
			green_o : out std_logic_vector ( 3 downto 0);
			blue_o : out std_logic_vector ( 3 downto 0);
			h_sync_flag_o : out std_logic;
			v_sync_flag_o : out std_logic
		);
	end component;

	signal s_fpga_clk		: std_logic;
	signal s_reset 			: std_logic;
	signal s_sw 			: std_logic_vector(2 downto 0); 
	signal s_pb 			: std_logic_vector(3 downto 0);
	signal s_h_sync_flag	: std_logic;
	signal s_v_sync_flag	: std_logic;
	signal s_red			: std_logic_vector (3 downto 0);
	signal s_green			: std_logic_vector ( 3 downto 0);
	signal s_blue 			: std_logic_vector(3 downto 0);
	
	begin

	  -- simulate 100 MHz clock oscillator
	  p_osc : process
	  begin
	    loop
	      s_fpga_clk <= '0';
	      wait for 5 ns;
	      s_fpga_clk <= '1';
	      wait for 5 ns;
	    end loop;
	  end process p_osc;

	  -- instantiate clock generator test design
	  i_test_VGAtop : VGA_top
	    port map(
	      	fpga_clk_i => s_fpga_clk,
	      	reset_i	  => s_reset,
			sw_i 	=> s_sw,
			pb_i  	=> s_pb,
			red_o => s_red,
			green_o => s_green,
			blue_o => s_blue,
			h_sync_flag_o => s_h_sync_flag,
			v_sync_flag_o => s_v_sync_flag
	      );    
        
	  -- timing of simulation
	  p_tb : process
	  begin
	    -- apply reset for 5 clock cycles
	    s_reset <= '1';
	    wait for 5*20 ns;
	    s_reset <= '0';
        
	    -- wait until end of simulation
	    wait;
	  end process;
    
    -- input pattern for switches and buttons
	  p_swpb : process
	  begin

	  s_sw <= "000";
      wait for 16.8 ms;
      s_sw <= "101";
      wait for 16.8 ms;  
      s_pb <= "0001";
      wait for 16.8 ms;
      s_sw <= "000";  
      s_pb <= "0001";
      wait for 16.8 ms;
      s_sw <= "001";
      s_pb <= "0001"; 
	    
	  -- wait until end of simulation
	  wait;
	  end process;

end sim;