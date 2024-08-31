/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   game_mape_ofset 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps

module game_mape_ofset (
    input  logic clk,
    input  logic rst,

    input  logic [10:0] player_pos,
    output  logic [10:0] player_pos_out,
    output  logic [7:0] map_ofset

);

import vga_pkg::*;


//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------

localparam TIM_VAL = 2000000;

//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

logic [31:0] timer, timer_next;
logic [7:0] map_ofset_nxt;
logic [10:0] player_pos_out_nxt;
logic [10:0] desire_pos, desire_pos_nxt;
logic [10:0] current_pos, current_pos_nxt;


 enum logic [1:0] {
    SET = 2'b00, 
    CHANGE = 2'b01,
    TIM = 2'b11
} state, state_nxt;
 


//------------------------------------------------------------------------------
// state sequential with synchronous reset
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : state_seq_blk
    if(rst)begin : state_seq_rst_blk
        state <= SET;
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
        SET: begin
            state_nxt = CHANGE;
        end
        CHANGE: begin
            state_nxt = TIM;
        end
        TIM: begin
            if(timer==TIM_VAL) 
            begin
                state_nxt = SET; 
            end
            else begin
                state_nxt = TIM; 
            end
        end
        default: state_nxt = SET;
    endcase
end


//------------------------------------------------------------------------------
// output register
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
        player_pos_out <= '0;
        map_ofset <= '0;
        timer <= 0;
        desire_pos <='0;
        current_pos <= '0;
    end
    else begin : out_reg_run_blk
        map_ofset <= map_ofset_nxt;
        player_pos_out <= player_pos_out_nxt;
        timer <= timer_next;
        desire_pos <= desire_pos_nxt;
        current_pos <= current_pos_nxt;
    end
end


//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------
always_comb begin : out_comb_blk

    map_ofset_nxt= current_pos[7:0];
    player_pos_out_nxt= player_pos-current_pos*4;

    case(state_nxt)
        SET: begin
            timer_next =timer;
            current_pos_nxt =current_pos;
            if(player_pos>512 && player_pos<800)
                desire_pos_nxt=64;
            else if (player_pos>800 && player_pos<1200)
                desire_pos_nxt=128;
            else if (player_pos>1200 && player_pos<1600)
                desire_pos_nxt=192;
            else if (player_pos>1600)
                desire_pos_nxt=250;   
            else if(player_pos<400)
                desire_pos_nxt=0;
            else
                desire_pos_nxt=desire_pos;
        end
        CHANGE: begin
            timer_next =timer;
            desire_pos_nxt=desire_pos;
            if(current_pos<desire_pos)
                current_pos_nxt=current_pos+1;
            else if(current_pos>desire_pos)
                current_pos_nxt=current_pos-1;
            else
                current_pos_nxt=current_pos;
        end
        TIM: begin
            desire_pos_nxt=desire_pos;
            current_pos_nxt =current_pos;
            if(timer==TIM_VAL) 
                timer_next ='0;
            else
                timer_next=timer+1;
        end
        default: begin
            map_ofset_nxt ='0;
            player_pos_out_nxt='0;
            timer_next='0;
            desire_pos_nxt='0;
            current_pos_nxt='0;
        end
    endcase
end
 
 endmodule
