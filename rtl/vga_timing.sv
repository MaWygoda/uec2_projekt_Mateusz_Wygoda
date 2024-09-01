//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   vga_timing
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-09-01
 Coding style: safe, with FPGA sync reset
 Description:  Template for simple module with registered outputs
 */
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module vga_timing (
    input  logic clk,
    input  logic rst,
    vga_if.out out
);

import vga_pkg::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

logic [10:0] hcount_reg, hcount_next;
logic [10:0] vcount_reg, vcount_next;
logic vsync_reg, vsync_next, hsync_reg, hsync_next;
logic vblnk_reg, vblnk_next, hblnk_reg, hblnk_next;

//------------------------------------------------------------------------------
// output register with sync reset
//------------------------------------------------------------------------------


always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
            hcount_reg <=0;
            vcount_reg <=0;
            vsync_reg <=0;
            hsync_reg <=0;
            vblnk_reg <=0;
            hblnk_reg <=0;
            out.rgb <= 12'h0_0_0;  
        end
    else begin : out_reg_run_blk
            hcount_reg <=hcount_next;
            vcount_reg <=vcount_next;
            vsync_reg <=vsync_next;
            hsync_reg <=hsync_next;
            vblnk_reg <=vblnk_next;
            hblnk_reg <=hblnk_next;
            out.rgb <= 12'h0_0_0;
        end

end

//------------------------------------------------------------------------------
// logic
//------------------------------------------------------------------------------
        
always_comb begin
    if( hcount_reg==1343)
        hcount_next=0;     
    else
        hcount_next=hcount_reg+1;
end

always_comb begin  
    if(hcount_reg==1343)
        if( vcount_reg==805) 
            vcount_next=0;
        else 
        vcount_next=vcount_reg+1;
    else
        vcount_next=vcount_reg;
end

assign hsync_next=((hcount_next>=1048) && (hcount_next<=1159));
assign vsync_next=((vcount_next>=768) && (vcount_next<=773));
assign hblnk_next=((hcount_next>=HOR_PIXELS));
assign vblnk_next=((vcount_next>=VER_PIXELS));


assign out.hcount = hcount_reg;
assign out.vcount = vcount_reg;
assign out.hsync = hsync_reg;
assign out.vsync = vsync_reg;
assign out.hblnk = hblnk_reg;
assign out.vblnk = vblnk_reg;

endmodule



