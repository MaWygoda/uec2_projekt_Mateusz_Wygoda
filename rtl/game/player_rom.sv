
module player_rom (
    input  logic clk ,
    input  logic [11:0] address,  // address = {addry[5:0], addrx[5:0]}
    output logic [11:0] rgb,
    output logic [11:0] rgb2
);


/**
 * Local variables and signals
 */

reg [11:0] rom [0:4096];
reg [11:0] rom2 [0:4096];


/**
 * Memory initialization from a file
 */

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
