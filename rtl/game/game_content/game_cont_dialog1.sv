`timescale 1 ns / 1 ps

module game_cont_dialog1 (
    input  logic clk,
    input  logic rst,
    input logic [3:0] key,

    input logic [3:0] current_pix,

    vga_if.out out,
    vga_if.in in,

    //output  logic [10:0] addr,            // {char_code[6:0], char_line[3:0]}
    input logic  [7:0] char_line_pixels,
    output  logic [7:0]  char_xy,
    output  logic [3:0]  char_line,

    input logic  [7:0] char_line_pixels2,

    output logic item,
    output logic door

//    input logic [11:0] rgb_pixel,
//   output logic [11:0] pixel_adr
);

import vga_pkg::*;
import my_function::*;

/**
 * Local variables and signals
 */

logic [3:0] char_line_next;
logic [3:0] char_line_next2;

logic [10:0] hcount_del;
logic [10:0] vcount_del;
logic vsync_del, hsync_del;
logic vblnk_del, hblnk_del;

logic [11:0] rgb_out,rgb_in1,rgb_in2,rgb_in3,rgb_in4;
logic [7:0] char_xy_next;
logic [31:0] xy;

logic item_nxt,door_nxt;



/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        char_xy <= 0;
        char_line_next2 <= 0;

        char_line <=0;

        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;

        rgb_in4 <= '0;
        rgb_in3 <= '0;
        rgb_in2 <= '0;
        rgb_in1 <= '0;

        item <= '0;
        door <= '0;



    end else begin

        out.vcount <= vcount_del;
        out.vsync  <= vsync_del;
        out.vblnk  <= vblnk_del;
        out.hcount <= hcount_del;
        out.hsync  <= hsync_del;
        out.hblnk  <= hblnk_del; 


        char_line <= char_line_next2;
        char_line_next2 <=char_line_next;

        out.rgb <= rgb_out;
        
        rgb_in1 <= in.rgb;
        rgb_in2 <= rgb_in1;
        rgb_in3 <= rgb_in2;
        rgb_in4 <= rgb_in3;

        char_xy <= char_xy_next;

        item <= item_nxt;
        door <= door_nxt;


    end
end


delay u_delay(
    .clk(clk),
    .rst(rst),
    .din(in.vcount),
    .dout(vcount_del)
);

delay u_delay2(
    .clk(clk),
    .rst(rst),
    .din(in.hcount),
    .dout(hcount_del)
);

wire [10:0] signals2delay;
wire [10:0] delayedsignals;

assign signals2delay[0] = in.hsync;
assign hsync_del = delayedsignals[0];
assign signals2delay[1] = in.hblnk;
assign hblnk_del = delayedsignals[1];
assign signals2delay[2] = in.vsync;
assign vsync_del = delayedsignals[2];
assign signals2delay[3] = in.vblnk;
assign vblnk_del = delayedsignals[3];

delay u_delay3(
    .clk(clk),
    .rst(rst),
    .din(signals2delay),
    .dout(delayedsignals)
);



always_comb begin 


case(current_pix)

4'h2:  //kobieta

        begin
            
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,400,600,8*16,16*4, MENU_TEXT_COLOR,  COLOR_YELLOW, 0);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            char_line_next [3:0]= xy [19:16];
            rgb_out = xy [31:20];
            item_nxt = item;
            door_nxt = door;

        end

4'h3:   //czarodziej

        begin           
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels2,400,600,8*16,16*4, MENU_TEXT_COLOR,  COLOR_YELLOW, 0);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            char_line_next [3:0]= xy [19:16];
            rgb_out = xy [31:20];

            door_nxt = door;

            if(key==key_1)
                item_nxt = 1'b1;
            else
                item_nxt = item;
        end

4'h4: //dzrwi 

    begin        
        xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,400,600,8*16,16*4, MENU_TEXT_COLOR,  COLOR_YELLOW, 0);
        char_xy_next [3:0] = xy [3:0];
        char_xy_next [7:4] = xy [11:8];
        char_line_next [3:0]= xy [19:16];
        rgb_out = xy [31:20];

        item_nxt = item;

        if(item==1'b1 && key==key_1)
            door_nxt = 1'b1;
        else
            door_nxt = door;
    end


default:

    begin
            
        xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,400,600,8*16,16*4, COLOR_YELLOW,  COLOR_YELLOW, 0);
        char_xy_next [3:0] = xy [3:0];
        char_xy_next [7:4] = xy [11:8];
        char_line_next [3:0]= xy [19:16];
        rgb_out = xy [31:20];

        item_nxt = item;
        door_nxt = door;

    end


endcase

end


endmodule
