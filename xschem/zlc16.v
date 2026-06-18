// sch_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc16.sch
module zlc16
(
  output wire [4:0] Y,
  input wire VDD,
  input wire GND,
  input wire [15:0] A
);
wire net10 ;
wire net11 ;
wire net12 ;
wire net13 ;
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire net5 ;
wire net6 ;
wire net7 ;
wire net8 ;
wire net9 ;

sky130_fd_sc_hd__or2_1
x3 ( 
 .A( net1 ),
 .B( net13 ),
 .X( net12 )
);


sky130_fd_sc_hd__inv_1
x4 ( 
 .A( net1 ),
 .Y( net8 )
);


sky130_fd_sc_hd__mux2_1
x5 ( 
 .A0( net6 ),
 .A1( net7 ),
 .S( net8 ),
 .X( net11 )
);


sky130_fd_sc_hd__mux2_1
x6 ( 
 .A0( net4 ),
 .A1( net5 ),
 .S( net8 ),
 .X( net10 )
);


sky130_fd_sc_hd__mux2_1
x7 ( 
 .A0( net2 ),
 .A1( net3 ),
 .S( net8 ),
 .X( net9 )
);


sky130_fd_sc_hd__and2_1
x8 ( 
 .A( net8 ),
 .B( net12 ),
 .X( Y[3] )
);


sky130_fd_sc_hd__and2_1
x9 ( 
 .A( net9 ),
 .B( net12 ),
 .X( Y[2] )
);


sky130_fd_sc_hd__and2_1
x10 ( 
 .A( net10 ),
 .B( net12 ),
 .X( Y[1] )
);


sky130_fd_sc_hd__and2_1
x11 ( 
 .A( net11 ),
 .B( net12 ),
 .X( Y[0] )
);


sky130_fd_sc_hd__inv_1
x12 ( 
 .A( net12 ),
 .Y( Y[4] )
);


zlc8
x1 ( 
 .A7( A[15] ),
 .A6( A[14] ),
 .V( net1 ),
 .A5( A[13] ),
 .A4( A[12] ),
 .P2( net2 ),
 .A3( A[11] ),
 .A2( A[10] ),
 .P1( net4 ),
 .A1( A[9] ),
 .A0( A[8] ),
 .P0( net6 ),
 .VDD( VDD ),
 .GND( GND )
);


zlc8
x2 ( 
 .A7( A[7] ),
 .A6( A[6] ),
 .V( net13 ),
 .A5( A[5] ),
 .A4( A[4] ),
 .P2( net3 ),
 .A3( A[3] ),
 .A2( A[2] ),
 .P1( net5 ),
 .A1( A[1] ),
 .A0( A[0] ),
 .P0( net7 ),
 .VDD( VDD ),
 .GND( GND )
);

endmodule

// expanding   symbol:  zlc8.sym # of pins=14
// sym_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc8.sym
// sch_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc8.sch
module zlc8
(
  input wire A7,
  input wire A6,
  output wire V,
  input wire A5,
  input wire A4,
  output wire P2,
  input wire A3,
  input wire A2,
  output wire P1,
  input wire A1,
  input wire A0,
  output wire P0,
  input wire VDD,
  input wire GND
);
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire net5 ;
wire net6 ;


sky130_fd_sc_hd__or2_1
x3 ( 
 .A( net1 ),
 .B( net3 ),
 .X( V )
);


sky130_fd_sc_hd__inv_1
x4 ( 
 .A( net1 ),
 .Y( P2 )
);


sky130_fd_sc_hd__mux2_1
x5 ( 
 .A0( net2 ),
 .A1( net4 ),
 .S( P2 ),
 .X( P1 )
);


sky130_fd_sc_hd__mux2_1
x6 ( 
 .A0( net5 ),
 .A1( net6 ),
 .S( P2 ),
 .X( P0 )
);


zlc4
x1 ( 
 .A3( A7 ),
 .V( net1 ),
 .A2( A6 ),
 .P1( net2 ),
 .A1( A5 ),
 .A0( A4 ),
 .P0( net5 ),
 .VDD( VDD ),
 .GND( GND )
);


zlc4
x2 ( 
 .A3( A3 ),
 .V( net3 ),
 .A2( A2 ),
 .P1( net4 ),
 .A1( A1 ),
 .A0( A0 ),
 .P0( net6 ),
 .VDD( VDD ),
 .GND( GND )
);

endmodule

// expanding   symbol:  zlc4.sym # of pins=9
// sym_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc4.sym
// sch_path: /home/me/Desktop/Project/sky130_adder_4bit/xschem/zlc4.sch
module zlc4
(
  input wire A3,
  output wire V,
  input wire A2,
  output wire P1,
  input wire A1,
  input wire A0,
  output wire P0,
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
