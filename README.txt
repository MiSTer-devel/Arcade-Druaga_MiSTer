---------------------------------------------------------------------------------
-- 
-- Arcade: The Tower of Druaga  port to MiSTer by MiSTer-X
-- 24 October 2019
-- From: https://github.com/MrX-8B/MiSTer-Arcade-Druaga
-- 
---------------------------------------------------------------------------------
-- FPGA Druaga for XILINX Spartan-3
--------------------------------------
-- Copyright (c) 2007 MiSTer-X
---------------------------------------------------------------------------------
-- Cycle-Accurate 6809 Core
-- Revision 1.0 - 13th August 2016
---------------------------------------------------
-- Copyright (c) 2016, Greg Miller
---------------------------------------------------------------------------------
-- 
-- 
-- Keyboard inputs :
--
--   F2          : Coin + Start 2 players
--   F1          : Coin + Start 1 player
--   UP,DOWN,LEFT,RIGHT arrows : Movements
--   SPACE       : Trig1
--   CTRL        : Trig2
--
-- MAME/IPAC/JPAC Style Keyboard inputs:
--   5           : Coin 1
--   6           : Coin 2
--   1           : Start 1 Player
--   2           : Start 2 Players
--   R,F,D,G     : Player 2 Movements
--   A           : Player 2 Trig1
--   S           : Player 2 Trig2
--
-- Joystick support.
-- 
-- 
---------------------------------------------------------------------------------

                                *** Attention ***

ROMs are not included. In order to use this arcade, you need to provide the
correct ROMs.

To simplify the process .mra files are provided in the releases folder, that
specifies the required ROMs with checksums. The ROMs .zip filename refers to the
corresponding file of the M.A.M.E. project.

Please refer to https://github.com/MiSTer-devel/Main_MiSTer/wiki/Arcade-Roms for
information on how to setup and use the environment.

Quickreference for folders and file placement:

/_Arcade/<game name>.mra
/_Arcade/cores/<game rbf>.rbf
/_Arcade/mame/<mame rom>.zip
/_Arcade/hbmame/<hbmame rom>.zip
