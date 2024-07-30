
`timescale 1 ns / 1 ps

module draw_menu_text (
    input  logic clk,
    input  logic rst,
    input  logic [3:0] key,

    vga_if.out out,
    vga_if.in in,

    //output  logic [10:0] addr,            // {char_code[6:0], char_line[3:0]}
    input logic  [7:0] char_line_pixels,
    output  logic [7:0]  char_xy,
    output  logic [3:0]  char_line,   
    output logic [1:0] select_text,
    output logic [3:0] state_reg_out



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

logic [1:0] state_reg, state_reg_next;



localparam  MENU=2'b00,
            TEXT1=2'b01,
            TEXT2=2'b10,
            TEXT3=2'b11;

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

        state_reg <= MENU;
        state_reg_out <=MENU;

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


        state_reg <= state_reg_next;
        state_reg_out <= state_reg_next;
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


    case(state_reg)

    MENU:
        begin
            
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,200,100,8*16,16*4, MENU_TEXT_COLOR,  MENU_BG_COLOR, 1);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            char_line_next = xy [19:16];
            rgb_out = xy [31:20];

            select_text = 2'b00;
            
            //rgb_out= rgb_in3; 


            if(key==key_2)
                state_reg_next=TEXT1;
            else if(key==key_3)
                state_reg_next=TEXT2;
            else if(key==key_4)
                state_reg_next=TEXT3;     
            else
                state_reg_next=state_reg;
        end

    TEXT1:
        begin 
            
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,200,200,8*64,16*8, TEXT1_COLOR, TEXT1_BG_COLOR,0);
            char_xy_next [4:0] = xy [4:0];
            char_xy_next [7:5] = xy [10:8];
            char_line_next = xy [19:16];
            rgb_out = xy [31:20];

            select_text = 2'b01;

            if(key==key_esc)
                state_reg_next=MENU;
            else
                state_reg_next=state_reg;


        end
    TEXT2:
        begin
            xy  = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,200,200,8*64,16*8,TEXT1_COLOR, TEXT1_BG_COLOR,0);
            char_xy_next [4:0] = xy [4:0];
            char_xy_next [7:5] = xy [10:8];
            char_line_next = xy [19:16];
            rgb_out = xy [31:20];

            select_text = 2'b10;

            if(key==key_esc)
                state_reg_next=MENU;
            else
                state_reg_next=state_reg;
        end
    
    TEXT3:
        begin
            xy  = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,100,100,8*64,16*8,TEXT1_COLOR, TEXT1_BG_COLOR,0);
            char_xy_next [4:0] = xy [4:0];
            char_xy_next [7:5] = xy [10:8];
            char_line_next = xy [19:16];
            rgb_out = xy [31:20];
 
            select_text = 2'b11;
        
            if(key==key_esc)
                state_reg_next=MENU;
            else
                state_reg_next=state_reg;

        end

    endcase




end


endmodule
