`timescale 100ps / 100ps

module zlc2_tb();

reg HI;
reg LO;
reg VDD;
reg GND;

wire V;
wire P;

zlc2 x1 (
  .HI(HI),
  .LO(LO),
  .VDD(VDD),
  .GND(GND),
  .V(V),
  .P(P)
);

initial begin
  $dumpfile("zlc2.vcd");
  $dumpvars(0, zlc2_tb);
end

initial begin
  VDD = 1'b1;
  GND = 1'b0;

  HI = 0; LO = 0; #10;
  if (V !== 0 || P !== 1) begin
    $display("ERROR HI=%b LO=%b V=%b P=%b", HI, LO, V, P);
    $finish;
  end

  HI = 0; LO = 1; #10;
  if (V !== 1 || P !== 1) begin
    $display("ERROR HI=%b LO=%b V=%b P=%b", HI, LO, V, P);
    $finish;
  end

  HI = 1; LO = 0; #10;
  if (V !== 1 || P !== 0) begin
    $display("ERROR HI=%b LO=%b V=%b P=%b", HI, LO, V, P);
    $finish;
  end

  HI = 1; LO = 1; #10;
  if (V !== 1 || P !== 0) begin
    $display("ERROR HI=%b LO=%b V=%b P=%b", HI, LO, V, P);
    $finish;
  end

  $display("---------------------------------------");
  $display("TEST PASSED: zlc2 successful!");
  $display("---------------------------------------");
  $finish;
end

endmodule