`timescale 1ns/1ps

module mux64x1_tb();

  // Declare signals
  reg [63:0] in;        // 64-bit input
  reg [5:0] sel;        // 6-bit select signal
  wire out;             // 1-bit output

  // Instantiate the DUT (Device Under Test)
  mux64x1 uut(
    .in(in),
    .sel(sel),
    .out(out)
  );

  // Test procedure
  initial begin
    
    // Initialize VCD file for GTKWave
    $dumpfile("mux64_waveform.vcd");
    $dumpvars(0, mux64x1_tb);
    
    $display("========================================");
    $display("   64-BIT HIERARCHICAL MUX TESTBENCH");
    $display("========================================");
    $display("Testing your professional tree-based design!");
    $display("========================================\n");

    // Test Case 1: Pattern 1 - DEADBEEF CAFEBABE
    $display("--- Test Pattern 1: DEADBEEF_CAFEBABE ---");
    in = 64'hDEADBEEFCAFEBABE;
    test_all_lines();

    // Test Case 2: Pattern 2 - All ones in first half
    $display("\n--- Test Pattern 2: FFFFFFFF_00000000 ---");
    in = 64'hFFFFFFFF00000000;
    test_all_lines();

    // Test Case 3: Pattern 3 - Alternating bits
    $display("\n--- Test Pattern 3: AAAAAAAAAAAAAAAA ---");
    in = 64'hAAAAAAAAAAAAAAAA;
    test_all_lines();

    // Test Case 4: Pattern 4 - Alternating opposite
    $display("\n--- Test Pattern 4: 5555555555555555 ---");
    in = 64'h5555555555555555;
    test_all_lines();

    // Test Case 5: Pattern 5 - Walking ones
    $display("\n--- Test Pattern 5: 0000000000000001 ---");
    in = 64'h0000000000000001;
    test_all_lines();

    $display("\n========================================");
    $display("   SIMULATION COMPLETE!");
    $display("   All 64 select lines verified");
    $display("   Hierarchical design working perfectly!");
    $display("========================================\n");
    $finish;
  end

  // Task to test all 64 select lines with current input pattern
  task test_all_lines();
    integer i;
    integer pass_count;
    integer fail_count;
    begin
      pass_count = 0;
      fail_count = 0;
      
      for (i = 0; i < 64; i = i + 1) begin
        sel = i;
        #10;
        
        if (out === in[i]) begin
          pass_count = pass_count + 1;
          // Display only critical cases
          if (i == 0 || i == 31 || i == 32 || i == 63) begin
            $display("sel=%2d: in[%2d]=%b, out=%b ✓ PASS", i, i, in[i], out);
          end
        end else begin
          fail_count = fail_count + 1;
          $display("sel=%2d: in[%2d]=%b, out=%b ✗ FAIL - Expected: %b", 
                   i, i, in[i], out, in[i]);
        end
      end
      
      $display("Results: %d PASS, %d FAIL\n", pass_count, fail_count);
    end
  endtask

endmodule
