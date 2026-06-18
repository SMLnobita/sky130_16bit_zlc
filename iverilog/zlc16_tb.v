`timescale 100ps / 100ps

module zlc16_tb();

reg [15:0] A;
reg VDD;
reg GND;

wire [4:0] Y;

integer i;
integer errors;
reg [4:0] expected_y;

zlc16 x1 (
  .A(A),
  .Y(Y),
  .VDD(VDD),
  .GND(GND)
);

function [4:0] lzc16;
  input [15:0] value;
  integer j;
  reg found;
  begin
    lzc16 = 5'd0;
    found = 1'b0;

    for (j = 15; j >= 0; j = j - 1) begin
      if (found == 1'b0) begin
        if (value[j] == 1'b0)
          lzc16 = lzc16 + 5'd1;
        else
          found = 1'b1;
      end
    end
  end
endfunction

initial begin
  $dumpfile("zlc16.vcd");
  $dumpvars(0, zlc16_tb);
end

initial begin
  VDD = 1'b1;
  GND = 1'b0;
  errors = 0;

  for (i = 0; i < 65536; i = i + 1) begin
    A = i;
    #10;

    expected_y = lzc16(A);

    if (Y !== expected_y) begin
      if (errors < 20) begin
        $display("ERROR A=%b Y=%b expected Y=%b", A, Y, expected_y);
      end
      errors = errors + 1;
    end
  end

  if (errors == 0) begin
    $display("---------------------------------------");
    $display("TEST PASSED: zlc16 all 65536 cases successful!");
    $display("---------------------------------------");
  end else begin
    $display("---------------------------------------");
    $display("TEST FAILED: zlc16 has %0d errors", errors);
    $display("---------------------------------------");
  end

  $finish;
end

endmodule
