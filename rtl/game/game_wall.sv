/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   draw_wall
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps


module game_wall(
    input  logic clk,
    input  logic rst,
    input logic door_in,
    vga_if.out out,
    vga_if.in in,
    output logic [12:0] pixel_adr,
    input logic  [11:0] rgb_pixel,
    input logic [7:0] map_ofs

);


//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------

localparam XPOS= 1790;
localparam YPOS= 0;

//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

logic [12:0] adress_nxt;
logic [10:0] hcount_del;
logic [10:0] vcount_del;
logic vsync_del, hsync_del;
logic vblnk_del, hblnk_del;
logic [10:0] hcount_del2;
logic [10:0] vcount_del2;
logic vsync_del2, hsync_del2;
logic vblnk_del2, hblnk_del2;
logic [11:0] rgb_out,rgb_in1,rgb_in2;

//------------------------------------------------------------------------------
// output register with sync reset
//------------------------------------------------------------------------------

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


//------------------------------------------------------------------------------
// logic
//------------------------------------------------------------------------------

always_comb begin : out_comb_blk 

    adress_nxt[5:0]=(in.hcount>>2)-(XPOS>>2);
    adress_nxt[12:6]=(in.vcount>>2)-(YPOS>>2);

    if(in.hcount<1024) begin
        if((in.hcount+map_ofs*4>=XPOS+2 && in.hcount+map_ofs*4<=XPOS+64*4+1) && (  in.vcount>=YPOS &&  in.vcount<=YPOS+128*4-1) ) begin 
            if(door_in==1'b0) 
                rgb_out=rgb_pixel;
            else
                rgb_out= rgb_in2;         
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
