`timescale 1 ns / 1 ps

module game_content_top (
    input  logic clk,
    input  logic rst,
    input  logic [3:0] key,

    vga_if.out out,
    vga_if.in in, 
    input  logic [11:0] current_pix,
    output door

);


wire [10:0] addr,addr2;
wire [7:0] char_xy;
wire [7:0] char_line_pixels,char_line_pixels2;

game_cont_dialog1 u_game_cont_dialog1(
    
    .clk,
    .rst,
    .key(key),
    .in,
    .out,
    .char_line_pixels(char_line_pixels),
    .char_line_pixels2(char_line_pixels2),
    .char_line(addr[3:0]),
    .char_xy(char_xy),

    .current_pix(current_pix),
    .door(door)

);

assign addr2[3:0] = addr[3:0];

game_cont_txt1 u_game_cont_txt1(
    .clk,
    .char_xy(char_xy),
    .char_code(addr[10:4])


);

game_cont_txt2 u_game_cont_txt2(
    .clk,
    .char_xy(char_xy),
    .char_code(addr2[10:4])


);

font_rom u_font_rom(
    .clk,
    .addr(addr),
    .char_line_pixels(char_line_pixels)
);

font_rom u_font_rom2(
    .clk,
    .addr(addr2),
    .char_line_pixels(char_line_pixels2)
);


endmodule

