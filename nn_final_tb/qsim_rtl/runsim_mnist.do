##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist
#vlog -incr ../rtl/compute_module.v
#vlog -incr ../rtl/mem_sys_new.v
vlog -incr ../rtl/mnist_nn.v

# Include Testbench
vlog -incr ../rtl/mnist_nn_tb.v

# Run Simulator 
vsim -t ns -lib work mnist_nn_tb
do waveformat_mnist.do
run -all
