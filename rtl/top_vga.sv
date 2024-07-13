/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 * 
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic clk100,
    input  logic rst,
    inout ps2_clk,
    inout ps2_data,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);


/**
 * Local variables and signals
 */

vga_if vga_tim();
vga_if vga_menu();
vga_if vga_game();
vga_if vga_top();

wire [7:0] key_frame;
wire rx_done;
wire [11:0] xposition;
wire [11:0] yposition;
wire [3:0] key, key_menu;
wire [3:0] menu_state;
/**
 * Signals assignments
 */

assign vs = vga_top.vsync;
assign hs = vga_top.hsync;
assign {r,g,b} = vga_top.rgb;


/**
 * Submodules instances
 */

/*
 vga_timing
 keyboard
 menu
 ...
 */
 vga_timing u_vga_timing (
    .clk,
    .rst,
    .out(vga_tim.out)
);


Ps2Interface u_Ps2Interface (
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data), 
    .clk(clk),
    .rst,
    .write_data (1'b0),
    .rx_data(key_frame),
    .read_data(rx_done)

);



keyboard_decode u_keyboard_decode
(
    .clk, 
    .rst,
    .rx_done_tick(rx_done),
    .dout(key_frame),
    .key(key)
);

top_menu u_top_menu(
    .clk,
    .rst,
    .in(vga_tim.in),
    .out(vga_menu.out),
    .key(key_menu),
    .menu_state(menu_state)

);

top_game u_top_game(
    .clk,
    .rst,
    .in(vga_tim.in),
    .out(vga_game.out)

);

control u_control(
    .clk,
    .rst,
    .key(key),
    .in_g(vga_game.in),
    .in_m(vga_menu.in),
    .menu_state(menu_state),
    .key_menu(key_menu),
    .out(vga_top.out)
);

/*

wire [3:0] charline;
wire [6:0] charcode1;
wire [6:0] charcode2;
wire [6:0] charcode3;
wire [6:0] charcode4;
wire [1:0] selecttext;


draw_menu u_draw_menu (
    .clk,
    .rst,
    .in(vga_tim.in),
    .out(vga_menu.out)
    
);


wire [10:0] addr;
wire [7:0] char_line_pixels;

wire [7:0] char_xy;

wire[3:0] menu_state;

draw_menu_text u_draw_menu_text(
    .clk,
    .rst,
    //.ypos(yposition_ctl),
    //.xpos(xposition_ctl),
    .in(vga_menu.in),
    .out(vga_menu_text.out),
    .char_xy(char_xy),
    .char_line(charline), 
    .key(key), 
    //.addr(addr),  
    .char_line_pixels(char_line_pixels),
    //.pixel_adr(pixel_address),
    //.rgb_pixel(image_rgb)
    .select_text(selecttext),
    .state_reg_out(menu_state)
);


font_rom u_font_rom(
    .clk,
    .addr(addr),  
    .char_line_pixels(char_line_pixels)

);

menu_textmenu u_menu_textmenu(
    .clk,
    .char_xy(char_xy),           
    .char_code(charcode1)
);

menu_text1 u_menu_text1(
    .clk,
    .char_xy(char_xy),           
    .char_code(charcode2)
);

menu_text2 u_menu_text2(
    .clk,
    .char_xy(char_xy),           
    .char_code(charcode3)
);

menu_text3 u_menu_text3(
    .clk,
    .char_xy(char_xy),           
    .char_code(charcode4)
);


menu_select_text u_menu_select_text(
    .clk,
    .rst,
    .select_text(selecttext),
    .char_code_in_1(charcode1),
    .char_code_in_2(charcode2),
    .char_code_in_3(charcode3),
    .char_code_in_4(charcode4),
    .char_line_in(charline),            
    .char_code(addr[10:4]),
    .char_line_out(addr[3:0])

);
*/

endmodule
