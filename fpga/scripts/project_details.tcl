# Copyright (C) 2023  AGH University of Science and Technology
# MTM UEC2
# Author: Piotr Kaczmarczyk
#
# Description:
# Project detiles required for generate_bitstream.tcl
# Make sure that project_name, top_module and target are correct.
# Provide paths to all the files required for synthesis and implementation.
# Depending on the file type, it should be added in the corresponding section.
# If the project does not use files of some type, leave the corresponding section commented out.

#-----------------------------------------------------#
#                   Project details                   #
#-----------------------------------------------------#
# Project name                                  -- EDIT
set project_name vga_project

# Top module name                               -- EDIT
set top_module top_vga_basys3

# FPGA device
set target xc7a35tcpg236-1

#-----------------------------------------------------#
#                    Design sources                   #
#-----------------------------------------------------#
# Specify .xdc files location                   -- EDIT
set xdc_files {
    constraints/top_vga_basys3.xdc
}

# Specify SystemVerilog design files location   -- EDIT
set sv_files {
    ../rtl/vga_pkg.sv
    ../rtl/vga_if.sv
    ../rtl/vga_timing.sv
    ../rtl/menu/draw_menu.sv
    ../rtl/menu/menu_select_text.sv
    ../rtl/menu/draw_menu_text.sv
    ../rtl/menu/menu_textmenu.sv
    ../rtl/menu/menu_text1.sv
    ../rtl/menu/menu_text2.sv
    ../rtl/menu/menu_text3.sv
    ../rtl/common/my_function.sv
    ../rtl/common/numb2char.sv
    ../rtl/keyboard/keyboard_decode.sv
    ../rtl/keyboard/change_clock.sv
    ../rtl/common/delay.sv
    ../rtl/common/font_rom.sv
    ../rtl/menu/top_menu.sv
    ../rtl/game/draw_game_bg.sv 
    ../rtl/game/draw_game_1.sv 
    ../rtl/game/draw_map.sv 
    ../rtl/game/draw_player.sv 
    ../rtl/game/player_control.sv 
    ../rtl/game/player_control_y.sv 
    ../rtl/game/mape_rom.sv 
    ../rtl/game/game_map_ofset.sv
    ../rtl/game/player_rom.sv 
    ../rtl/game/top_game.sv 
    ../rtl/game/control_hp.sv 
    ../rtl/game/game_wall.sv 
    ../rtl/game/wall_rom.sv 
    ../rtl/game/game_end.sv 
    ../rtl/game/game_content/game_cont_dialog1.sv
    ../rtl/game/game_content/game_cont_txt1.sv
    ../rtl/game/game_content/game_cont_txt2.sv
    ../rtl/game/game_content/game_cont_txt3.sv
    ../rtl/game/game_content/game_cont_txt4.sv
    ../rtl/game/game_content/game_cont_txt5.sv
    ../rtl/game/game_content/game_cont_txt6.sv
    ../rtl/game/game_content/game_content_top.sv
    ../rtl/control.sv
    ../rtl/top_prj_keyboard.sv  
    ../rtl/top_prj_gameplay.sv 
    rtl/top_vga_basys3.sv
}

# Specify Verilog design files location         -- EDIT
 set verilog_files {
    ../rtl/clk_wiz_0_clk_wiz.v
 }

# Specify VHDL design files location            -- EDIT
set vhdl_files {
    ../rtl/common/Ps2Interface.vhd 
}

#    path/to/file.vhd
# Specify files for a memory initialization     -- EDIT
# set mem_files {
#    path/to/file.data
# }
 set mem_files {
    ../rtl/images/map2.dat
    ../rtl/images/mapa_test.dat
    ../rtl/images/player.dat
    ../rtl/images/player_left.dat
    ../rtl/images/wall.dat
}

