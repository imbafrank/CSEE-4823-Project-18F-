`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #5

module ctrl_tb;

reg clk, rst, read_weights_finish, read_inputs_finish, compute_finish;

ctrl ctrl0
(	.clk(clk),
	.rst(rst),
	.read_weights_finish(read_weights_finish),
	.read_inputs_finish(read_inputs_finish),
	.compute_finish(compute_finish)
	);

always begin
  `HALF_CLOCK_PERIOD;
  clk = ~clk;
end

initial begin
	clk = 0;
	rst = 0;
	read_weights_finish = 0;
	read_inputs_finish = 0;
	compute_finish = 0;

	#10 rst = 1;
	#10 rst = 0;

	#200 read_weights_finish = 1;
	#10 read_weights_finish = 0;

	#200 read_inputs_finish = 1;
	#10 read_inputs_finish = 0;

	#200 compute_finish = 1;
	#10 compute_finish = 0;

end

endmodule