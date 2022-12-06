-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: vga_const_pkg.vhd
--
-- Date of Creation: 28.11.2022
--
-- Version: V 1.0
--
-- Date of Latest Version: 28.11.2022
--
-- Design Unit: vga_const_pkg
--
-- Description: This file contains all hardwired timing constraints for the vga
-- standard.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 

package vga_const_pkg is

-- horizontal constants and limitations
constant c_h_vis : natural := 640;
constant c_h_frontp : natural := 16;
constant c_h_sync_t : natural := 96;
constant c_h_backp : natural := 48;
constant c_h_frame_duration : natural := c_h_vis + c_h_frontp + c_h_sync_t + c_h_backp;

-- vertical caonstants and limitations
constant c_v_vis : natural := 480;
constant c_v_frontp : natural := 20;
constant c_v_sync_t : natural := 2;
constant c_v_backp : natural := 33;
constant c_v_frame_duration : natural := c_v_vis + c_v_frontp + c_v_sync_t + c_v_backp;

-- offset for picture loading and timing reasons
constant c_pix_offset : natural := 2;

end;