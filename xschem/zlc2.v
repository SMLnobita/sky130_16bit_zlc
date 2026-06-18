// sch_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc2.sch
module zlc2
(
  output wire V,
  output wire P,
  input wire HI,
  input wire LO,
  input wire VDD,
  input wire GND
);
sky130_fd_sc_hd__or2_1
x1 ( 
 .A( HI ),
 .B( LO ),
 .X( V )
);


sky130_fd_sc_hd__inv_1
x2 ( 
 .A( HI ),
 .Y( P )
);

endmodule
