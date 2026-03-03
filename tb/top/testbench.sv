`include "./fifo_pkg.sv"
import fifo_pkg::*;

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "./fifo_interface.sv"

module testbench;

  logic clk, rst;
  // clk generator
 initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
   rst = 1;
   #20 rst = 0;
  end

  fifo_interface v_intf(.clk(clk));
  fifo dut (
        .clk             (v_intf.clk),
        .rst             (v_intf.rst),
        .data_input      (v_intf.data_input),
        .write_enable    (v_intf.write_enable),
        .read_enable     (v_intf.read_enable),
        .data_output     (v_intf.data_output),
        .full            (v_intf.full),
        .empty           (v_intf.empty)
    );
  

  initial begin
        // setting the interface to the config_db
        uvm_config_db#(virtual fifo_interface)::set(uvm_root::get(), "*", "v_intf", v_intf);
   end

  initial begin
    $dumpfile("fifo_waveform.vcd");
    $dumpvars(0, testbench);
   end

  initial begin
    
         //run_test("fifo_random_test");
        run_test("fifo_regression_test");
    end
  
endmodule

