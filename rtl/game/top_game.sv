`timescale 1 ns / 1 ps

module top_game (
    input  logic clk,
    input  logic rst,
    input  logic [3:0] key,
    vga_if.out out,
    vga_if.in in
);

vga_if vga_game1();
vga_if vga_game2();
vga_if vga_game3();
vga_if vga_game4();

draw_game_bg u_draw_game_bg (
    .clk,
    .rst,
    .in(in),
    .out(vga_game1.out)
    
);

wire [7:0] char_xy;
wire [3:0] charline;
wire [10:0] adr;
wire [6:0] charcode;
wire [7:0] char_line_pixels;

wire [15:0] pixel_adr,pixel_adr1, pixel_adr1y ;
wire  [11:0] rgb_pixel,rgb_pixel1, rgb_pixel1y;

wire [10:0] player_xpos,player_xpos2;
wire [7:0] map_ofs;

wire [3:0] hp;
wire [3:0] current_pix, current_pix_y;

control_hp u_control_hp(
    .clk,
    .rst,
    .current_pix(current_pix),
    .key,
    .hp_numb(hp)
);

draw_game_1 u_draw_game_1(
    .clk,
    .rst,
    .hp_in(hp),
    .in(vga_game1.in),
    .out(vga_game2.out),
    //.char_xy(char_xy), 
    //.char_line(charline),
    .char_line_pixels(char_line_pixels),
    .addr(adr)

);

//menu_textmenu u_menu_textmenu(
 //   .clk,
 //   .char_xy(char_xy),           
 //   .char_code(charcode)
//);

font_rom u_font_rom(
    .clk,
    .addr(adr),  
    .char_line_pixels(char_line_pixels)

);


draw_map u_draw_map (
    .clk,
    .rst,
    .in(vga_game2.in),
    .out(vga_game3.out),
    .rgb_pixel(rgb_pixel),
    .pixel_adr(pixel_adr),
    .map_ofset(map_ofs)
    
);

game_mape_ofset u_game_mape_ofset(
.clk,
.rst,
.player_pos(player_xpos),
.player_pos_out(player_xpos2),
.map_ofset(map_ofs)

);


mape_rom u_mape_rom(
    .address(pixel_adr),
    .clk,
    .rgb(rgb_pixel),
    .address2(pixel_adr1),
    //.rgb2(rgb_pixel1),
    .address3(pixel_adr1y),
    //.rgb3(rgb_pixel1y),
    .rgb_cur_pix(current_pix),
    .rgb_cur_pix_y(current_pix_y)
);


wire [8:0] player_ypos;
wire [15:0] pixel_adr2;
wire  [11:0] rgb_pixel2;
wire  [11:0] rgb_pixel2l;
wire dir, door;

player_control u_player_control(
    .clk,
    .rst,
    .key(key),
    .ypos(player_ypos),
    .player_xpos(player_xpos),
    .pixel_adr(pixel_adr1),
    .rgb_pixel(current_pix),
    .direction(dir),
    .door(door)


);

player_control_y u_player_control_y(
    .clk,
    .rst,
    .key(key),
    .xpos(player_xpos),
    .player_ypos(player_ypos),
    .pixel_adr(pixel_adr1y),
    .rgb_pixel(current_pix_y)
);

draw_player u_draw_player(
    .clk,
    .rst,
    .in(vga_game3.in),
    .out(vga_game4.out),
    .pixel_adr(pixel_adr2),
    .player_xpos(player_xpos2),
    .player_ypos(player_ypos),
    .rgb_pixel(rgb_pixel2),
    .rgb_pixel_left(rgb_pixel2l),
    .dirction(dir)

);

player_rom u_player_rom(
    .address(pixel_adr2),
    .clk,
    .rgb(rgb_pixel2),
    .rgb2(rgb_pixel2l)


);

game_content_top u_game_content_top(
.clk,
.rst,
.key(key),
.in(vga_game4.in),
.out(out),
.current_pix(current_pix),
.door(door)

);



endmodule


