/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   draw_game_bg 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps


module draw_game_bg (
    input  logic clk,
    input  logic rst,

    vga_if.out out,
    vga_if.in in
);

import vga_pkg::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

logic [11:0] rgb_nxt;


//------------------------------------------------------------------------------
// output register with sync reset
//------------------------------------------------------------------------------

always_ff @(posedge clk) begin 
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;
    end else begin
        out.vcount <= in.vcount;
        out.vsync  <= in.vsync;
        out.vblnk  <= in.vblnk;
        out.hcount <= in.hcount;
        out.hsync  <= in.hsync;
        out.hblnk  <= in.hblnk;
        out.rgb    <= rgb_nxt;
    end
end

//------------------------------------------------------------------------------
// logic
//------------------------------------------------------------------------------

always_comb begin 

    if (in.rgb==12'h0_0_0) begin
        if (in.vblnk || in.hblnk) begin             
            rgb_nxt = 12'h0_0_0;                    
        end 
            else                                    
            rgb_nxt = MENU_BG_COLOR;     
    end        
    else
        rgb_nxt = 12'h0_0_0;     
end

endmodule

