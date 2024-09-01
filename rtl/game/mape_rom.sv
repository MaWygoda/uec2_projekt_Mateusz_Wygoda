//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   mape_rom
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-09.01
 Coding style: Xilinx recommended + ANSI ports
 Description:  Template for ROM module as recommended by Xilinx
 */
//////////////////////////////////////////////////////////////////////////////
module mape_rom (
    input  logic clk ,
    input  logic [15:0] address, 
    input  logic [15:0] address2,
    input  logic [15:0] address3,
    output logic [11:0] rgb,
    output logic [3:0] rgb_cur_pix,
    output logic [3:0] rgb_cur_pix_y
);


logic [11:0] rom [0:65536];
logic [3:0] rom_map2 [0:65536];

(* rom_style = "block" *) // block || distributed

/* Relative path from the simulation or synthesis working directory */
initial $readmemh("../../rtl/images/mapa_test.dat", rom);

initial $readmemh("../../rtl/images/map2.dat", rom_map2);


always @(posedge clk) begin
    rgb <= rom[address];
    rgb_cur_pix <= rom_map2[address2];
    rgb_cur_pix_y <= rom_map2[address3];

end

endmodule
