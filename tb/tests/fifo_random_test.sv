class fifo_random_test extends uvm_test;
  
  `uvm_component_utils(fifo_random_test)

  fifo_environment env;
  fifo_random_sequence rand_seq;

  function new(string name = "fifo_random_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "inside constructor of the fifo_random_test class", UVM_LOW);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    env = fifo_environment::type_id::create("env",this);
  endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    repeat(500)
    begin
      rand_seq.start(env.agent.sequencer);
    end

    phase.drop_objection(this);
    `uvm_info(get_type_name(), "The end of the testcase", UVM_LOW);
  endtask
endclass