v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -310 160 -310 {lab=#net1}
N 50 -180 180 -180 {lab=#net1}
N 50 -310 50 -180 {lab=#net1}
N -60 -290 30 -290 {lab=#net2}
N 30 -290 30 -80 {lab=#net2}
N 30 -80 180 -80 {lab=#net2}
N -60 -60 140 -60 {lab=#net3}
N 140 -60 140 -40 {lab=#net3}
N 140 -40 180 -40 {lab=#net3}
N -60 -270 -20 -270 {lab=#net4}
N -20 -270 -20 60 {lab=#net4}
N -20 60 190 60 {lab=#net4}
N -60 -40 80 -40 {lab=#net5}
N 80 -40 80 100 {lab=#net5}
N 80 100 190 100 {lab=#net5}
N -60 -250 130 -250 {lab=#net6}
N 130 -250 130 200 {lab=#net6}
N 130 200 130 210 {lab=#net6}
N 130 210 190 210 {lab=#net6}
N -60 -20 50 -20 {lab=#net7}
N 50 -20 50 250 {lab=#net7}
N 50 250 190 250 {lab=#net7}
N 260 -180 470 -180 {lab=#net8}
N 260 -60 480 -60 {lab=#net9}
N 270 80 490 80 {lab=#net10}
N 270 230 480 230 {lab=#net11}
N 410 -140 470 -140 {lab=#net12}
N 420 -20 480 -20 {lab=#net12}
N 410 -20 420 -20 {lab=#net12}
N 410 270 480 270 {lab=#net12}
N 410 120 490 120 {lab=#net12}
N 180 0 180 20 {lab=#net8}
N 180 20 310 20 {lab=#net8}
N 310 -180 310 20 {lab=#net8}
N 190 140 190 170 {lab=#net8}
N 190 170 310 170 {lab=#net8}
N 310 20 310 170 {lab=#net8}
N 190 290 310 290 {lab=#net8}
N 310 170 310 290 {lab=#net8}
N 280 -290 480 -290 {lab=#net12}
N 410 -290 410 270 {lab=#net12}
N -60 -80 10 -80 {lab=#net13}
N 10 -270 10 -80 {lab=#net13}
N 10 -270 160 -270 {lab=#net13}
C {sky130_stdcells/or2_1.sym} 220 -290 0 0 {name=x3 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_1.sym} 220 -180 0 0 {name=x4 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/mux2_1.sym} 230 230 0 0 {name=x5 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/mux2_1.sym} 230 80 0 0 {name=x6 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/mux2_1.sym} 220 -60 0 0 {name=x7 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/and2_1.sym} 530 -160 0 0 {name=x8 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/and2_1.sym} 540 -40 0 0 {name=x9 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/and2_1.sym} 550 100 0 0 {name=x10 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/and2_1.sym} 540 250 0 0 {name=x11 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_1.sym} 520 -290 0 0 {name=x12 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {lab_pin.sym} -360 -310 0 0 {name=p1 lab=A[15]}
C {lab_pin.sym} -360 -290 0 0 {name=p2 lab=A[14]}
C {lab_pin.sym} -360 -270 0 0 {name=p3 lab=A[13]}
C {lab_pin.sym} -360 -250 0 0 {name=p4 lab=A[12]}
C {lab_pin.sym} -360 -230 0 0 {name=p5 lab=A[11]}
C {lab_pin.sym} -360 -210 0 0 {name=p6 lab=A[10]}
C {lab_pin.sym} -360 -190 0 0 {name=p7 lab=A[9]}
C {lab_pin.sym} -360 -170 0 0 {name=p8 lab=A[8]}
C {lab_pin.sym} -360 -80 0 0 {name=p9 lab=A[7]}
C {lab_pin.sym} -360 -60 0 0 {name=p10 lab=A[6]}
C {lab_pin.sym} -360 -40 0 0 {name=p11 lab=A[5]}
C {lab_pin.sym} -360 -20 0 0 {name=p12 lab=A[4]}
C {lab_pin.sym} -360 0 0 0 {name=p13 lab=A[3]}
C {lab_pin.sym} -360 20 0 0 {name=p14 lab=A[2]}
C {lab_pin.sym} -360 40 0 0 {name=p15 lab=A[1]}
C {lab_pin.sym} -360 60 0 0 {name=p16 lab=A[0]}
C {lab_pin.sym} 560 -290 0 1 {name=p17 lab=Y[4]}
C {lab_pin.sym} 590 -160 0 1 {name=p18 lab=Y[3]}
C {lab_pin.sym} 600 -40 0 1 {name=p19 lab=Y[2]}
C {lab_pin.sym} 610 100 0 1 {name=p20 lab=Y[1]}
C {lab_pin.sym} 600 250 0 1 {name=p21 lab=Y[0]}
C {zlc8.sym} -210 -220 0 0 {name=x1}
C {zlc8.sym} -210 10 0 0 {name=x2}
C {ipin.sym} -680 230 0 0 {name=p22 lab=VDD}
C {ipin.sym} -680 250 0 0 {name=p23 lab=GND}
C {lab_pin.sym} -360 -150 0 0 {name=p24 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -360 -130 0 0 {name=p25 sig_type=std_logic lab=GND}
C {lab_pin.sym} -360 80 0 0 {name=p26 sig_type=std_logic lab=VDD}
C {lab_pin.sym} -360 100 0 0 {name=p27 sig_type=std_logic lab=GND}
C {ipin.sym} -680 200 0 0 {name=p28 lab=A[15:0]}
C {opin.sym} -660 200 0 0 {name=p29 lab=Y[4:0]}
