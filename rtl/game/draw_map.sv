`timescale 1 ns / 1 ps

module draw_map (
    input  logic clk,
    input  logic rst,
    input logic  [7:0] map_ofset,

    vga_if.out out,
    vga_if.in in,

    input logic  [11:0] rgb_pixel,
    output logic [13:0] pixel_adr
);

import vga_pkg::*;


/**
 * Local variables and signals
 */


logic [15:0] adress_nxt;


logic [10:0] hcount_del;
logic [10:0] vcount_del;
logic vsync_del, hsync_del;
logic vblnk_del, hblnk_del;

logic [10:0] hcount_del2;
logic [10:0] vcount_del2;
logic vsync_del2, hsync_del2;
logic vblnk_del2, hblnk_del2;


logic [11:0] rgb_out;


logic [11:0] rgb_in1;
logic [11:0] rgb_in2;

/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
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

localparam xpos=0;
localparam ypos=0;


always_comb begin 

adress_nxt[7:0]=(in.hcount>>2)-(xpos>>2) ;
adress_nxt[13:8]=(in.vcount>>2)-(ypos>>2);

    if(in.hcount<1024) begin
     if((in.hcount>=xpos+2 && in.hcount<=xpos+256*4+1) && (  in.vcount>=ypos &&  in.vcount<=ypos+64*4-1) ) begin 
            rgb_out=rgb_pixel;


     end
     else begin
        rgb_out= rgb_in2;

    end
end
    else begin
        rgb_out= rgb_in2;
    end

end

//

endmodule
