class fifo_subscriber extends uvm_subscriber #(fifo_sequence_item);
 
 `uvm_component_utils(fifo_subscriber)
  
  logic [7:0]  data_input;
  logic        write_enable;
  logic        read_enable;
  logic [7:0]  data_output;
  logic        full;
  logic        empty;

  covergroup fifo_coverage;
     data_input:        coverpoint data_input;
     write_enable:      coverpoint write_enable;
     read_enable:       coverpoint read_enable;
     data_output:       coverpoint data_output;
     full:              coverpoint full;
     empty:             coverpoint empty;
   endgroup

   function new(string name = "fifo_subscriber", uvm_component parent);
      super.new(name, parent);
      // creating object from fifo coverage
      fifo_coverage = new;
      `uvm_info(get_type_name(), "inside constructor of the fifo_subscriber", UVM_LOW);
   endfunction

    virtual function void write(fifo_sequence_item t);
     data_input        = t.data_input;
     write_enable      = t.write_enable;
     read_enable       = t.read_enable;
     data_output       = t.data_output;
     full              = t.full;
     empty             = t.empty;
     fifo_coverage.sample();
   endfunction

// the last uvm phase
   function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     `uvm_info(get_type_name(), $sformatf("Coverage:  %.2f%%", fifo_coverage.get_coverage()), UVM_LOW);
   endfunction
endclass