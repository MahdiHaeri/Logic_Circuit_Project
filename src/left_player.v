`define ZERO     2'b00
`define ONE      2'b01
`define TWO      2'b10
`define THREE    2'b11

`define GO_RIGHT 6'b100000 
`define GO_LEFT  6'b010000
`define WAIT     6'b001000
`define JUMP     6'b000100
`define KICK     6'b000010
`define PUNCH    6'b000001

module LeftPlayer (
    input clk,
    input rst_n,
    input [5:0] right_player_input,
    input [5:0] left_player_input,
    input [1:0] right_player_location,
    output reg [1:0] left_player_location_out, // Present state
    output reg [1:0] left_player_health_out  // Present state
);

    reg [1:0] left_player_location;
    reg [1:0] left_player_health;

    reg [2:0] distance;
    reg wait_counter;


    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            left_player_location <= `TWO;
            left_player_health <= `THREE;
            wait_counter <= 0;
        end else begin
            left_player_location_out <= left_player_location;
            left_player_health_out <= left_player_health;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        // apply movement input
        if (left_player_input == `GO_RIGHT && left_player_location != `ZERO) begin
            left_player_location <= left_player_location - `ONE;
        end else if (left_player_input == `GO_LEFT && left_player_location != `TWO) begin
            left_player_location <= left_player_location + `ONE;
        end



        // handle wait input
        if (left_player_input == `WAIT) begin
            if (wait_counter == 1) begin
                left_player_health <= left_player_health + `ONE;
            end
            wait_counter <= ~wait_counter; // Toggle wait_counter
        end else begin
            wait_counter <= 0; // Reset wait_counter if the input is not "wait"
        end



        distance <= right_player_location + left_player_location;
        // check if the right player is hit
        if (left_player_input != `JUMP) begin  // If the left player is in the air, then the right player can't be hit
            case (distance)
                `ZERO: begin
                    if (right_player_input == `PUNCH) begin
                        if (left_player_input == `PUNCH) begin
                            left_player_location <= left_player_location + `ONE;
                        end else begin
                            left_player_health <= left_player_health - `TWO;
                            left_player_location <= left_player_location + `ONE;
                        end
                    end else if (right_player_input == `KICK) begin
                        if (left_player_input == `PUNCH) begin
                            // Do nothing
                        end else if (left_player_input == `KICK) begin
                            left_player_location <= left_player_location + `ONE;
                        end else begin
                            left_player_health <= left_player_health - `ONE;
                            left_player_location <= left_player_location + `ONE;
                        end
                    end
                end
                `ONE: begin 
                    if (right_player_input == `KICK) begin
                        if (left_player_input == `KICK) begin 
                            left_player_location <= left_player_location + `ONE;
                        end else begin
                            left_player_health <= left_player_health - `ONE;
                            left_player_location <= left_player_location + `ONE;
                        end
                    end
                end
                default: begin
                    // Do nothing
                end
            endcase
        end
    end
endmodule