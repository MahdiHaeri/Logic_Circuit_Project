`define MOVE_RIGHT 6'b100000 
`define MOVE_LEFT  6'b010000
`define WAIT     6'b001000
`define JUMP     6'b000100
`define KICK     6'b000010
`define PUNCH    6'b000001

module RightPlayer (
    input clk,
    input rst_n,
    input [5:0] right_player_input,
    input [5:0] left_player_input,
    input [1:0] left_player_location,
    output reg [1:0] right_player_location_out, // Present state
    output reg [1:0] right_player_health_out  // Present state
);

    reg [1:0] right_player_location;
    reg [1:0] right_player_health;

    reg [2:0] distance;
    reg wait_counter;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            right_player_location <= 2;
            right_player_health <= 3;
            wait_counter <= 0;
        end else begin
            right_player_location_out <= right_player_location;
            right_player_health_out <= right_player_health;
        end
    end


    always @(posedge clk or negedge rst_n) begin
        // apply movement input
        if (right_player_input == `MOVE_RIGHT && right_player_location != 2) begin
            right_player_location <= right_player_location + 1;
        end else if (right_player_input == `MOVE_LEFT && right_player_location != 0) begin
            right_player_location <= right_player_location - 1;
        end



        // handle wait input
        if (right_player_input == `WAIT) begin
            if (wait_counter == 1) begin
                right_player_health <= right_player_health + 1;
            end
            wait_counter <= ~wait_counter; // Toggle wait_counter
        end else begin
            wait_counter <= 0; // Reset wait_counter if the input is not "wait"
        end



        distance <= right_player_location + left_player_location;
        // check if the right player is hit
        if (right_player_input != `JUMP) begin  // If the left player is in the air, then the right player can't be hit
            case (distance)
                0: begin
                    if (left_player_input == `PUNCH) begin
                        if (right_player_input == `PUNCH) begin
                            right_player_location <= right_player_location + 1;
                        end else begin
                            right_player_health <= right_player_health - 2;
                        end
                    end else if (left_player_input == `KICK) begin
                        if (right_player_input == `PUNCH) begin
                            // Do nothing
                        end else if (right_player_input == `KICK) begin
                            right_player_location <= right_player_location + 1;
                        end else begin
                            right_player_health <= right_player_health - 1;
                        end
                    end
                end
                1: begin 
                    if (left_player_input == `KICK) begin
                        if (right_player_input == `KICK) begin 
                            right_player_location <= right_player_location + 1;
                        end else begin
                            right_player_health <= right_player_health - 1;
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