class fifo_sequence_item extends uvm_sequence_item;
    rand logic [7:0] data_input;
    rand logic       write_enable;
    rand logic       read_enable;
    rand logic       rst;
    logic      [7:0] data_output;
    logic            full;
    logic            empty;

    `uvm_object_utils(fifo_sequence_item)

   function new (string name = "fifo_sequence_item");
      super.new(name);
      `uvm_info(get_type_name(), "inside the constructor of the fifo_sequence_item", UVM_LOW);
   endfunction

endclass