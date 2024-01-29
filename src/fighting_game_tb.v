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
    wire [2:0] right_player_location_out;
    wire [2:0] right_player_health_out;
    wire [2:0] left_player_location_out;
    wire [2:0] left_player_health_out;

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
    end


    initial begin
        clk = 1;
        rst_n = 1;
        #1
        rst_n = 0;
        #1
        rst_n = 1; 
    end

    initial begin
        $display("Starting simulation...");
        $monitor("Time: %t, Right player location: %d, Right player health: %d, Left player location: %d, Left player health: %d", $time, right_player_location_out, right_player_health_out, left_player_location_out, left_player_health_out);

        #15
        // --------------- Sample inputs ----------------
        // left_player_input = `MOVE_RIGHT;
        // right_player_input = `MOVE_LEFT;
        // #DELAY
        // left_player_input = `MOVE_RIGHT;
        // right_player_input = `MOVE_LEFT;
        // #DELAY
        // left_player_input = `MOVE_RIGHT;
        // right_player_input = `MOVE_LEFT;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY
        // left_player_input = `PUNCH;
        // right_player_input = `PUNCH;
        // #DELAY

        // --------------- TestBench inputs ----------------

        left_player_input = `MOVE_RIGHT;
        right_player_input = `MOVE_LEFT;
        #DELAY
        left_player_input = `MOVE_RIGHT;
        right_player_input = `MOVE_LEFT;
        #DELAY
        left_player_input = `KICK;
        right_player_input = `MOVE_LEFT;
        #DELAY
        left_player_input = `MOVE_RIGHT;
        right_player_input = `PUNCH;
        #DELAY
        left_player_input = `WAIT;
        right_player_input = `WAIT;
        #DELAY
        left_player_input = `WAIT;
        right_player_input = `WAIT;
        #DELAY
        left_player_input = `PUNCH;
        right_player_input = `KICK;
        #DELAY
        left_player_input = `JUMP;
        right_player_input = `PUNCH;
        #DELAY

        // --------------- TestBench inputs ----------------
        // left_player_input = `MOVE_RIGHT;
        // right_player_input = `MOVE_LEFT;
        // #DELAY
        // left_player_input = `MOVE_RIGHT;
        // right_player_input = `MOVE_LEFT;
        // #DELAY
        // left_player_input = `MOVE_LEFT;
        // right_player_input = `MOVE_RIGHT;
        // #DELAY
        // left_player_input = `MOVE_LEFT;
        // right_player_input = `MOVE_LEFT;
        // #DELAY


    //     // --------------- TestBench inputs ----------------
    //     left_player_input = `MOVE_RIGHT;
    //     right_player_input = `MOVE_LEFT;
    //     #DELAY
    //     left_player_input = `MOVE_RIGHT;
    //     right_player_input = `MOVE_LEFT;
    //     #DELAY
    //     left_player_input = `PUNCH;
    //     right_player_input = `JUMP;
    //     #DELAY
    //     left_player_input = `PUNCH;
    //     right_player_input = `KICK;
    //     #DELAY
    //     left_player_input = `PUNCH;
    //     right_player_input = `PUNCH;
    //     #DELAY
    //     left_player_input = `MOVE_RIGHT;
    //     right_player_input = `WAIT;
    //     #DELAY
    //     left_player_input = `JUMP;
    //     right_player_input = `WAIT;
    //     #DELAY
    //    left_player_input = `PUNCH;
    //     right_player_input = `KICK;
    //     #DELAY
    //     left_player_input = `KICK;
    //     right_player_input = `JUMP;
    //     #DELAY
    //     left_player_input = `MOVE_LEFT;
    //     right_player_input = `KICK;
    //     #DELAY
    //     left_player_input = `KICK;
    //     right_player_input = `MOVE_LEFT;
    //     #DELAY

        #DELAY
        $finish; // End simulation
    end

    always #10 clk = ~clk; // Toggle clock every 5 time units
endmodule
