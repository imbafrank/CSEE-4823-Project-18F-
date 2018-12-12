`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #5
`define WEIGHT_FILE "./weight.results"
`define INPUT_FILE "./input.results"

module nn_tb;

parameter W_ADDR_LEN = 20;
parameter W_DATA_LEN = 1;
parameter W_SEL_LEN = 2;
parameter W_RW_LEN = 2;
parameter X_ADDR_LEN = 10;
parameter X_DATA_LEN = 1;
parameter X_SEL_LEN = 2;
parameter X_RW_LEN = 2;

integer weight_file, input_file;
integer ret_read;
integer i, value_read;


reg clk, rst;
reg start_compute;
reg [W_ADDR_LEN-1:0] w_addr;
reg [W_DATA_LEN-1:0] w_data;
reg [W_SEL_LEN-1:0] w_sel;
reg [W_RW_LEN-1:0] w_rw;
reg [X_ADDR_LEN-1:0] x_addr;
reg [X_DATA_LEN-1:0] x_data;
reg [X_SEL_LEN-1:0] x_sel;
reg [X_RW_LEN-1:0] x_rw;

reg write_w_finish;
reg write_x1_finish;


mem_sys mem_sys_w
(	
	.clk(clk),
	.rst(rst),
	.w_addr(w_addr),
	.w_data(w_data),
	.w_sel(w_sel),
	.w_rw(w_rw)
	);

mem_sys mem_sys_x
(	
	.clk(clk),
	.rst(rst),
	.x_addr(x_addr),
	.x_data(x_data),
	.x_sel(x_sel),
	.x_rw(x_rw)
	);

compute_module compute_module_i
(
	.start_compute(start_compute))

always begin
  `HALF_CLOCK_PERIOD;
  clk = ~clk;
end

initial begin
	clk = 0;
	rst = 0;

	w_addr = 0;
	w_data = 0;
	w_sel = 0;
	w_rw = 0;
	x_addr = 0;
	x_data = 0;
	x_sel = 0;
	x_rw = 0;
	start_compute = 0;

	weight_file = $fopen(`WEIGHT_FILE,"r");
	if (!weight_file)
	begin
		$display("Couldn't open the weight file.");
		$finish;
	end
	else begin
		$display("Weight file opened.");
	end

	input_file = $fopen(`WEIGHT_FILE,"r");
	if (!input_file)
	begin
		$display("Couldn't open the input file.");
		$finish;
	end
	else begin
		$display("Input file opened.");
	end
	// reset
	#10 rst = 1;
	#10 rst = 0;
	// start reading weight1
	#10 w_sel = 0;
	@(posedge);
	for (i=0; i<8; i=i+1) begin
		ret_read = $fscanf(weight_file, "%d", value_read);
		w_addr <= i;
		w_data <= value_read;
		@(posedge clk);
	end

	// start reading weight2
	#10 w_sel = 1;
	@(posedge);
	for (i=0; i<8; i=i+1) begin
		ret_read = $fscanf(weight_file, "%d", value_read);
		w_addr <= i;
		w_data <= value_read;
		@(posedge clk);
	end

	// start reading weight3
	#10 w_sel = 2;
	@(posedge);
	for (i=0; i<8; i=i+1) begin
		ret_read = $fscanf(weight_file, "%d", value_read);
		w_addr <= i;
		w_data <= value_read;
		@(posedge clk);
	end

	// start reading weight4
	#10 w_sel = 3;
	@(posedge);
	for (i=0; i<8; i=i+1) begin
		ret_read = $fscanf(weight_file, "%d", value_read);
		w_addr <= i;
		w_data <= value_read;
		@(posedge clk);
	end

	// start reading input
	#10 x_sel = 0;
	@(posedge);
	for (i=0; i<8; i=i+1) begin
		ret_read = $fscanf(input_file, "%d", value_read);
		x_addr <= i;
		x_data <= value_read;
		@(posedge clk);
	end


end



endmodule