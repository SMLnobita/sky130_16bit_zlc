`timescale 100ps / 100ps

module zlc4_tb();

reg [3:0] A;

wire V;
wire [1:0] P;

integer i;
integer errors;
reg [2:0] expected_lz;
reg expected_v;

zlc4 x1 (
  .A3(A[3]),
  .A2(A[2]),
  .A1(A[1]),
  .A0(A[0]),
  .V(V),
  .P1(P[1]),
  .P0(P[0])
);

function [2:0] lzc4;
  input [3:0] value;
  integer j;
  reg found;
  begin
    lzc4 = 0;
    found = 0;

    for (j = 3; j >= 0; j = j - 1) begin
      if (!found) begin
        if (value[j] == 1'b0)
          lzc4 = lzc4 + 1;
        else
          found = 1'b1;
      end
    end
  end
endfunction

initial begin
  $dumpfile("zlc4.vcd");
  $dumpvars(0, zlc4_tb);
end

initial begin
  errors = 0;

  for (i = 0; i < 16; i = i + 1) begin
    A = i;
    #10;

    expected_lz = lzc4(A);
    expected_v = (A != 4'b0000);

    if (V !== expected_v) begin
      $display("ERROR A=%b V=%b expected V=%b", A, V, expected_v);
      errors = errors + 1;
    end

    // Khi A = 0000 thì V=0, P là don't care nên không check P
    if (expected_v && (P !== expected_lz[1:0])) begin
      $display("ERROR A=%b P=%b expected P=%b", A, P, expected_lz[1:0]);
      errors = errors + 1;
    end
  end

  if (errors == 0) begin
    $display("---------------------------------------");
    $display("TEST PASSED: zlc4 all 16 cases successful!");
    $display("---------------------------------------");
  end else begin
    $display("---------------------------------------");
    $display("TEST FAILED: zlc4 has %0d errors", errors);
    $display("---------------------------------------");
  end

  $finish;
end

endmodule