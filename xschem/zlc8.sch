v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 -240 10 -240 {lab=#net1}
N 10 -240 130 -240 {lab=#net1}
N 70 -150 130 -150 {lab=#net1}
N 70 -240 70 -150 {lab=#net1}
N -20 -220 30 -220 {lab=#net2}
N 30 -220 30 -80 {lab=#net2}
N 30 -80 140 -80 {lab=#net2}
N -10 -100 110 -100 {lab=#net3}
N 110 -200 110 -100 {lab=#net3}
N 110 -200 130 -200 {lab=#net3}
N -10 -80 20 -80 {lab=#net4}
N 20 -80 20 -40 {lab=#net4}
N 20 -40 140 -40 {lab=#net4}
N -20 -200 10 -200 {lab=#net5}
N 10 -200 10 30 {lab=#net5}
N 10 30 60 30 {lab=#net5}
N -10 -60 -10 70 {lab=#net6}
N -10 70 60 70 {lab=#net6}
N 60 110 60 150 {lab=P2}
N 60 150 290 150 {lab=P2}
N 210 -150 330 -150 {lab=P2}
N 290 -150 290 150 {lab=P2}
N 140 0 290 0 {lab=P2}
N 250 -220 350 -220 {lab=V}
N 220 -60 360 -60 {lab=P1}
N 140 50 360 50 {lab=P0}
C {sky130_stdcells/or2_1.sym} 190 -220 0 0 {name=x3 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_1.sym} 170 -150 0 0 {name=x4 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/mux2_1.sym} 180 -60 0 0 {name=x5 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/mux2_1.sym} 100 50 0 0 {name=x6 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {ipin.sym} -320 -240 0 0 {name=p1 lab=A7}
C {ipin.sym} -320 -220 0 0 {name=p2 lab=A6}
C {ipin.sym} -320 -200 0 0 {name=p3 lab=A5}
C {ipin.sym} -320 -180 0 0 {name=p4 lab=A4}
C {ipin.sym} -310 -100 0 0 {name=p5 lab=A3}
C {ipin.sym} -310 -80 0 0 {name=p6 lab=A2}
C {ipin.sym} -310 -60 0 0 {name=p7 lab=A1}
C {ipin.sym} -310 -40 0 0 {name=p8 lab=A0}
C {opin.sym} 350 -220 0 0 {name=p9 lab=V}
C {opin.sym} 330 -150 0 0 {name=p10 lab=P2}
C {opin.sym} 360 -60 0 0 {name=p11 lab=P1}
C {opin.sym} 360 50 0 0 {name=p12 lab=P0}
C {zlc4.sym} -170 -190 0 0 {name=x1}
C {zlc4.sym} -160 -50 0 0 {name=x2}
C {ipin.sym} -530 60 0 0 {name=p13 lab=VDD}
C {ipin.sym} -530 90 0 0 {name=p14 lab=GND}
C {lab_pin.sym} -320 -160 0 0 {name=p15 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -320 -140 0 0 {name=p16 sig_type=std_logic lab=GND}
C {lab_pin.sym} -310 -20 0 0 {name=p17 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -310 0 0 0 {name=p18 sig_type=std_logic lab=GND}
