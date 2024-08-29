/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_menu 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 1 ps

module top_menu (
    input  logic clk,
    input  logic rst,
    input  logic [3:0] key,
    output logic [3:0] menu_state,
    vga_if.out out,
    vga_if.in in
);

/**
 * Local variables and signals
 */

vga_if vga_menu1();

wire [3:0] charline;
wire [6:0] charcode1;
wire [6:0] charcode2;
wire [6:0] charcode3;
wire [6:0] charcode4;
wire [1:0] selecttext;
wire [10:0] addr;
wire [7:0] char_line_pixels;
wire [7:0] char_xy;

/**
 * Submodules instances
 */

draw_menu u_draw_menu (
    .clk,
    .rst,
    .in(in),
    .out(vga_menu1.out)
    
);


draw_menu_text u_draw_menu_text(
    .clk,
    .rst,
    //.ypos(yposition_ctl),
    //.xpos(xposition_ctl),
    .in(vga_menu1.in),
    .out(out),
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

endmodule
