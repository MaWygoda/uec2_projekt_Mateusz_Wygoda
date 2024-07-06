
`timescale 1 ns / 1 ps

module draw_menu (
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
    if (in.vblnk || in.hblnk) begin             
        rgb_nxt = 12'h0_0_0;                    
    end else begin                              
        if (in.vcount >= 0 && in.vcount < 16)  
            if ((in.hcount%32) > 16 )                  
                rgb_nxt = COLOR_YELLOW; 
            else
                rgb_nxt = COLOR_BLUE;                
        else if (in.vcount > (VER_PIXELS-16) && in.vcount <= VER_PIXELS - 1) 
            if ((in.hcount%32) < 16  )                  
                rgb_nxt = COLOR_YELLOW; 
            else
                rgb_nxt = COLOR_BLUE;   
                           
        else if (in.hcount  >= 0 && in.hcount < 16 )   
            if ((in.vcount%32) > 16 )                  
                rgb_nxt = COLOR_GREEN; 
            else
                rgb_nxt = COLOR_BLUE;                            
        else if (in.hcount >  (HOR_PIXELS-16) && in.hcount <= HOR_PIXELS-1 )   
            if ((in.vcount%32) < 16 )                  
                rgb_nxt = COLOR_RED; 
            else
                rgb_nxt = COLOR_BLUE;              

        else                                    
            rgb_nxt = MENU_BG_COLOR;             
    end
end

endmodule
