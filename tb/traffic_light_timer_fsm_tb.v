`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/10/21 04:50:55
// Design Name: 
// Module Name: traffic_light_timer_fsm_tb
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





module traffic_light_timer_fsm_tb;

    reg clk;
    reg reset_n;

    wire red;
    wire yellow;
    wire green;

    traffic_light_timer_fsm #(
        .GREEN_TICKS(5),
        .YELLOW_TICKS(2),
        .RED_TICKS(5)
    ) dut (
        .clk(clk),
        .reset_n(reset_n),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    // 현재 상태의 LED 출력 검사
    task check_led;
        input expected_red;
        input expected_yellow;
        input expected_green;
        begin
            if (red !== expected_red ||
                yellow !== expected_yellow ||
                green !== expected_green) begin
                $fatal(1, "FAIL: LED output mismatch");
            end
            else begin
                $display("PASS: R=%b Y=%b G=%b",
                         red, yellow, green);
            end
        end
    endtask

    initial begin
        reset_n = 1'b0;
        #12;
        reset_n = 1'b1;

        // GREEN 상태에서 5클록 유지
        repeat (4) @(posedge clk);
        #1;
        check_led(0, 0, 1);

        @(posedge clk);
        #1;
        check_led(0, 1, 0);

        // YELLOW 상태에서 2클록 유지
        repeat (1) @(posedge clk);
        #1;
        check_led(0, 1, 0);

        @(posedge clk);
        #1;
        check_led(1, 0, 0);

        // RED 상태에서 5클록 유지
        repeat (4) @(posedge clk);
        #1;
        check_led(1, 0, 0);

        @(posedge clk);
        #1;
        check_led(0, 0, 1);

        $display("ALL TIMER FSM TESTS PASSED");
        $finish;
    end

endmodule

