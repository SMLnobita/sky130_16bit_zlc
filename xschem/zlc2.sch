v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -170 -70 -60 -70 {lab=HI}
N -120 60 -50 60 {lab=HI}
N -120 -70 -120 60 {lab=HI}
N -200 -30 -60 -30 {lab=LO}
N 60 -50 250 -50 {lab=V}
N 30 60 260 60 {lab=P}
C {sky130_stdcells/or2_1.sym} 0 -50 0 0 {name=x1 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_1.sym} -10 60 0 0 {name=x2 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {ipin.sym} -170 -70 0 0 {name=p1 lab=HI}
C {ipin.sym} -200 -30 0 0 {name=p2 lab=LO}
C {opin.sym} 250 -50 0 0 {name=p3 lab=V}
C {opin.sym} 260 60 0 0 {name=p4 lab=P}
C {ipin.sym} -370 90 0 0 {name=p5 lab=VDD}
C {ipin.sym} -370 120 0 0 {name=p6 lab=GND}
