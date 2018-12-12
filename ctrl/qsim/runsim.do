##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist
vlog -incr ../rtl/ctrl.v

# Include Testbench
vlog -incr ../rtl/ctrl_tb.v

# Run Simulator 
vsim -t ns -lib work ctrl_tb 
do waveformat.do   
run 1000ns
