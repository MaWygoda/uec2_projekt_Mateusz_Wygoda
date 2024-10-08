/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   draw_player 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps

module draw_player (
    input  logic clk,
    input  logic rst,
    input logic  [10:0] player_xpos,
    input logic  [9:0] player_ypos,

    vga_if.out out,
    vga_if.in in,

    input logic   dirction,
    input logic  [11:0] rgb_pixel,
    input logic  [11:0] rgb_pixel_left,
    output logic [11:0] pixel_adr
);

import vga_pkg::*;


//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

logic [11:0] adress_nxt;
logic [10:0] hcount_del, hcount_del2;
logic [10:0] vcount_del, vcount_del2;
logic vsync_del, hsync_del;
logic vblnk_del, hblnk_del;
logic vsync_del2, hsync_del2;
logic vblnk_del2, hblnk_del2;
logic [11:0] rgb_out,rgb_in1,rgb_in2;

//------------------------------------------------------------------------------
// output register with sync reset
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;
        pixel_adr     <= '0;

        vcount_del <= '0;
        vsync_del  <= '0;
        vblnk_del  <= '0;
        hcount_del <= '0;
        hsync_del  <= '0;
        hblnk_del  <= '0; 
        vcount_del2 <= '0;
        vsync_del2  <= '0;
        vblnk_del2  <= '0;
        hcount_del2 <= '0;
        hsync_del2  <= '0;
        hblnk_del2  <= '0; 
        rgb_in2 <= '0;
        rgb_in1 <= '0;

    end else begin
   
        vcount_del <= in.vcount;
        vsync_del  <= in.vsync;
        vblnk_del  <= in.vblnk;
        hcount_del <= in.hcount;
        hsync_del  <= in.hsync;
        hblnk_del <= in.hblnk;

        vcount_del2 <= vcount_del;
        vsync_del2  <= vsync_del;
        vblnk_del2  <= vblnk_del;
        hcount_del2 <= hcount_del;
        hsync_del2  <= hsync_del;
        hblnk_del2  <= hblnk_del; 

        out.vcount <= vcount_del2;
        out.vsync  <= vsync_del2;
        out.vblnk  <= vblnk_del2;
        out.hcount <= hcount_del2;
        out.hsync  <= hsync_del2;
        out.hblnk  <= hblnk_del2; 

        pixel_adr <= adress_nxt;

        out.rgb <= rgb_out;

        rgb_in1 <= in.rgb;
        rgb_in2 <= rgb_in1;
    end
end


//------------------------------------------------------------------------------
// logic
//------------------------------------------------------------------------------
always_comb begin : out_comb_blk

    adress_nxt[5:0]=(in.hcount)-(player_xpos);
    adress_nxt[11:6]=(in.vcount)-(player_ypos);

    if(in.hcount<1024) begin
        if((in.hcount>=player_xpos+2 && in.hcount<=player_xpos+64+1) && (  in.vcount>=player_ypos &&  in.vcount<=player_ypos+64-1) ) begin 
            if(dirction==DIR_RIGHT) begin
                if(rgb_pixel==12'h0F0)
                    rgb_out=rgb_in2;
                else
                    rgb_out=rgb_pixel;
            end
            else begin
                if(rgb_pixel_left==12'h0F0)
                    rgb_out=rgb_in2;
                else
                    rgb_out=rgb_pixel_left;
            end

        end
        else begin
        rgb_out= rgb_in2;
        end
    end
    else begin
        rgb_out= rgb_in2;
    end

end


endmodule
