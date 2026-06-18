// sch_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc4.sch
module zlc4
(
  output wire V,
  output wire P1,
  output wire P0,
  input wire A3,
  input wire A2,
  input wire A1,
  input wire A0,
  input wire VDD,
  input wire GND
);
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;

sky130_fd_sc_hd__or2_1
x3 ( 
 .A( net1 ),
 .B( net2 ),
 .X( V )
);


sky130_fd_sc_hd__inv_1
x4 ( 
 .A( net1 ),
 .Y( P1 )
);


sky130_fd_sc_hd__mux2_1
x5 ( 
 .A0( net3 ),
 .A1( net4 ),
 .S( P1 ),
 .X( P0 )
);


zlc2
x1 ( 
 .HI( A3 ),
 .V( net1 ),
 .LO( A2 ),
 .P( net3 ),
 .VDD( VDD ),
 .GND( GND )
);


zlc2
x2 ( 
 .HI( A1 ),
 .V( net2 ),
 .LO( A0 ),
 .P( net4 ),
 .VDD( VDD ),
 .GND( GND )
);

endmodule

// expanding   symbol:  zlc2.sym # of pins=6
// sym_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc2.sym
// sch_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc2.sch
module zlc2
(
  input wire HI,
  output wire V,
  input wire LO,
  output wire P,
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
