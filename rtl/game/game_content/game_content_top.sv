`timescale 1 ns / 1 ps

module game_content_top (
    input  logic clk,
    input  logic rst,
    input  logic [3:0] key,
    vga_if.out out,
    vga_if.in in, 
    input  logic [3:0] current_pix,
    output logic door,
    output logic item2

);


wire [10:0] addr,addr1,addr2,addr3,addr4,addr5,addr6;
wire [7:0] char_xy;
wire [7:0] char_line_pixels1,char_line_pixels2,char_line_pixels3,char_line_pixels4,char_line_pixels5,char_line_pixels6;

/**
 * Submodules instances
 */

game_cont_dialog1 u_game_cont_dialog1(
    
    .clk,
    .rst,
    .key(key),
    .in,
    .out,
    .char_line_pixels1(char_line_pixels1),
    .char_line_pixels2(char_line_pixels2),
    .char_line_pixels3(char_line_pixels3),
    .char_line_pixels4(char_line_pixels4),
    .char_line_pixels5(char_line_pixels5),
    .char_line_pixels6(char_line_pixels6),
    .char_line(addr[3:0]),
    .char_xy(char_xy),

    .current_pix(current_pix),
    .door(door),
    .item2(item2)

);

assign addr1[3:0] = addr[3:0];
assign addr2[3:0] = addr[3:0];
assign addr3[3:0] = addr[3:0];
assign addr4[3:0] = addr[3:0];
assign addr5[3:0] = addr[3:0];
assign addr6[3:0] = addr[3:0];

game_cont_txt1 u_game_cont_txt1(
    .clk,
    .rst,
    .char_xy(char_xy),
    .char_code(addr1[10:4])


);

game_cont_txt2 u_game_cont_txt2(
    .clk,
    .rst,
    .char_xy(char_xy),
    .char_code(addr2[10:4])


);

game_cont_txt3 u_game_cont_txt3(
    .clk,
    .rst,
    .char_xy(char_xy),
    .char_code(addr3[10:4])


);

game_cont_txt4 u_game_cont_txt4(
    .clk,
    .rst,
    .char_xy(char_xy),
    .char_code(addr4[10:4])


);

game_cont_txt5 u_game_cont_txt5(
    .clk,
    .rst,
    .char_xy(char_xy),
    .char_code(addr5[10:4])


);

game_cont_txt6 u_game_cont_txt6(
    .clk,
    .rst,
    .char_xy(char_xy),
    .char_code(addr6[10:4])


);

font_rom u_font_rom(
    .clk,
    .addr(addr1),
    .char_line_pixels(char_line_pixels1)
);

font_rom u_font_rom2(
    .clk,
    .addr(addr2),
    .char_line_pixels(char_line_pixels2)
);
font_rom u_font_rom3(
    .clk,
    .addr(addr3),
    .char_line_pixels(char_line_pixels3)
);

font_rom u_font_rom4(
    .clk,
    .addr(addr4),
    .char_line_pixels(char_line_pixels4)
);
font_rom u_font_rom5(
    .clk,
    .addr(addr5),
    .char_line_pixels(char_line_pixels5)
);
font_rom u_font_rom6(
    .clk,
    .addr(addr6),
    .char_line_pixels(char_line_pixels6)
);


endmodule

