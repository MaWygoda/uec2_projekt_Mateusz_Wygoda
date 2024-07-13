`timescale 1 ns / 1 ps

module control(
    input  logic clk,
    input  logic rst,
    input logic [3:0] menu_state,
    input logic [3:0] key,
    output logic [3:0] key_menu,
    vga_if.out out,
    vga_if.in in_m,
    vga_if.in in_g
);

import vga_pkg::*;

/**
 * Local variables and signals
 */
logic [11:0] rgb_nxt;
logic [10:0] hcount_next;
logic [10:0] vcount_next;
logic vsync_next, hsync_next;
logic vblnk_next, hblnk_next;

logic state_reg, state_reg_next;
logic [3:0] key_menu_next;

localparam  
        game= 1'b1,
        menu= 1'b0;
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

        state_reg <= menu;
        key_menu <= '0;

    end else begin
        out.vcount <= vcount_next;
        out.vsync  <= vsync_next;
        out.vblnk  <= vblnk_next;
        out.hcount <= hcount_next;
        out.hsync  <= hsync_next;
        out.hblnk  <= hblnk_next;
        out.rgb    <= rgb_nxt;

        state_reg <= state_reg_next;
        key_menu <= key_menu_next;

    end
end

always_comb begin  
  
    case(state_reg)

    menu:
        begin
            vcount_next = in_m.vcount;
            vsync_next = in_m.vsync;
            vblnk_next = in_m.vblnk;
            hcount_next = in_m.hcount;
            hsync_next = in_m.hsync;
            hblnk_next = in_m.hblnk;
            rgb_nxt = in_m.rgb;

            if(key==key_1 && menu_state==2'b00) 
                state_reg_next=game;
            else begin
                state_reg_next=state_reg;   
                key_menu_next=key;       
            end
        end
    game:
        begin
            vcount_next = in_g.vcount;
            vsync_next = in_g.vsync;
            vblnk_next = in_g.vblnk;
            hcount_next = in_g.hcount;
            hsync_next = in_g.hsync;
            hblnk_next = in_g.hblnk;
            rgb_nxt = in_g.rgb;

            if(key==key_esc)
                state_reg_next=menu;
            else begin
                state_reg_next=state_reg;
                key_menu_next=key_esc;
            end
        end 

    endcase

end

endmodule

