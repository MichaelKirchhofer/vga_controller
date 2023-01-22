-------------------------------------------------------------------------------
--
-- Author: Michael Kirchhofer
--
-- Filename: vga_const_pkg.vhd
--
-- Date of Creation: 28.11.2022
--
-- Version: V 4.0
--
-- Date of Latest Version: 16.12.2022
--
-- Design Unit: vga_const_pkg
--
-- Description: This file contains all hardcoded timing constraints for the vga
-- standard and some display constants for the movable object
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 

package vga_const_pkg is

-- horizontal constants and limitations
constant c_h_vis : natural := 640;
constant c_h_backp : natural := 48;
constant c_h_sync_t : natural := 96;
constant c_h_frontp : natural := 16;
constant c_h_frame_duration : natural := c_h_vis + c_h_frontp + c_h_sync_t + c_h_backp;

-- vertical caonstants and limitations
constant c_v_vis : natural := 480;
constant c_v_frontp : natural := 10;
constant c_v_sync_t : natural := 2;
constant c_v_backp : natural := 33;
constant c_v_frame_duration : natural := c_v_vis + c_v_frontp + c_v_sync_t + c_v_backp;

-- offset for picture loading and timing reasons
constant c_pix_offset : natural := 2;

-- mem ctrl 2 picture constants
constant c_pic_dim : natural := 100;
constant c_def_x_pos : natural := 160;
constant c_def_y_pos : natural := 120;
constant c_pic_hop_pix : natural := 20;

end;