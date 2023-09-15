class fifo_monitor2 extends uvm_monitor;
  virtual fifo_interface vif;
  fifo_sequence_items item_got2;
  uvm_analysis_port#(fifo_sequence_items) item_got_port2;
  `uvm_component_utils(fifo_monitor2)
  
  function new(string name = "fifo_monitor2", uvm_component parent);
    super.new(name, parent);
    item_got_port2 = new("item_got_port2", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_got2 = fifo_sequence_items::type_id::create("item_got2");
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor2: ", "No vif is found!");
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.pas_monitor_mp.clk)
      item_got2.o_full = vif.pas_monitor_mp.passive_monitor_cb.o_full;
      item_got2.o_empty = vif.pas_monitor_mp.passive_monitor_cb.o_empty;
      item_got2.o_alm_full = vif.pas_monitor_mp.passive_monitor_cb.o_alm_full;
      item_got2.o_alm_empty = vif.pas_monitor_mp.passive_monitor_cb.o_alm_empty;
      item_got2.o_rddata = vif.pas_monitor_mp.passive_monitor_cb.o_rddata;
      item_got_port2.write(item_got2);
    end
  endtask
endclass

