/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   player_control_y 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps

module player_control_y (
    input  logic clk,
    input  logic rst,
    //input  logic select,
    input  logic [3:0] key,
    input logic [10:0] xpos,
    output logic [8:0] player_ypos,
    input logic  [3:0] rgb_pixel,
    output logic [15:0] pixel_adr
);



import vga_pkg::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------

localparam TIM_VAL = 2000000;
//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------
logic [15:0] adress_nxt;
logic [31:0] timer, timer_next;
logic  [8:0] player_ypos_next;
logic [3:0] currentjump, currentjump_nxt;



enum logic [1:0] {
    IDLE = 2'b00, 
    UP = 2'b01,
    DOWN = 2'b11,
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
            if(key==key_W)
                state_nxt = UP; 
            else
                state_nxt = DOWN; 
        end
        UP: begin
            state_nxt = TIM;
        end
        DOWN: begin
            state_nxt = TIM;
        end
        TIM: begin
            if(timer==TIM_VAL) begin
                state_nxt = IDLE; 
            end
            else begin
                state_nxt = TIM; 
            end
        end
        default: state_nxt = IDLE;
    endcase
end

//------------------------------------------------------------------------------
// output register
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
        timer <= 0;
        player_ypos <= 448;
        pixel_adr <= '0;
        currentjump <= '0;
    end
    else begin : out_reg_run_blk
        timer <= timer_next;
        player_ypos <= player_ypos_next;
        pixel_adr <= adress_nxt;
        currentjump <= currentjump_nxt;
    end
end

//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------
always_comb begin : out_comb_blk

    adress_nxt[8:0]= (xpos>>2) ;
    adress_nxt[15:9]= (player_ypos>>2) +2;
    case(state_nxt)
        IDLE: begin
            player_ypos_next=player_ypos;   
            currentjump_nxt = currentjump; 
        end
        UP: begin
            if(player_ypos>0) begin
                player_ypos_next=player_ypos -1 ;
            end
            else begin
                player_ypos_next=player_ypos; 
            end
            currentjump_nxt = 15;
        end
        DOWN: begin
            if(currentjump>8)
                currentjump_nxt = currentjump- 4'b0001;
            else
                currentjump_nxt = 0;
            if(player_ypos<448 && rgb_pixel!= 4'h0) begin
                player_ypos_next=player_ypos +2 -currentjump;
            end
            else begin 
                player_ypos_next=player_ypos -currentjump;   
            end
        end
        TIM: begin
            if(timer==TIM_VAL) begin
            player_ypos_next=player_ypos; 
            currentjump_nxt = currentjump;
            timer_next=0;
            end
            else begin
                player_ypos_next=player_ypos; 
                timer_next=timer+1;
            end
        end 
        default: begin
            timer_next = '0;
            player_ypos_next = '0;
            adress_nxt = '0;
            currentjump_nxt = '0;
           
        end
    endcase
end



endmodule
