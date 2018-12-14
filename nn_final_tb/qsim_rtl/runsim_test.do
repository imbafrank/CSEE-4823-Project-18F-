##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist
#vlog -incr ../rtl/compute_module.v

# Include Testbench
vlog -incr ../rtl/test_tb.v

# Run Simulator 
vsim -t ns -lib work test_tb 
do waveformat_test.do
run 1000ns
