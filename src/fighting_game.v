`include "right_player.v"
`include "left_player.v"

module FightingGame (
    input clk,
    input rst_n,
    input [5:0] right_player_input,
    input [5:0] left_player_input,
    output wire [1:0] right_player_location_out, // Change from reg to wire
    output wire [1:0] right_player_health_out, // Change from reg to wire
    output wire [1:0] left_player_location_out, // Change from reg to wire
    output wire [1:0] left_player_health_out  // Change from reg to wire
);

    RightPlayer right_player_inst (
        .clk(clk),
        .rst_n(rst_n),
        .right_player_input(right_player_input),
        .left_player_input(left_player_input),
        .right_player_location_out(right_player_location_out),
        .right_player_health_out(right_player_health_out)
    );

    LeftPlayer left_player_inst (
        .clk(clk),
        .rst_n(rst_n),
        .right_player_input(right_player_input),
        .left_player_input(left_player_input),
        .left_player_location_out(left_player_location_out),
        .left_player_health_out(left_player_health_out)
    );

endmodule