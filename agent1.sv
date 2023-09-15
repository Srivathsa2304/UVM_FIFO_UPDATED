`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor1.sv"


class fifo_agent1 extends uvm_agent;
  fifo_sequencer f_seqr;
  fifo_driver f_dri;
  fifo_monitor1 f_mon1;
  `uvm_component_utils(fifo_agent1)

  function new(string name = "fifo_agent1", uvm_component parent);
    super.new(name, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      f_seqr = fifo_sequencer::type_id::create("f_seqr", this);
      f_dri = fifo_driver::type_id::create("f_dri", this);
      f_mon1 = fifo_monitor1::type_id::create("f_mon1", this);
    end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      f_dri.seq_item_port.connect(f_seqr.seq_item_export);
  endfunction
  
endclass

