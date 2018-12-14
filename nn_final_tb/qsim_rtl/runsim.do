##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist
vlog -incr ../rtl/compute_module.v

# Include Testbench
vlog -incr ../rtl/nn_final_tb.v

# Run Simulator 
vsim -t ns -lib work nn_tb 
do waveformat.do   
run 1000ns
