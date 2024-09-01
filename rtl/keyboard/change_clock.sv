//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   template_simple
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-09-01
 Coding style: safe, with FPGA sync reset
 Description:  Template for simple module with registered outputs
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps
 module change_clock
    (
        input  wire  clk, 
        input  wire  rst, 
        input  wire  rx_done_tick,
        input wire [7:0] dout,
        output logic rx_done_tick_out,
        output logic [7:0] dout_out

    );
    
    //------------------------------------------------------------------------------
    // local parameters
    //------------------------------------------------------------------------------
    
    //------------------------------------------------------------------------------
    // local variables
    //------------------------------------------------------------------------------
   // logic [7:0] dout_nxt;
   // logic rx_done_tick_nxt;
    //------------------------------------------------------------------------------
    // output register with sync reset
    //------------------------------------------------------------------------------

    always_ff @(posedge clk) begin : out_reg_blk
        if(rst) begin : out_reg_rst_blk
            rx_done_tick_out <= 1'b0;
            dout_out <= '0;
        end
        else begin : out_reg_run_blk
            rx_done_tick_out <= rx_done_tick;
            dout_out <= dout;
        end
    end
    //------------------------------------------------------------------------------
    // logic
    //------------------------------------------------------------------------------

    
    endmodule
    