`include "fighting_game.v"

`define MOVE_RIGHT 6'b100000 
`define MOVE_LEFT  6'b010000
`define WAIT     6'b001000
`define JUMP     6'b000100
`define KICK     6'b000010
`define PUNCH    6'b000001

module FightingGame_tb();
    reg clk;
    reg rst_n;
    reg [5:0] right_player_input;
    reg [5:0] left_player_input;
    wire [1:0] right_player_location_out;
    wire [1:0] right_player_health_out;
    wire [1:0] left_player_location_out;
    wire [1:0] left_player_health_out;

    parameter DELAY = 20;

    FightingGame fighting_game_inst (
        .clk(clk),
        .rst_n(rst_n),
        .right_player_input(right_player_input),
        .left_player_input(left_player_input),
        .right_player_location_out(right_player_location_out),
        .right_player_health_out(right_player_health_out),
        .left_player_location_out(left_player_location_out),
        .left_player_health_out(left_player_health_out)
    );

    initial begin
        $dumpfile("fighting_game_tb.vcd");
        $dumpvars(0, FightingGame_tb);

        $display("Starting simulation...");
        $monitor("Time: %t, Right player location: %d, Right player health: %d, Left player location: %d, Left player health: %d", $time, right_player_location_out, right_player_health_out, left_player_location_out, left_player_health_out);

        // Initialize inputs
        clk = 0;
        rst_n = 0;

        #DELAY rst_n = 1; // Release reset

        // --------------- Sample inputs ----------------
        // left_player_input = `MOVE_RIGHT;
        // right_player_input = `MOVE_LEFT;
        // #DELAY
        // left_player_input = `MOVE_RIGHT;
        // right_player_input = `MOVE_LEFT;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `KICK;
        // right_player_input = `MOVE_LEFT;
        // #DELAY
        // left_player_input = `MOVE_RIGHT;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `WAIT;
        // right_player_input = `WAIT;
        // #DELAY
        // left_player_input = `WAIT;
        // right_player_input = `WAIT;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `KICK;
        // #DELAY
        // left_player_input = `JUMP;
        // right_player_input = `PUNCH;


        // --------------- TestBench inputs ----------------
        left_player_input = `MOVE_RIGHT;
        right_player_input = `MOVE_LEFT;
        #DELAY
        left_player_input = `MOVE_RIGHT;
        right_player_input = `MOVE_LEFT;
        #DELAY
        left_player_input = `PUNCH;
        right_player_input = `JUMP;
        #DELAY
        left_player_input = `PUNCH;
        right_player_input = `KICK;
        #DELAY
        left_player_input = `PUNCH;
        right_player_input = `PUNCH;
        #DELAY
        left_player_input = `MOVE_RIGHT;
        right_player_input = `WAIT;
        #DELAY
        left_player_input = `JUMP;
        right_player_input = `WAIT;
        #DELAY
       left_player_input = `PUNCH;
        right_player_input = `KICK;
        #DELAY
        left_player_input = `KICK;
        right_player_input = `JUMP;
        #DELAY
        left_player_input = `MOVE_LEFT;
        right_player_input = `KICK;
        #DELAY
        left_player_input = `KICK;
        right_player_input = `MOVE_LEFT;

        #DELAY
        $finish; // End simulation
    end

    always #30 clk = ~clk; // Toggle clock every 5 time units
endmodule
