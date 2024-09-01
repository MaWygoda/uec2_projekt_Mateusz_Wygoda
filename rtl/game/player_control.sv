/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   player_control 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps

module player_control (
    input  logic clk,
    input  logic rst,
    input  logic [3:0] key,
    input logic [9:0] ypos,
    output logic [10:0] player_xpos,
    input logic  [3:0] rgb_pixel,
    output logic [15:0] pixel_adr,
    output logic direction,
    input logic door
);


import vga_pkg::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------
localparam TIM_VAL = 500000; 

//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------
logic [15:0] adress_nxt;
/**
 * Local variables and signals
 */

logic [31:0] timer, timer_next;
logic  [10:0] player_xpos_next;
logic direction_nxt;


enum logic [1:0] {
    IDLE = 2'b00, 
    RIGHT = 2'b01,
    LEFT = 2'b11,
    TIM = 2'b10
} state, state_nxt;



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
            if(key==key_D)
                state_nxt = RIGHT; 
            else if(key==key_A)
                state_nxt = LEFT; 
            else
                state_nxt = IDLE; 
        end
        RIGHT: begin
            state_nxt = TIM;
        end
        LEFT: begin
            state_nxt = TIM;
        end
        TIM: begin
            if(timer==TIM_VAL)
                state_nxt = IDLE; 
            else
            state_nxt = TIM; 
        end
        default: state_nxt = IDLE;
    endcase
end

//------------------------------------------------------------------------------
// output register
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
        timer <= '0;
        player_xpos <= '0;
        pixel_adr <= '0;
        direction <= 1'b1;
    end
    else begin : out_reg_run_blk
        timer <= timer_next;
        player_xpos <= player_xpos_next;
        pixel_adr <= adress_nxt;
        direction <= direction_nxt;
    end
end

//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------
always_comb begin : out_comb_blk

    adress_nxt[8:0]= (player_xpos>>2) ;
    adress_nxt[15:9]= (ypos>>2 );

    case(state_nxt)
        IDLE: begin
            player_xpos_next=player_xpos; 
            direction_nxt = direction;   
            timer_next=timer;
        end
        RIGHT: begin
            timer_next=timer;
            if(   (rgb_pixel!=4'h0 && (rgb_pixel!=4'h4 || door !=1'b0) ) && player_xpos<2000) begin
                player_xpos_next=player_xpos + 1;
            end
            else if(direction == 1'b0)
                player_xpos_next=player_xpos +1;
            else begin
                player_xpos_next=player_xpos ; 
            end
            direction_nxt = 1'b1;
        end
        LEFT: begin   
            timer_next=timer;      
            if(player_xpos>0 && rgb_pixel!=4'h0 )begin
                player_xpos_next=player_xpos -1;
            end
            else if(direction == 1'b1 && player_xpos>0)
                player_xpos_next=player_xpos -1;
            else begin
                player_xpos_next=player_xpos;   
            end
            direction_nxt = 1'b0;
        end
        TIM: begin
            direction_nxt = direction; 
            if(timer==TIM_VAL) begin
            player_xpos_next=player_xpos; 
            timer_next=0;
            end
            else begin
                player_xpos_next=player_xpos; 
                timer_next=timer+1;
            end
        end
        default: begin
            timer_next = '0;
            player_xpos_next = '0;
            adress_nxt = '0;
            direction_nxt = 1'b1;
            
        end
    endcase
end

endmodule
