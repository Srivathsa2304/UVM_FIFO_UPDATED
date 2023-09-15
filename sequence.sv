class fifo_sequence extends uvm_sequence #(fifo_sequence_items);
  `uvm_object_utils(fifo_sequence)
  
  function new(string name = "fifo_sequence");
    super.new(name);
  endfunction

  virtual task body();
    //continuous writes
    `uvm_info(get_type_name(), $sformatf("** Generate 1024 Write transactions**"), UVM_LOW);
    repeat(20)
      begin
         req = fifo_sequence_items::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {i_wren == 1;i_rden == 0;});
        finish_item(req);
      end
    //continuous reads
    `uvm_info(get_type_name(), $sformatf("** Generate 1024 read transactions**"), UVM_LOW);
    repeat(20)
      begin
         req = fifo_sequence_items::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {i_wren == 0;i_rden == 1;});
        finish_item(req);
      end
   //IDLE condition, both write and read enables are 0
    `uvm_info(get_type_name(), $sformatf("**Idle condition**"), UVM_LOW);
    repeat(20)
      begin
         req = fifo_sequence_items::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {i_wren == 0;i_rden == 0;});
        finish_item(req);
      end

    // Parallel write and read 
    `uvm_info(get_type_name(), $sformatf("**Parallel write and read**"), UVM_LOW);
    repeat(20)
      begin
         req = fifo_sequence_items::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {i_wren == 1;i_rden == 1;});
        finish_item(req);
      end
    
    //Alternate write and read
    `uvm_info(get_type_name(), $sformatf("**Alternate write and read**"), UVM_LOW);
    repeat(20)
      begin
         req = fifo_sequence_items::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {i_wren == 1;i_rden == 0;});
        finish_item(req);
        
         req = fifo_sequence_items::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {i_wren == 0;i_rden == 1;});
        finish_item(req);
      end 
  endtask
endclass
      
    

