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

/**
 * Local variables and signals
 */
logic [3:0]  hp_numb_nxt;
logic  [2:0] state_reg,state_reg_nxt;
logic [35:0] timer, timer_nxt;

localparam IDLE = 3'b000;
localparam TIM = 3'b001;
localparam DEC = 3'b010;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        hp_numb<=9;
        state_reg<=IDLE;
        timer <= 0;

    end else begin
        hp_numb<=hp_numb_nxt;
        state_reg<=state_reg_nxt;
        timer <= timer_nxt;

    end
end

always_comb begin  


    case(state_reg)

        IDLE:
            begin
                hp_numb_nxt=hp_numb;
                timer_nxt=timer;
                if(current_pix==4'h5)
                    state_reg_nxt = DEC;
                else 
                    state_reg_nxt = IDLE; 
            end

        DEC:
            begin
            state_reg_nxt = TIM;    
            timer_nxt=timer;
            if(hp_numb>0)
            hp_numb_nxt=hp_numb-1;
            else
            hp_numb_nxt=0;   

            end

        TIM:
            begin
                hp_numb_nxt=hp_numb;
                if(timer==50000000) begin
                    state_reg_nxt = IDLE; 
                    timer_nxt=0;
                end
                else begin
                    state_reg_nxt = TIM; 
                    timer_nxt=timer+1;
                end
            end 
        endcase



end

endmodule

