/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   draw_end 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps

module game_end (
    input  logic clk,
    input  logic rst,

    vga_if.out out,
    vga_if.in in,

    //output  logic [10:0] addr,            // {char_code[6:0], char_line[3:0]}
    input logic  [7:0] char_line_pixels,
    input  logic [3:0] hp_in,
    input  logic item2,
    output  logic [7:0]  char_xy,
    //output  logic [3:0]  char_line,   
    output  logic [10:0]  addr


//    input logic [11:0] rgb_pixel,
//   output logic [11:0] pixel_adr
);

import vga_pkg::*;
import my_function::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// local variables  and signals
//------------------------------------------------------------------------------


logic [10:0] hcount_del;
logic [10:0] vcount_del;
logic vsync_del, hsync_del;
logic vblnk_del, hblnk_del;
logic [11:0] rgb_out,rgb_in1,rgb_in2,rgb_in3,rgb_in4;
logic [7:0] char_xy_next;
logic [31:0] xy;
logic [10:0]  addr_nxt;

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
// output register with sync reset
//------------------------------------------------------------------------------

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        char_xy <= 0;

        //char_line <=0;

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

        addr <= '0;

    end else begin

        out.vcount <= vcount_del;
        out.vsync  <= vsync_del;
        out.vblnk  <= vblnk_del;
        out.hcount <= hcount_del;
        out.hsync  <= hsync_del;
        out.hblnk  <= hblnk_del; 


        //char_line <= char_line_next2;
        //char_line_next2 <=char_line_next;

        out.rgb <= rgb_out;
        
        rgb_in1 <= in.rgb;
        rgb_in2 <= rgb_in1;
        rgb_in3 <= rgb_in2;
        rgb_in4 <= rgb_in3;

        char_xy <= char_xy_next;

        addr <= addr_nxt;
 

    end
end




//------------------------------------------------------------------------------
// logic
//------------------------------------------------------------------------------
always_comb begin : out_comb_blk


        if(item2==1'b1)begin
       
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,200,300,8*8,16, MENU_TEXT_COLOR,  COLOR_GREEN, 3);
           char_xy_next [3:0] = xy [3:0];
           char_xy_next [7:4] = xy [11:8];
           addr_nxt [3:0]= xy [19:16];
           rgb_out = xy [31:20];

            if(char_xy==0)
            addr_nxt [10:4] = W;
            else if(char_xy==1)
            addr_nxt [10:4] = Y;
            else if(char_xy==2)
            addr_nxt [10:4] = G;
            else if(char_xy==3)
            addr_nxt [10:4] = R;
            else if(char_xy==4)
            addr_nxt [10:4] = A;
            else if(char_xy==5)
            addr_nxt [10:4] = LL;
            else if(char_xy==6)
            addr_nxt [10:4] = E;
            else
            addr_nxt [10:4] = S;
        end
        else if (hp_in == 3'b0) begin
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels,200,300,8*9,16, MENU_TEXT_COLOR,  COLOR_RED, 3);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            addr_nxt [3:0]= xy [19:16];
            rgb_out = xy [31:20];

            if(char_xy==0)
            addr_nxt [10:4] = P;
            else if(char_xy==1)
            addr_nxt [10:4] = R;
            else if(char_xy==2)
            addr_nxt [10:4] = E;
            else if(char_xy==3)
            addr_nxt [10:4] = G;
            else if(char_xy==4)
            addr_nxt [10:4] = R;
            else if(char_xy==5)
            addr_nxt [10:4] = A;
            else if(char_xy==6)
            addr_nxt [10:4] = LL;
            else if(char_xy==7)
            addr_nxt [10:4] = E;
            else
            addr_nxt [10:4] = S;

        end
        else begin
            addr_nxt = '0;
            rgb_out = rgb_in4;
            char_xy_next  = '0;
        end



end

endmodule
