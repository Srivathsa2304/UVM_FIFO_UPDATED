`include "monitor2.sv"

class fifo_agent2 extends uvm_agent;
  fifo_monitor2 f_mon2;
  `uvm_component_utils(fifo_agent2)

  function new(string name = "fifo_agent2", uvm_component parent);
    super.new(name, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //if(get_is_active() == UVM_ACTIVE) begin
      f_mon2 = fifo_monitor2::type_id::create("f_mon2", this);
    //end
  endfunction
  
  // virtual function void connect_phase(uvm_phase phase);
  //   if(get_is_active() == UVM_PASSIVE)
  //     f_dri.seq_item_port.connect(f_seqr.seq_item_export);
  // endfunction
  
endclass

