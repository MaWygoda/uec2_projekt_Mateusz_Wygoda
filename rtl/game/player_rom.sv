//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   player_rom
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-09.01
 Coding style: Xilinx recommended + ANSI ports
 Description:  Template for ROM module as recommended by Xilinx
 */
//////////////////////////////////////////////////////////////////////////////

module player_rom (
    input  logic clk ,
    input  logic [11:0] address,  // address = {addry[5:0], addrx[5:0]}
    output logic [11:0] rgb,
    output logic [11:0] rgb2
);




logic [11:0] rom [0:4096];
logic [11:0] rom2 [0:4096];

(* rom_style = "block" *) // block || distributed


/* Relative path from the simulation or synthesis working directory */
initial $readmemh("../../rtl/images/player.dat", rom);
initial $readmemh("../../rtl/images/player_left.dat", rom2);

/**
 * Internal logic
 */

always @(posedge clk)

begin
    rgb <= rom[address];
    rgb2 <= rom2[address];

end


endmodule
