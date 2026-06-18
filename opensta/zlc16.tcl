# -----------------------------------------------------------
# OpenSTA script for 16-bit Zero Leading Counter (zlc16)
# -----------------------------------------------------------

# Load SKY130 standard cell timing library
read_liberty $env(PDK_ROOT)/$env(PDK)/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Load Verilog netlist from Xschem
read_verilog ../xschem/zlc16.v

# Set top module
link_design zlc16

# -----------------------------------------------------------
# Timing constraints
# -----------------------------------------------------------

# Virtual clock for combinational timing analysis
# 10 ns period = 100 MHz
create_clock -name clk -period 10.0

# Input delay for A[15:0]
set_input_delay -max 0.0 -clock clk [get_ports {A[*]}]
set_input_delay -min 0.0 -clock clk [get_ports {A[*]}]

# Output delay for Y[4:0]
set_output_delay -max 0.2 -clock clk [get_ports {Y[*]}]
set_output_delay -min -0.02 -clock clk [get_ports {Y[*]}]

# Input drive strength
set_driving_cell -cell sky130_fd_sc_hd__inv_2 -pin Y [get_ports {A[*]}]

# Output load capacitance
set_load 0.01 [get_ports {Y[*]}]

# -----------------------------------------------------------
# Reports
# -----------------------------------------------------------

report_units

# Max delay / setup path
report_checks -path_delay max -fields {slew cap input fanout} -format full_clock_expanded

# Min delay / hold path
report_checks -path_delay min -fields {slew cap input fanout} -format full_clock_expanded

# Slack summary
report_tns
report_wns

# Power estimation
report_power

exit