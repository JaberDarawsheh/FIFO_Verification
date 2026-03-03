`include "../interface/fifo_interface.sv"

package fifo_pkg;
   import uvm_pkg::*;
  `include "uvm_macros.svh"

   `include "../agent/fifo_sequence_item.sv"
   `include "../agent/fifo_sequencer.sv"
   `include "../agent/fifo_driver.sv"
   `include "../agent/fifo_monitor.sv"

    `include "../environment/fifo_agent.sv"
    `include "../environment/fifo_scoreboard.sv"
    `include "../environment/fifo_subscriber.sv"
    `include "../environment/fifo_environment.sv"

    `include "../sequences/fifo_random_sequence.sv"
    `include "../sequences/fifo_read_sequence.sv"
    `include "../sequences/fifo_read_write_srequence.sv"
    `include "../sequences/fifo_reset_sequence.sv"
    `include "../sequences/fifo_write_sequence.sv"
    `include "../sequences/fifo_invalid_input_sequence.sv"

    `include "../tests/fifo_random_test.sv"
    `include "../tests/fifo_regression_test.sv"
endpackage