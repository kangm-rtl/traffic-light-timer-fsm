# Traffic Light Timer FSM

## 1. Project Overview
This project implements a traffic light controller using Verilog HDL and a finite state machine (FSM).

A counter is used to control how long each traffic light state remains active.

## 2. Development Environment
- HDL: Verilog
- Simulation Tool: AMD Xilinx Vivado
- Verification: Verilog Testbench and waveform inspection

## 3. Design Features
- FSM-based traffic light control
- Counter-based state timing
- Active-low reset (`reset_n`)
- Parameterized timing values
- Automated testbench checks

## 4. State Sequence
The traffic light cycles through the following states:

1. Green
2. Yellow
3. Red
4. Repeat

## 5. Timing Configuration
| State | Configured duration |
|---|---:|
| Green | 5 clock cycles |
| Yellow | 2 clock cycles |
| Red | 5 clock cycles |

Clock period used in simulation: 10 ns.

## 6. Verification
The design was simulated in Vivado using a Verilog testbench.

Observed console result:

`ALL TIMER FSM TESTS PASSED`

The waveform was inspected to observe the clock, reset, LED outputs, state, and counter signals.

## 7. Files
- `rtl/traffic_light_timer_fsm.v` — RTL design
- `tb/traffic_light_timer_fsm_tb.v` — Testbench
- `docs/waveform.png` — Simulation waveform

## 8. What I Learned
- FSM state transitions
- Counter-based timing control
- Synchronous state updates
- Reset behavior
- Testbench-based functional verification
- Reading simulation waveforms

## 9. Future Improvements
- Verify exact state duration and transition boundaries
- Add more boundary-condition test cases
- Test reset behavior during operation
- Explore FPGA implementation on a development board
