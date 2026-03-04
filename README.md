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
- FIFO Type: Synchronous
- Data Width: 8-bit
- Depth: 8 entries
- Operations:
  - `write - store`
  - `read - retrieve `
- Reset: Asynchronous reset
- Control Signals:
  - `write_enable`
  - `read_enable`
- Status Flags:
  - `full`
  - `empty`

## Testbench Architecture

###  Verification Methodology

The FIFO is verified using **UVM (Universal Verification Methodology)**.

- **Sequence_item** (Transaction)
- **Sequencses**
- **Sequencer**
- **Driver**
- **Monitor**
- **Agent**
- **Scoreboard**
- **Subscriber**
- **Environment**

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


### Project Structure
The FIFO project follows a clean and scalable UVM-based architecture.
The directory organization is structured to clearly separate RTL design from verification components

```
FIFO/
│
├── rtl/
│   └── fifo.sv
│
├── tb/
│   │
│   ├── agent/
│   │   ├── fifo_driver.sv
│   │   ├── fifo_monitor.sv
│   │   ├── fifo_sequence_item.sv
│   │   └── fifo_sequencer.sv
│   │
│   ├── environment/
│   │   ├── fifo_agent.sv
│   │   ├── fifo_environment.sv
│   │   ├── fifo_scoreboard.sv
│   │   └── fifo_subscriber.sv
│   │
│   ├── interface/
│   │   └── fifo_interface.sv
│   │
│   ├── pkg/
│   │   └── fifo_pkg.sv
│   │
│   ├── sequences/
│   │   ├── fifo_invalid_input_sequence.sv
│   │   ├── fifo_random_sequence.sv
│   │   ├── fifo_read_sequence.sv
│   │   ├── fifo_read_write_sequence.sv
│   │   ├── fifo_write_sequence.sv
│   │   └── fifo_reset_sequence.sv
│   │
│   ├── tests/
│   │   ├── fifo_random_test.sv
│   │   └── fifo_regression_test.sv
│   │
│   └── top/
│       └── testbench.sv
│
└── README.md
```

# Test Scenarios

The following scenarios were verified:

-  Reset behavior
-  Write-only operation
-  Read-only operation
-  Simultaneous read/write operation
-  Full condition
-  Empty condition
-  Underflow condition
-  Overflow condition
-  Invalid input patterns
-  Random cases
-  Regression testing
-  Random testing
-  Mixed sases
-  Corner cases
-  Boundary cases


##  Design Bugs Identified After UVM Verification

###  Invalid Input Pattern Handling
- The FIFO did not properly handle unexpected control input patterns.  
- Random testing exposed unstable internal behavior.

---

### Read/Write Priority Issue
When both `write_enable` and `read_enable` were active:
- FIFO did not correctly handle priority (read has more priority than write operation).
- Incorrect data could be read.
- Scoreboard detected mismatches.

---

###  Read From Empty FIFO (Underflow)
When FIFO was empty and a read occurred:
- Output behavior was not properly protected.
- Underflow handling required correction.

All issues were detected using:
- Scoreboard comparison
- Directed sequences received from monitor
- Waveform analysis introduced by simulator

---

## Coverage Report

Functional Coverage: 87.24 % 

---
#  How to Run Simulation (QuestaSim)

```bash
vlog -sv rtl/fifo.sv tb/**/*.sv
vsim work.testbench
run -all
```

##  Tools Used

- SystemVerilog
- UVM 1.2
- Siemens Questa 2025.2
- Visual Studio code (VS Code).
- EDA Playgroud simulator
- Git, GitHub & GitLab
