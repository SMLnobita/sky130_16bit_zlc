`timescale 100ps / 100ps

module zlc8_tb();

reg [7:0] A;

wire V;
wire [2:0] P;

integer i;
integer errors;
reg [3:0] expected_lz;
reg expected_v;

zlc8 x1 (
  .A7(A[7]),
  .A6(A[6]),
  .A5(A[5]),
  .A4(A[4]),
  .A3(A[3]),
  .A2(A[2]),
  .A1(A[1]),
  .A0(A[0]),
  .V(V),
  .P2(P[2]),
  .P1(P[1]),
  .P0(P[0])
);

function [3:0] lzc8;
  input [7:0] value;
  integer j;
  reg found;
  begin
    lzc8 = 0;
    found = 0;

    for (j = 7; j >= 0; j = j - 1) begin
      if (!found) begin
        if (value[j] == 1'b0)
          lzc8 = lzc8 + 1;
        else
          found = 1'b1;
      end
    end
  end
endfunction

initial begin
  $dumpfile("zlc8.vcd");
  $dumpvars(0, zlc8_tb);
end

initial begin
  errors = 0;

  for (i = 0; i < 256; i = i + 1) begin
    A = i;
    #10;

    expected_lz = lzc8(A);
    expected_v = (A != 8'b00000000);

    if (V !== expected_v) begin
      $display("ERROR A=%b V=%b expected V=%b", A, V, expected_v);
      errors = errors + 1;
    end

    // Khi A = 00000000 thì V=0, P là don't care nên không check P
    if (expected_v && (P !== expected_lz[2:0])) begin
      $display("ERROR A=%b P=%b expected P=%b", A, P, expected_lz[2:0]);
      errors = errors + 1;
    end
  end

  if (errors == 0) begin
    $display("---------------------------------------");
    $display("TEST PASSED: zlc8 all 256 cases successful!");
    $display("---------------------------------------");
  end else begin
    $display("---------------------------------------");
    $display("TEST FAILED: zlc8 has %0d errors", errors);
    $display("---------------------------------------");
  end

  $finish;
end

endmodule