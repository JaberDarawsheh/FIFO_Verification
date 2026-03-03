class fifo_read_write_srequence extends uvm_sequence #(fifo_sequence_item);
  `uvm_object_utils(fifo_read_write_srequence)

  function new(string name = "fifo_read_write_srequence");
    super.new(name);
    `uvm_info(get_type_name(), "Inside constructor of the read_write_srequence class", UVM_LOW);
  endfunction

  task body();
    fifo_sequence_item item;
    repeat (15) begin
      // creating transaction
      item = fifo_sequence_item::type_id::create("item");
      start_item(item);
      item.rst = 0;
      item.write_enable = 1;
      item.read_enable  = 1;
      item.data_input = $urandom_range(0,255);
      finish_item(item);
    end

  endtask
endclass