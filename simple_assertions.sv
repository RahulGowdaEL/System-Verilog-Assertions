// Write an assertion to check a signal which should be high for atleast 2 cylces and atmost 10cycles.
property signal_cycle;
// logic signal_clk;
  @(posedge clk)
    disable iff(rst);
  $rose(valid) |-> signal_clk[*2:10];
endproperty

signal_clk_check: assert property(signal_cycle)
  $info("signal is high for atleast 2");
else 
  $error("Assertion signal_clk_check failed at %t");

// For a Syncronous fifo of depth 16 
//a. if the fifo word_count is > 15 one interrupt should flag
//b. if the fifo depth is already 15 filled, and a new operation happens without a simultaneous read  then also FIFO_full flag is set.

property fifo_depth;
  @(posedge write_en)
  disable iff (!rst)   //Active low reset
  (writer_pointer_count > 15) |-> $rose(fifo_interrupt);
endproperty

fifo_depth_check:
  assert property(fifo_depth)
    $info("interrupt is asserted as the depth is reached);
          else  $error("Assertion failed as interrupt modelling is wrong or the counter);

property fifo_depth;
  @(posedge write_en)
  disable iff (!rst)   //Active low reset
  ((writer_pointer_count == 15) && (write_en = 1) && (!read_en)) |-> fifo_full_flag;
endproperty

fifo_depth_check:
  assert property(fifo_depth)
else  $error("Assertion failed as interrupt modelling is wrong or the counter);

//Write a checker to check the output signal will never go 'x'

      propert undetermined_signal;
             always @(clk)
               disable iff(!rst or pwr_dwn)
               $rose(input/inout_signal) |=> !(output_signal==='x');  // isunknown(output_signal)
             endproperty

// Check if the 5bit grant signal is having only one bit setted at any time
             logic [4:0] grant;
property one_bit;
  @(negdege wck_t)
  disable iff(!rst or wait_req)
  $rose(req) |-> (onehot(grant));
endproperty

// check wheather after valid req is issued grant should come before 2:5 clk cycle

property req_grant;
  @(posegde clk)
  disable iff(rst)
  $rose(req) |=> ##[1:4] (grant);
endproperty

// as long as a signal_a is high signal_b should not be high at all

propert signal_cold_war;
 @(posegde clk)
  disable iff(rst)
      (signal_a) |-> !(signal_b);
  endproperty

// after a signal_a is asserted it should not be high thereafter for more than 1 clock cycle.

property signal_check;
 @(posegde clk)
  disable iff(!rst or pwr_dwn)
  $rose(signal_a) |=> $fell(signal_a);
endproperty

 //signal a and b can be asserted together but in the next any one needs to go low
             ($rose(signal_a) && $rose(signal_b) ) |=>  (signal_a or signal_b);  //($fell(signal_a) || $fell(signal_b));
             $rose(signal_a) |-> (signal_b until (signal_c or signal_d));

            


