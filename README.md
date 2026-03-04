#  FIFO UVM Verification Project

##  Overview
This project implements and verifies a **Synchronous FIFO (First In First Out)** using **SystemVerilog RTL** and a complete **UVM-based verification environment**.

The objective of this project is to:

- Verify all functional scenarios
- Detect and debug design bugs early before synthesis or fabrication
- Build a scalable UVM environment
- Validate behavior under corner cases
- Ensure the design meets the given specifications under all conditions

##  FIFO Design Features
- Parameterized FIFO depth - 8 elements, each with a width of 8 bits
- Asynchronous reset
- Write Operation
- Read Operation
- Write Enable Signal
- Read Enable Signal
- Full flag
- Empty flag
- Pointer-based implementation

## Testbench Architecture

### UVM Components Used to Verify FIFO

- Sequence_item (Transaction)
- Sequencses
- Sequencer
- Driver
- Monitor
- Agent
- Scoreboard
- Subscriber
- Environment

### Interface Signals

The following table describes the FIFO module interface signals:

| Signal        | Width | Direction | Description |
|--------------|-------|-----------|-------------|
| `clk`        | 1     | input     | Clock signal driving the FIFO module. |
| `rst`        | 1     | input     | Synchronous reset. Clears stored data and initializes internal signals to default values. |
| `data_input` | 8     | input     | Data input bus. Represents the data to be written into the FIFO. |
| `write_enable` | 1   | input     | Write control signal. When asserted, data is stored into the FIFO (if not full). |
| `read_enable`  | 1   | input     | Read control signal. When asserted, data is retrieved from the FIFO (if not empty). |
| `data_output`  | 8   | output    | Data output bus. Represents the data read from the FIFO. |
| `full`         | 1   | output    | Indicates that the FIFO is full and cannot accept new data. |
| `empty`        | 1   | output    | Indicates that the FIFO is empty and has no data to read. |



  


