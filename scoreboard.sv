class fifo_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(fifo_sequence_items, fifo_scoreboard) item_got_export1;
 // uvm_analysis_imp#(fifo_sequence_items, fifo_scoreboard) item_got_export2;
  `uvm_component_utils(fifo_scoreboard)
  
  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    item_got_export1 = new("item_got_export1", this);
   // item_got_export2 = new("item_got_export2", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  bit[127:0] queue[$];
  bit [127:0] local_var;

  function void write(input fifo_sequence_items item_got1);
    bit [127:0] data;
    if(item_got1.i_wren=='b1)
      begin
        if(queue.size()<1024)
          begin
            queue.push_back(item_got1.i_wren);
            `uvm_info("Data write operation", $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d",item_got1.i_wren, item_got1.i_rden,item_got1.i_wrdata), UVM_LOW);
          end
      end

    if (item_got1.i_rden == 'b1)
      begin
      if(queue.size() >= 'd1)
        begin
         data = queue.pop_front();
          `uvm_info("Data read operation", $sformatf("data: %0d , the read data is(local var)=%0d", data,local_var), UVM_LOW);
          if(data == local_var)
        $display("-----------Pass!-----------");
          else
        $display("-----------Fail!-----------");
        end
      end
  endfunction
endclass


class fifo_scoreboard2 extends fifo_scoreboard;
  
    //uvm_analysis_imp#(fifo_sequence_items, fifo_scoreboard) item_got_export1;
  uvm_analysis_imp#(fifo_sequence_items, fifo_scoreboard2) item_got_export2;
  `uvm_component_utils(fifo_scoreboard2)
  
  function new(string name = "fifo_scoreboard2", uvm_component parent);
    super.new(name, parent);
    //item_got_export1 = new("item_got_export1", this);
    item_got_export2 = new("item_got_export2", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(input fifo_sequence_items item_got2);
local_var=item_got2.o_rddata;
    if(queue.size()==1024)
      begin
        if(item_got2.o_full=='b1)
          begin
            $display("FIFO FULL:PASS");
          end
        else
          begin
            $display("FIFO FULL:FAIL");
          end
      end

    if(queue.size()>=1020 && queue.size()<1024)
      begin
        if(item_got2.o_alm_full=='b1)
          begin
            $display("FIFO ALMOST FULL: PASS");
          end
        else
          begin
            $display("FIFO ALMOST FULL:FAIL");
          end
      end

    if(queue.size()>0 && queue.size()<=2)
      begin
        if(item_got2.o_alm_empty=='b1)
          begin
            $display("FIFO ALMOST EMPTY: PASS");
          end
        else
          begin
            $display("FIFO ALMOST EMPTY:FAIL");
          end
      end

    
    if(queue.size()==0)
      begin
        if(item_got2.o_empty=='b1)
          begin
            $display("FIFO EMPTY: PASS");
          end
        else
          begin
            $display("FIFO EMPTY:FAIL");
          end
      end
  endfunction
endclass

