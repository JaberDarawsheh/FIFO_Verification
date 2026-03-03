class fifo_random_sequence extends uvm_sequence #(fifo_sequence_item);

  `uvm_object_utils(fifo_random_sequence)

  function new(string name = "fifo_random_sequence");
    super.new(name);
    `uvm_info(get_type_name(), "Inside constructor of the random_sequence class", UVM_LOW);
  endfunction

  task body();

    fifo_sequence_item item;

    repeat (60) begin

      item = fifo_sequence_item::type_id::create("item");

      start_item(item);
      if (!item.randomize()) begin
        `uvm_error("RAND_SEQ", "Randomization failed")
      end
      item.rst = 0;
      finish_item(item);
    end
  endtask

endclass