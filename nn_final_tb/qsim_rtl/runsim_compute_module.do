##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist
vlog -incr ../rtl/alu.v
vlog -incr ../rtl/agg.v
vlog -incr ../rtl/alu.v
vlog -incr ../rtl/calc.v
vlog -incr ../rtl/compute_module.v
#vlog -incr ../rtl/mem_1.v

# Include Testbench
vlog -incr ../rtl/compute_module_tb.v

# Run Simulator 
vsim -t ns -lib work compute_module_tb
do waveformat_compute_module.do
run -all
