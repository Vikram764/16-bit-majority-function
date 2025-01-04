// Testbench for majority16 module
module majority16_test;
  // Declare inputs and outputs
  reg [15:0] Data;
  wire Out;

  // Parameter for reading test ID from STDIN
  parameter STDIN = 32'h8000_0000;
  integer testid;
  integer ret;

  // Instantiate the majority16 module
  majority16 m16 (
    .Out(Out),
    .Data(Data)
  );

  // Testbench logic
  initial begin
    // Monitor signals for GTKWave
    $dumpfile("majority16_test.vcd");
    $dumpvars(0, majority16_test);

    // Read the test case ID from input
    ret = $fscanf(STDIN, "%d", testid);

    // Apply test cases based on the test ID
    case (testid)
      0: begin #5 Data = 16'b1001000101111101; end
      1: begin #5 Data = 16'b0101010101010101; end
      2: begin #5 Data = 16'b1111001101010101; end
      3: begin #5 Data = 16'b0010111111011110; end
      4: begin #5 Data = 16'b1111111111111111; end
      5: begin #5 Data = 16'b1111010110101111; end
      6: begin #5 Data = 16'b1111100000110000; end
      7: begin #5 Data = 16'b0; end
      default: begin
        $display("Bad testcase ID %d", testid);
        $finish();
      end
    endcase

    // Wait for the output to stabilize
    #5;

    // Validate the output against expected results
    if ((testid == 0 && Out == 1'b1) ||
        (testid == 1 && Out == 1'b0) ||
        (testid == 2 && Out == 1'b1) ||
        (testid == 3 && Out == 1'b1) ||
        (testid == 4 && Out == 1'b1) ||
        (testid == 5 && Out == 1'b1) ||
        (testid == 6 && Out == 1'b0) ||
        (testid == 7 && Out == 1'b0))
      pass();
    else
      fail();
  end

  // Task for test case pass
  task pass;
    begin
      $display("Pass: Data=%b => Out=%b", Data, Out);
      $finish();
    end
  endtask

  // Task for test case fail
  task fail;
    begin
      $display("Fail: Data=%b => Out!=%b", Data, Out);
      $finish();
    end
  endtask
endmodule
