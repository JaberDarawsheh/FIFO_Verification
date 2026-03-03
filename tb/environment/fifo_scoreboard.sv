class fifo_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(fifo_scoreboard)

  uvm_analysis_imp #(fifo_sequence_item, fifo_scoreboard) scoreboard_port;
  fifo_sequence_item item_ref;
  fifo_sequence_item packetsQueue[$];
  fifo_sequence_item packet;
 
  localparam int FIFODEPTH = 8;
  logic [7:0] fifo_memory [FIFODEPTH];
  int wr_ptr = 0;
  int rd_ptr = 0;
  int fifo_count = 0;

  function new (string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    item_ref = fifo_sequence_item::type_id::create("item_ref");
    `uvm_info(get_type_name(), "inside constructor of the fifo_scoreboard class", UVM_LOW);
  endfunction

  function void build_phase (uvm_phase phase);
   super.build_phase(phase);
   scoreboard_port = new("scoreboard_port", this);
  endfunction

   function void write(fifo_sequence_item item);
      packetsQueue.push_back(item);
   endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
       wait(packetsQueue.size() > 0);
       packet = packetsQueue.pop_front();

    // copy the input fields to the reference item
       this.item_ref.rst           = packet.rst;
       this.item_ref.data_input    = packet.data_input;
       this.item_ref.write_enable  = packet.write_enable;
       this.item_ref.read_enable   = packet.read_enable;
      

    //here calling the reference model to compute the expexted output value
       fifo_reference_modle(packet.rst, packet.data_input, packet.write_enable, packet.read_enable, this.item_ref.data_output, this.item_ref.full, this.item_ref.empty);
      print_fifo_state();

       if(is_equal(packet, this.item_ref)) begin
         `uvm_info("pass", $sformatf("-------- :: PASS:: --------"), UVM_LOW);
       end else begin
         `uvm_error("fail", $sformatf("--------:: FAIL :: --------"));
           end

      `uvm_info("ACTUAL PACKET", $sformatf("Actual DUT Packet : rst = %0d, data_input = %0d, write_enable = %d, read_enable = %d, data_output = %0d, full = %d, empty = %d",packet.rst, packet.data_input, packet.write_enable, packet.read_enable, packet.data_output, packet.full, packet.empty), UVM_LOW);
      `uvm_info("EXPECTED PACKET" ,$sformatf("EXpected DUT Packet : rst = %0d, data_input = %0d, write_enable = %d, read_enable = %d, data_output = %0d, full = %d, empty = %d", item_ref.rst, item_ref.data_input, item_ref.write_enable, item_ref.read_enable, item_ref.data_output, item_ref.full, item_ref.empty) , UVM_LOW);
       $display("***********************************************************");
    end
  endtask
  
  task print_fifo_state();

    string line;
     $display("\n****************************************************************************************** FIFO Memory *******************************************************************************************************************************");
    $display("wr_ptr = %0d | rd_ptr = %0d | elements_count = %0d | full = %0b | empty = %0b",
            wr_ptr, rd_ptr, fifo_count,
            (fifo_count==FIFODEPTH),
            (fifo_count==0));

    line = "";

    for (int i = 0; i < FIFODEPTH; i++) begin
       if (i == wr_ptr && i == rd_ptr)
         line = {line, $sformatf("[rd_ptr -> wr_ptr -> %0d]    ", fifo_memory[i])};
       else if (i == wr_ptr)
         line = {line, $sformatf("[wr_ptr -> %0d]    ", fifo_memory[i])};
       else if (i == rd_ptr)
         line = {line, $sformatf("[rd_ptr -> %0d]    ", fifo_memory[i])};
     else
       line = {line, $sformatf("[%0d]    ", fifo_memory[i])};
  end

     $display("%s", line);
    $display("*****************************************************************************************************************************************************************************************\n");

   endtask

   function bit is_equal(fifo_sequence_item expected, fifo_sequence_item actual);
     if(expected.data_output === actual.data_output && 
        expected.full === actual.full && 
        expected.empty === actual.empty) return 1;
     else return 0;
   endfunction

   task fifo_reference_modle(
   input  logic               rst,
   input  logic        [7:0]  data_input,
   input  logic               write_enable,
   input  logic               read_enable,
   output logic        [7:0]  data_output,
   output logic               full,
   output logic               empty
 );
    if(rst) begin
      data_output = 0;
      full = 0 ;
      empty = 1;
      wr_ptr = 0;
      rd_ptr = 0;
      fifo_count = 0;

      // clear the memory - to be empty
      for (int i = 0; i < FIFODEPTH; i++) begin
          fifo_memory[i] = 0;
      end
    end
 else begin
    // read opera
   data_output = 0;

   if(read_enable && (fifo_count > 0)) begin
    data_output = fifo_memory[rd_ptr];
    rd_ptr = (rd_ptr +1) % FIFODEPTH;
    fifo_count--;
   end
   
   // write operation

   if(write_enable && (fifo_count < FIFODEPTH)) begin
      if(!$isunknown(data_input)) begin
         fifo_memory[wr_ptr] = data_input;
         wr_ptr = (wr_ptr +1)  % FIFODEPTH;
         fifo_count++;
      end
      else begin
         // ignore the operation
      end
   end

   // updating the full and empty flags
   full  = (fifo_count == FIFODEPTH);
   empty = (fifo_count == 0);

 end
 endtask

endclass