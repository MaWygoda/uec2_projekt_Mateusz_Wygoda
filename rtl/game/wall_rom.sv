//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   wall_rom
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-09.01
 Coding style: Xilinx recommended + ANSI ports
 Description:  Template for ROM module as recommended by Xilinx
 */
//////////////////////////////////////////////////////////////////////////////
module wall_rom (
    input  logic clk ,
    input  logic [12:0] address,  // address = {addry[5:0], addrx[5:0]}
    output logic [11:0] rgb
);



(* rom_style = "block" *) // block || distributed

logic [11:0] rom [0:8192];


initial $readmemh("../../rtl/images/wall.dat", rom);


always @(posedge clk) begin
    rgb <= rom[address];

end

endmodule
