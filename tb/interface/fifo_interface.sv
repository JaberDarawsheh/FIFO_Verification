interface fifo_interface (input logic clk);
    logic [7:0] data_input;
    logic       write_enable;
    logic       read_enable;
    logic       rst;
    logic [7:0] data_output;
    logic       full;
    logic       empty;

 clocking driver_cb @(negedge clk);
   default input #1 output #0;
   output data_input;
   output write_enable;
   output read_enable;
   output rst;
 endclocking

 clocking monitor_cb @(posedge clk);
   default input #0 output #1;
   input data_input;
   input write_enable;
   input read_enable;
   input rst;
   input data_output;
   input full;
   input empty;
 endclocking

modport driver (
clocking driver_cb,
input clk
);

modport monitor (
clocking monitor_cb,
input clk
);

endinterface