class fifo_read_sequence extends uvm_sequence #(fifo_sequence_item);
  `uvm_object_utils(fifo_read_sequence)

  function new(string name = "fifo_read_sequence");
    super.new(name);
    `uvm_info(get_type_name(), "Inside constructor of the read_sequence class", UVM_LOW);
  endfunction

  task body();
    fifo_sequence_item item;
    repeat (8) begin
      // creating transaction
      item = fifo_sequence_item::type_id::create("item");
      start_item(item);
      item.rst = 0;
      item.write_enable = 0;
      item.read_enable  = 1;
      finish_item(item);
    end

  endtask
endclass