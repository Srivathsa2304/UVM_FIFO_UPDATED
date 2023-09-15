class fifo_monitor1 extends uvm_monitor;
  virtual fifo_interface vif;
  fifo_sequence_items item_got1;
  uvm_analysis_port#(fifo_sequence_items) item_got_port1;
  `uvm_component_utils(fifo_monitor1)
  
  function new(string name = "fifo_monitor1", uvm_component parent);
    super.new(name, parent);
    item_got_port1 = new("item_got_port1", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_got1 = fifo_sequence_items::type_id::create("item_got1");
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor1: ", "No vif is found!");
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.act_monitor_mp.clk)
      if(vif.act_monitor_mp.active_monitor_cb.i_wren == 0 && vif.act_monitor_mp.active_monitor_cb.i_rden == 0)begin
        $display("\n Write is low and read is low");
        //item_got1.i_wrdata = vif.act_monitor_mp.active_monitor_cb.i_wrdata;
        item_got1.i_wren = 'b0;
        item_got1.i_rden = 'b0;
        //item_got1.full = vif.act_monitor_mp.active_monitor_cb.full;
        item_got_port1.write(item_got1);
      end
      else if(vif.act_monitor_mp.active_monitor_cb.i_wren == 0 && vif.act_monitor_mp.active_monitor_cb.i_rden == 1)begin
        @(posedge vif.act_monitor_mp.clk)
        $display("\n write is low and Read is high");
       // item_got1.i_rddata = vif.act_monitor_mp.active_monitor_cb.i_rddata;
        item_got1.i_wren = 'b0;
        item_got1.i_rden = 'b1;
        //item_got1.empty = vif.act_monitor_mp.active_monitor_cb.empty;
        item_got_port1.write(item_got1);
      end

      else if(vif.act_monitor_mp.active_monitor_cb.i_wren == 1 && vif.act_monitor_mp.active_monitor_cb.i_rden == 0)begin
        @(posedge vif.act_monitor_mp.clk)
        $display("\n write is high and read is low");
       // item_got1.i_rddata = vif.act_monitor_mp.active_monitor_cb.i_rddata;
        item_got1.i_wren = 'b1;
        item_got1.i_rden = 'b0;
        item_got1.i_wrdata = vif.act_monitor_mp.active_monitor_cb.i_wrdata;
        //item_got1.empty = vif.act_monitor_mp.active_monitor_cb.empty;
        item_got_port1.write(item_got1);
      end

      else if(vif.act_monitor_mp.active_monitor_cb.i_wren == 1 && vif.act_monitor_mp.active_monitor_cb.i_rden == 1)begin
        @(posedge vif.act_monitor_mp.clk)
        $display("\n write is high and Read is high");
       // item_got1.i_rddata = vif.act_monitor_mp.active_monitor_cb.i_rddata;
        item_got1.i_wren = 'b1;
        item_got1.i_rden = 'b1; 
        item_got1.i_wrdata = vif.act_monitor_mp.active_monitor_cb.i_wrdata;
        //item_got1.empty = vif.act_monitor_mp.active_monitor_cb.empty;
        item_got_port1.write(item_got1);
      end
    end
  endtask
endclass


