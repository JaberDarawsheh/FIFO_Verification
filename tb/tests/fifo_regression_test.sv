class fifo_regression_test extends uvm_test;

  `uvm_component_utils(fifo_regression_test)

   fifo_environment env;

   fifo_reset_sequence         reset_sequence;
   fifo_write_sequence         write_sequence;
   fifo_read_sequence          read_sequence;
   fifo_read_write_srequence   read_write_srequence;
   fifo_random_sequence        random_sequence;
   fifo_invalid_input_sequence invalid_input_sequence;

   function new(string name = "fifo_regression_test", uvm_component parent);
     super.new(name, parent);
     `uvm_info(get_type_name(), "inside constructor of the fifo_regression_test class", UVM_LOW);
   endfunction

   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     env = fifo_environment::type_id::create("env",this);
     uvm_config_db#(uvm_active_passive_enum)::set(
      this,
      "env.agent",
      "is_active",
      UVM_ACTIVE
  );
   endfunction

   task run_phase (uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    reset_sequence = fifo_reset_sequence::type_id::create("reset_sequence");
    reset_sequence.start(env.agent.sequencer);

    write_sequence = fifo_write_sequence::type_id::create("write_sequence");
    write_sequence.start(env.agent.sequencer);

    read_sequence = fifo_read_sequence::type_id::create("read_sequence");
    read_sequence.start(env.agent.sequencer);
    
    read_write_srequence = fifo_read_write_srequence::type_id::create("read_write_srequence");
    read_write_srequence.start(env.agent.sequencer);

    random_sequence = fifo_random_sequence::type_id::create("random_sequence");
    random_sequence.start(env.agent.sequencer);
     
    invalid_input_sequence = fifo_invalid_input_sequence::type_id::create("invalid_input_sequence");
    invalid_input_sequence.start(env.agent.sequencer);
     

    phase.drop_objection(this);
    `uvm_info(get_type_name(), "The end of the regression test", UVM_LOW);

   endtask
endclass
