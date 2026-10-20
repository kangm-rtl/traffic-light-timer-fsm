`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/21 04:49:32
// Design Name: 
// Module Name: traffic_light_timer_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module traffic_light_timer_fsm #(
    parameter GREEN_TICKS  = 5,
    parameter YELLOW_TICKS = 2,
    parameter RED_TICKS    = 5
)(
    input  wire clk,
    input  wire reset_n,

    output reg red,
    output reg yellow,
    output reg green
);

    // 상태 정의
    localparam GREEN  = 2'b00;
    localparam YELLOW = 2'b01;
    localparam RED    = 2'b10;

    reg [1:0] state;
    reg [1:0] next_state;

    // 상태별 경과 클록 수
    reg [3:0] count;

    // 1. 다음 상태 결정
    always @(*) begin
        case (state)
            GREEN:  next_state = YELLOW;
            YELLOW: next_state = RED;
            RED:    next_state = GREEN;
            default: next_state = GREEN;
        endcase
    end

    // 2. 상태와 Counter 제어
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= GREEN;
            count <= 0;
        end
        else begin
            if (state == GREEN) begin
                if (count == GREEN_TICKS - 1) begin
                    count <= 0;
                    state <= next_state;
                end
                else begin
                    count <= count + 1'b1;
                end
            end
            else if (state == YELLOW) begin
                if (count == YELLOW_TICKS - 1) begin
                    count <= 0;
                    state <= next_state;
                end
                else begin
                    count <= count + 1'b1;
                end
            end
            else if (state == RED) begin
                if (count == RED_TICKS - 1) begin
                    count <= 0;
                    state <= next_state;
                end
                else begin
                    count <= count + 1'b1;
                end
            end
            else begin
                state <= GREEN;
                count <= 0;
            end
        end
    end

    // 3. Moore 출력
    always @(*) begin
        red    = 1'b0;
        yellow = 1'b0;
        green  = 1'b0;

        case (state)
            GREEN:  green  = 1'b1;
            YELLOW: yellow = 1'b1;
            RED:    red    = 1'b1;
            default: green = 1'b1;
        endcase
    end
    

endmodule

