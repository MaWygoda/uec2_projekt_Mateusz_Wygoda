`timescale 1 ns / 1 ps

module game_cont_dialog1 (
    input  logic clk,
    input  logic rst,
    input logic [3:0] key,

    input logic [3:0] current_pix,

    vga_if.out out,
    vga_if.in in,

    //output  logic [10:0] addr,            // {char_code[6:0], char_line[3:0]}
    
    output  logic [7:0]  char_xy,
    output  logic [3:0]  char_line,
    input logic  [7:0] char_line_pixels1,
    input logic  [7:0] char_line_pixels2,
    input logic  [7:0] char_line_pixels3,
    input logic  [7:0] char_line_pixels4,
    input logic  [7:0] char_line_pixels5,

    output logic item,
    output logic item2,
    output logic door

//    input logic [11:0] rgb_pixel,
//   output logic [11:0] pixel_adr
);

import vga_pkg::*;
import my_function::*;


//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


 //------------------------------------------------------------------------------
 // local variables
 //------------------------------------------------------------------------------

 
 enum logic [2:0] {
     IDLE = 3'b000, // idle state
     D1 = 3'b001,
     D2 = 3'b011,
     DOR = 3'b010,
     ITE = 3'b110
 } state, state_nxt;

logic [3:0] char_line_next;
logic [3:0] char_line_next2;

logic [10:0] hcount_del;
logic [10:0] vcount_del;
logic vsync_del, hsync_del;
logic vblnk_del, hblnk_del;

logic [11:0] rgb_out,rgb_in1,rgb_in2,rgb_in3,rgb_in4;
logic [7:0] char_xy_next;
logic [31:0] xy;

logic item_nxt,door_nxt, item2_nxt;




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

delay u_delay3(
    .clk(clk),
    .rst(rst),
    .din(signals2delay),
    .dout(delayedsignals)
);


//------------------------------------------------------------------------------
// state sequential with synchronous reset
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : state_seq_blk
    if(rst)begin : state_seq_rst_blk
        state <= IDLE;
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
        IDLE: begin
            case(current_pix)
                4'h2: state_nxt=D1;
                4'h3: state_nxt=D2;
                4'h4: state_nxt=DOR;
                4'h6: state_nxt=ITE;
                default: state_nxt = IDLE;
            endcase
        end
        D1: begin
            if(current_pix==4'h2) 
                state_nxt=D1;
            else
                state_nxt = IDLE;
        end
        D2: begin
            if(current_pix==4'h3) 
                state_nxt=D2;
            else
                state_nxt = IDLE;
        end
        DOR: begin
            if(current_pix==4'h4) 
                state_nxt=DOR;
            else
                state_nxt = IDLE;
        end
        ITE: begin
            if(current_pix==4'h6) 
                state_nxt=ITE;
            else
                state_nxt = IDLE;

        end
        default: state_nxt = IDLE;
    endcase
end

//------------------------------------------------------------------------------
// output register
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
        char_xy <= 0;
        char_line <=0;
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

        item <= '0;
        door <= '0;
        item2 <= '0;
    end
    else begin : out_reg_run_blk
        out.vcount <= vcount_del;
        out.vsync  <= vsync_del;
        out.vblnk  <= vblnk_del;
        out.hcount <= hcount_del;
        out.hsync  <= hsync_del;
        out.hblnk  <= hblnk_del; 

        char_line <=char_line_next;
        out.rgb <= rgb_out;     
        rgb_in1 <= in.rgb;
        rgb_in2 <= rgb_in1;
        rgb_in3 <= rgb_in2;
        rgb_in4 <= rgb_in3;
        char_xy <= char_xy_next;

        item <= item_nxt;
        door <= door_nxt;
        item2 <= item2_nxt;
    end
end


/**
 * Internal logic
 */

//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------
 always_comb begin : out_comb_blk
    case(state_nxt)
        IDLE: begin
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels1,400,600,8*16,16*4, COLOR_YELLOW,  COLOR_YELLOW, 0);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            char_line_next [3:0]= xy [19:16];
            rgb_out = xy [31:20];
            item_nxt = item;
            door_nxt = door;
            item2_nxt = item2_nxt;
        end
        D1: begin
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels2,400,600,8*16,16*4, MENU_TEXT_COLOR,  COLOR_YELLOW, 0);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            char_line_next [3:0]= xy [19:16];
            rgb_out = xy [31:20];
            item_nxt = item;
            door_nxt = door;
            item2_nxt = item2_nxt;
        end
        D2: begin
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels3,400,600,8*16,16*4, MENU_TEXT_COLOR,  COLOR_YELLOW, 0);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            char_line_next [3:0]= xy [19:16];
            rgb_out = xy [31:20];

            door_nxt = door;
            item2_nxt = item2_nxt;

            if(key==key_1)
                item_nxt = 1'b1;
            else
                item_nxt = item;
        end
        DOR: begin
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels4,400,600,8*16,16*4, MENU_TEXT_COLOR,  COLOR_YELLOW, 0);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            char_line_next [3:0]= xy [19:16];
            rgb_out = xy [31:20];
    
            item_nxt = item;
            item2_nxt = item2_nxt;
    
            if(item==1'b1 && key==key_1)
                door_nxt = 1'b1;
            else
                door_nxt = door;
        end
        ITE: begin
            xy = display_text(in.hcount,in.vcount,rgb_in4,char_line_pixels5,400,600,8*16,16*4, MENU_TEXT_COLOR,  COLOR_YELLOW, 0);
            char_xy_next [3:0] = xy [3:0];
            char_xy_next [7:4] = xy [11:8];
            char_line_next [3:0]= xy [19:16];
            rgb_out = xy [31:20];
    
            item_nxt = item;
            door_nxt = door;

            if(item==1'b1 && key==key_1)
                item2_nxt = 1'b1;
            else
                item2_nxt = item2_nxt;
        

        end
        default: begin
            item_nxt = '0;
            door_nxt = '0;
            rgb_out = '0;
            char_xy_next = '0;
            char_line_next = '0;
            item2_nxt = '0;
        end
    endcase
end

endmodule

