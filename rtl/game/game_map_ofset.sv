 `timescale 1 ns / 1 ps

module game_mape_ofset (
    input  logic clk,
    input  logic rst,

    input  logic [10:0] player_pos,
    output  logic [10:0] player_pos_out,
    output  logic [7:0] map_ofset

);

import vga_pkg::*;

logic [31:0] timer, timer_next;
logic  [2:0] state_reg,state_reg_nxt;
logic [7:0] map_ofset_nxt;
logic [10:0] player_pos_out_nxt;

logic [10:0] desire_pos, desire_pos_nxt;
logic [10:0] current_pos, current_pos_nxt;

/**
 * Local variables and signals
 */

 localparam SET = 3'b000;
 localparam CHANGE = 3'b001;
 localparam TIM = 3'b010;
 
 
 /**
  * Internal logic
  */
 
 always_ff @(posedge clk) begin 
     if (rst) begin
         timer <= 0;
         player_pos_out <= 0;
         state_reg <= SET;
         map_ofset <= '0;
         desire_pos <='0;
         current_pos <= '0;
     end 
     else begin
         timer <= timer_next;
         player_pos_out <= player_pos_out_nxt;
         state_reg <= state_reg_nxt;
         map_ofset <= map_ofset_nxt;
         desire_pos <= desire_pos_nxt;
         current_pos <= current_pos_nxt;
     end
 end
 
 
 //assign adress_nxt[8:0]= 100;//(player_xpos>>1) ;
 //assign adress_nxt[15:9]= 100;//(ypos>>2 );
 
 always_comb begin  
    

    map_ofset_nxt=current_pos;
    player_pos_out_nxt=player_pos-current_pos*4;
 
     case(state_reg)
 
 

        SET:
        begin
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
            state_reg_nxt = CHANGE;

        end

        CHANGE:
        begin 
            timer_next =timer;
            desire_pos_nxt=desire_pos;
            if(current_pos<desire_pos)
                current_pos_nxt=current_pos+1;
            else if(current_pos>desire_pos)
                current_pos_nxt=current_pos-1;
            else
                current_pos_nxt=current_pos;
            state_reg_nxt = TIM;
        end

        TIM:
        begin
            desire_pos_nxt=desire_pos;
            current_pos_nxt =current_pos;
        if(timer==2000000) 
            begin
                timer_next =0;
                state_reg_nxt = SET; 
            end
            else begin

                state_reg_nxt = TIM; 
                timer_next=timer+1;
            end
        end 
       
     endcase
 
 end
 
 endmodule