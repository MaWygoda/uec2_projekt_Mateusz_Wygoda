/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   draw_menu_text
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 Coding style: safe with FPGA sync reset
 Description:  Menu state machine
 */
//////////////////////////////////////////////////////////////////////////////
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
//import my_function::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

logic [3:0] char_line_next;

logic [10:0] hcount_del;
logic [10:0] vcount_del;
logic vsync_del, hsync_del;
logic vblnk_del, hblnk_del;

logic [11:0] rgb_out,rgb_in1,rgb_in2,rgb_in3,rgb_in4;
logic [7:0] char_xy_next;
logic [31:0] xy;
logic [3:0] select_text_nxt;


enum logic [1:0] {
    MENU = 2'b00,
    TEXT1 = 2'b01,
    TEXT2 = 2'b11,
    TEXT3 = 2'b10
} state, state_nxt;


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

/**
 * Submodules instances
 */

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

delay u_delay3(
    .clk(clk),
    .rst(rst),
    .din(signals2delay),
    .dout(delayedsignals)
);


//------------------------------------------------------------------------------
// state sequential with synchronous reset
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : state_seq_blk
    if(rst)begin : state_seq_rst_blk
        state <= MENU;
    end
    else begin : state_seq_run_blk
        state <= state_nxt;
    end
end

//------------------------------------------------------------------------------
// next state logic
//------------------------------------------------------------------------------
always_comb begin : state_comb_blk
    case(state)
        MENU: begin
            if(key==key_2)
                state_nxt=TEXT1;
            else if(key==key_3)
                state_nxt=TEXT2;
            else if(key==key_4)
                state_nxt=TEXT3;
            else
                state_nxt=MENU;
        end
        TEXT1: begin
            if(key==key_esc)
                state_nxt=MENU;
            else
                state_nxt=TEXT1;
        end
        TEXT2: begin
            if(key==key_esc)
                state_nxt=MENU;
            else
                state_nxt=TEXT2;
        end
        TEXT3: begin
            if(key==key_esc)
                state_nxt=MENU;
            else
                state_nxt=TEXT3;
        end
        default: state_nxt = MENU;
    endcase
end

//------------------------------------------------------------------------------
// output register
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
        char_xy <= 0;
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

        state_reg_out <= '0;
        select_text <= 0;
    end
    else begin : out_reg_run_blk
        out.vcount <= vcount_del;
        out.vsync  <= vsync_del;
        out.vblnk  <= vblnk_del;
        out.hcount <= hcount_del;
        out.hsync  <= hsync_del;
        out.hblnk  <= hblnk_del;


        char_line <= char_line_next;


        out.rgb <= rgb_out;

        rgb_in1 <= in.rgb;
        rgb_in2 <= rgb_in1;
        rgb_in3 <= rgb_in2;
        rgb_in4 <= rgb_in3;

        char_xy <= char_xy_next;

        state_reg_out <= state_nxt;
        select_text <= select_text_nxt;
    end
end

//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------

function [31:0] display_text;

    input [10:0] hcount, vcount;
    input [11:0] rgb;
    input [7:0] pixels; 
    input [10:0] POS_CHAR_X, POS_CHAR_Y,TEXT_WIDTH,TEXT_HEIGHT;//,TEXT_WIDTH,TEXT_HEIGHT;
    input [11:0] COLOR, BG_COLOR;
    input [1:0] SCALE;
    
    logic [3:0] f_char_line;
    logic [11:0] f_rgb;
    begin
    
    
        if((hcount>=POS_CHAR_X+4 && hcount<=POS_CHAR_X+(TEXT_WIDTH<<SCALE)+3) && (  vcount>=POS_CHAR_Y&&  vcount<POS_CHAR_Y+(TEXT_HEIGHT<<SCALE)) ) begin
             
            if(hcount==POS_CHAR_X+(TEXT_WIDTH<<SCALE)+3)
            char_line_next =   ((vcount-(POS_CHAR_Y-1))%(16<<(SCALE)))>>SCALE ;
            else
            char_line_next = ((vcount-POS_CHAR_Y)%(16<<(SCALE)))>>SCALE ;
                
            if(pixels[  ((POS_CHAR_X+(TEXT_WIDTH<<SCALE)-hcount+3)%(8<<(SCALE)))>>SCALE   ] == 0)
            f_rgb= BG_COLOR;
            else
            f_rgb= COLOR;
    
        end
        else begin
            f_rgb= rgb; 
            char_line_next = char_line;
        end
    
        display_text [7:0]= ((hcount-POS_CHAR_X)/8)>>SCALE;
        display_text [15:8]= ((vcount-POS_CHAR_Y)/16)>>SCALE;
        display_text [19:16]= f_char_line;
        display_text [31:20]= f_rgb;
    end
    
    endfunction

always_comb begin : out_comb_blk
    case(state_nxt)
        MENU: begin
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,250,200,8*16,16*4, MENU_TEXT_COLOR,  MENU_BG_COLOR, 2);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            //char_line_next = xy [19:16];
            rgb_out = xy [31:20];

            select_text_nxt = 2'b00;
        end
        TEXT1: begin
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,230,300,8*64,16*4, TEXT1_COLOR, TEXT1_BG_COLOR,0);
            char_xy_next [5:0] = xy [5:0];
            char_xy_next [7:6] = xy [9:8];
            //char_line_next = xy [19:16];
            rgb_out = xy [31:20];

            select_text_nxt = 2'b01;
        end
        TEXT2: begin
            xy  = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,230,300,8*64,16*4,TEXT1_COLOR, TEXT1_BG_COLOR,0);
            char_xy_next [5:0] = xy [5:0];
            char_xy_next [7:6] = xy [9:8];
            //char_line_next = xy [19:16];
            rgb_out = xy [31:20];

            select_text_nxt = 2'b10;
        end
        TEXT3: begin
            xy  = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,230,300,8*64,16*4,TEXT1_COLOR, TEXT1_BG_COLOR,0);
            char_xy_next [5:0] = xy [5:0];
            char_xy_next [7:6] = xy [9:8];
            //char_line_next = xy [19:16];
            rgb_out = xy [31:20];

            select_text_nxt = 2'b11;
        end
        default: begin
            char_xy_next= '0;
            char_line_next = '0;
            rgb_out = '0;
            select_text_nxt = 2'b00;
        end
    endcase
end


endmodule

