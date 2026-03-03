class fifo_monitor extends uvm_monitor;

  `uvm_component_utils(fifo_monitor)

  virtual fifo_interface v_intf;
  fifo_sequence_item item;
  uvm_analysis_port #(fifo_sequence_item) monitor_port;
  
  function new (string name = "fifo_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "inside constructor of the fifo_monitor class", UVM_LOW);
  endfunction

  function void build_phase (uvm_phase phase);
   super.build_phase(phase);
     monitor_port = new("monitor_port", this);
    if(!uvm_config_db #(virtual fifo_interface):: get(this, "", "v_intf", v_intf))
       `uvm_fatal(get_type_name(), "the monitor not accessed to the dut's interface");
  endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
       item = fifo_sequence_item::type_id::create("item");

       @(posedge v_intf.clk);
       #2;
         item.data_input   =     v_intf.data_input;
         item.write_enable =     v_intf.write_enable;
         item.read_enable  =     v_intf.read_enable;
         item.rst          =     v_intf.rst;
         item.data_output  =     v_intf.data_output;
         item.full         =     v_intf.full;
         item.empty        =     v_intf.empty;

         monitor_port.write(item);
    end
  endtask

endclass