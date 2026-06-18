v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -310 -70 -140 -70 {lab=#net1}
N -220 50 -140 50 {lab=#net1}
N -220 -70 -220 50 {lab=#net1}
N -240 -30 -140 -30 {lab=#net2}
N -240 -30 -240 130 {lab=#net2}
N -340 130 -240 130 {lab=#net2}
N -310 -50 -260 -50 {lab=#net3}
N -260 -50 -260 150 {lab=#net3}
N -260 150 -140 150 {lab=#net3}
N -340 150 -280 150 {lab=#net4}
N -280 150 -280 190 {lab=#net4}
N -280 190 -140 190 {lab=#net4}
N -20 -50 80 -50 {lab=V}
N -60 50 80 50 {lab=P1}
N -60 170 90 170 {lab=P0}
N -140 230 -140 270 {lab=P1}
N -140 270 20 270 {lab=P1}
N 20 50 20 270 {lab=P1}
C {sky130_stdcells/or2_1.sym} -80 -50 0 0 {name=x3 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_1.sym} -100 50 0 0 {name=x4 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/mux2_1.sym} -100 170 0 0 {name=x5 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {ipin.sym} -610 -70 0 0 {name=p1 lab=A3}
C {ipin.sym} -610 -50 0 0 {name=p2 lab=A2}
C {ipin.sym} -640 130 0 0 {name=p3 lab=A1}
C {ipin.sym} -640 150 0 0 {name=p4 lab=A0}
C {opin.sym} 80 -50 0 0 {name=p5 lab=V}
C {opin.sym} 80 50 0 0 {name=p6 lab=P1}
C {opin.sym} 90 170 0 0 {name=p7 lab=P0}
C {zlc2.sym} -460 -40 0 0 {name=x1}
C {zlc2.sym} -490 160 0 0 {name=x2}
C {lab_pin.sym} -640 170 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -640 190 0 0 {name=p9 sig_type=std_logic lab=GND}
C {lab_pin.sym} -610 -10 0 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -610 -30 0 0 {name=p11 sig_type=std_logic lab=VDD}
C {ipin.sym} -820 230 0 0 {name=p12 lab=VDD}
C {ipin.sym} -820 270 0 0 {name=p13 lab=GND}
