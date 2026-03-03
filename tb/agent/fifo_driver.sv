class fifo_driver extends uvm_driver #(fifo_sequence_item);
  
  `uvm_component_utils(fifo_driver)

  virtual fifo_interface v_intf;
  fifo_sequence_item item;

  function new (string name = "fifo_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside the constructor of the fifo_driver class", UVM_LOW);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual fifo_interface)::get(this, "", "v_intf", v_intf))
      `uvm_fatal(get_type_name(), "the driver not accessed to the dut's interface");
  endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);

    forever begin
        //item = fifo_sequence_item::type_id::create("item");
        seq_item_port.get_next_item(item);
        drive(item);
        `uvm_info(get_type_name(), "Signals driven succsessfully to DUT", UVM_HIGH);
        seq_item_port.item_done();
    end
  endtask

  task drive (fifo_sequence_item item);
    @(v_intf.driver_cb);
    v_intf.driver_cb.rst             <= item.rst;
    v_intf.driver_cb.data_input      <= item.data_input;
    v_intf.driver_cb.write_enable    <= item.write_enable;
    v_intf.driver_cb.read_enable     <= item.read_enable;
  endtask

endclass