class fifo_environment extends uvm_env;
  
  `uvm_component_utils(fifo_environment)

  fifo_agent agent;
  fifo_scoreboard scoreboard;
  fifo_subscriber subscriber;
  
  function new (string name = "fifo_environment", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "inside constructor of the fifo_environment", UVM_LOW);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    scoreboard = fifo_scoreboard::type_id::create("scoreboard", this);
    subscriber = fifo_subscriber::type_id::create("subscriber", this);
    agent      = fifo_agent::type_id::create("agent", this);
  endfunction
  
  function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);

  if (agent == null)
    `uvm_fatal("ENV", "agent is NULL")

  if (agent.monitor == null)
    `uvm_fatal("ENV", "monitor is NULL")

  if (agent.monitor.monitor_port == null)
    `uvm_fatal("ENV", "monitor_port is NULL")

  if (scoreboard == null)
    `uvm_fatal("ENV", "scoreboard is NULL")

  if (scoreboard.scoreboard_port == null)
    `uvm_fatal("ENV", "scoreboard_port is NULL")

  agent.monitor.monitor_port.connect(scoreboard.scoreboard_port);
    
  agent.monitor.monitor_port.connect(subscriber.analysis_export);

endfunction

endclass