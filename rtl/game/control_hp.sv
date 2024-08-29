`timescale 1 ns / 1 ps
/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   control_hp 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps

module control_hp (
    input  logic clk,
    input  logic rst,
    input logic [3:0] key,
    input logic [3:0] current_pix,

    output  logic [3:0]  hp_numb


);

import vga_pkg::*;
import my_function::*;


//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------
localparam TIM_VAL = 50000000;
localparam HP_INIT = 9;
//------------------------------------------------------------------------------
// local variables  and signals
//------------------------------------------------------------------------------

logic [3:0]  hp_numb_nxt;
logic  [2:0] state_reg,state_reg_nxt;
logic [35:0] timer, timer_nxt;


enum logic [1:0] {
    IDLE = 2'b00,
    TIM = 2'b01,
    DEC = 2'b11
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
            if(current_pix==4'h5)
                state_nxt = DEC;
            else 
                state_nxt = IDLE;
        end
        DEC: begin 
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
        hp_numb <= 4'h9;
        timer <= '0;
    end
    else begin : out_reg_run_blk
        hp_numb <= hp_numb_nxt;
        timer <= timer_nxt;
    end
end

//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------
always_comb begin : out_comb_blk
    case(state_nxt)
        IDLE: begin
            hp_numb_nxt=hp_numb;
            timer_nxt=timer;
        end
        DEC: begin 
            timer_nxt=timer;
            if(hp_numb>0)
                hp_numb_nxt=hp_numb-1;
            else
                hp_numb_nxt=0; 
        end
        TIM: begin 
            hp_numb_nxt=hp_numb;
            if(timer==TIM_VAL) begin
                timer_nxt=0;
            end
            else begin
                timer_nxt=timer+1;
            end

        end
        default: begin
            hp_numb_nxt= '0;
            timer_nxt= '0;
        end
    endcase
end



endmodule

