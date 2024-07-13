
`timescale 1 ns / 1 ps

module draw_game_bg (
    input  logic clk,
    input  logic rst,

    vga_if.out out,
    vga_if.in in
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;

/**
 * Internal logic
 */

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

always_comb begin 
                                    
    rgb_nxt = GAME_BG_COLOR;             

end

endmodule

