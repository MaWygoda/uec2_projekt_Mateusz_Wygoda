/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   control 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
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

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// local variables  and signals
//------------------------------------------------------------------------------
logic [11:0] rgb_nxt;
logic [10:0] hcount_next;
logic [10:0] vcount_next;
logic vsync_next, hsync_next;
logic vblnk_next, hblnk_next;

logic [3:0] key_menu_next;

enum logic {
    game= 1'b0,
    menu = 1'b1
        
} state, state_nxt;


//------------------------------------------------------------------------------
// state sequential with synchronous reset
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : state_seq_blk
    if(rst)begin : state_seq_rst_blk
        state <= menu;
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
        menu:
        begin 
            if(key==key_1 && menu_state==2'b00) 
                state_nxt=game;
            else begin
                state_nxt=state;   
                //key_menu_next=key;       
            end
        end
        game:
        begin
            if(key==key_esc)
                state_nxt=menu;
            else begin
                state_nxt=state;
                //key_menu_next=key_esc;
            end
        end
        default: state_nxt = menu;
    endcase
end
//------------------------------------------------------------------------------
// output register
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;
        key_menu <= '0;
    end
    else begin : out_reg_run_blk
        out.vcount <= vcount_next;
        out.vsync  <= vsync_next;
        out.vblnk  <= vblnk_next;
        out.hcount <= hcount_next;
        out.hsync  <= hsync_next;
        out.hblnk  <= hblnk_next;
        out.rgb    <= rgb_nxt;
        key_menu <= key_menu_next;
    end
end
//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------
always_comb begin : out_comb_blk
    case(state_nxt)
        menu:
        begin 
            vcount_next = in_m.vcount;
            vsync_next = in_m.vsync;
            vblnk_next = in_m.vblnk;
            hcount_next = in_m.hcount;
            hsync_next = in_m.hsync;
            hblnk_next = in_m.hblnk;
            rgb_nxt = in_m.rgb;
            key_menu_next=key; 

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
            key_menu_next=key_esc;
        end
        default: 
        begin
            vcount_next = in_m.vcount;
            vsync_next = in_m.vsync;
            vblnk_next = in_m.vblnk;
            hcount_next = in_m.hcount;
            hsync_next = in_m.hsync;
            hblnk_next = in_m.hblnk;
            rgb_nxt = in_m.rgb;
            key_menu_next=key;
        end
    endcase
end




endmodule

