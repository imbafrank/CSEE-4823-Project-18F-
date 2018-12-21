`timescale 1ns / 1ps

`define HALF_CLOCK_PERIOD #5
`define WEIGHT1_FILE "../data/weights/weight0.result"
`define WEIGHT2_FILE "../data/weights/weight1.result"
`define WEIGHT3_FILE "../data/weights/weight2.result"
`define WEIGHT4_FILE "../data/weights/weight3.result"
`define INPUT_FILE "../data/input_files/inputs_0.result"

module mnist_nn_tb;

parameter W_ADDR_LEN = 20;
parameter W_DATA_LEN = 1;
parameter W_SEL_LEN = 2;
// parameter W_RW_LEN = 2;
parameter X_ADDR_LEN = 10;
parameter X_DATA_LEN = 1;
parameter X_SEL_LEN = 2;
// parameter X_RW_LEN = 2;

integer weight1_file, weight2_file, weight3_file, weight4_file, input_file;
integer ret_read;
integer i, value_read;


reg clk, rst, rst_mem;
reg en_compute;

// wire wx_write;
// wire [W_ADDR_LEN-1:0] w_addr;
// wire [W_DATA_LEN-1:0] w_data;
// wire [W_SEL_LEN-1:0] w_sel;
// // wire [W_RW_LEN-1:0] w_rw;
// // wire w_rq;
// wire w_wq;
// wire [X_ADDR_LEN-1:0] x_addr;
// wire [X_DATA_LEN-1:0] x_data;
// wire [X_SEL_LEN-1:0] x_sel;
// // wire [X_RW_LEN-1:0] x_rw;
// // wire x_rq;
// wire x_wq;

// wire wx_write_wire;
// wire [W_ADDR_LEN-1:0] w_addr_wire;
// wire [W_DATA_LEN-1:0] w_data_wire;
// wire [W_SEL_LEN-1:0] w_sel_wire;
// // wire [W_RW_LEN-1:0] w_rw_wire;
// // wire w_rq_wire;
// wire w_wq_wire;
// wire [X_ADDR_LEN-1:0] x_addr_wire;
// wire [X_DATA_LEN-1:0] x_data_wire;
// wire [X_SEL_LEN-1:0] x_sel_wire;
// // wire [X_RW_LEN-1:0] x_rw_wire;
// // wire x_rq_wire;
// wire x_wq_wire;

reg wx_write_reg;
// reg wx_read_reg;

reg [W_ADDR_LEN-1:0] w_addr_reg;
reg [W_DATA_LEN-1:0] w_data_reg;
reg [W_SEL_LEN-1:0] w_sel_reg;
// reg [W_RW_LEN-1:0] w_rw_reg;
// reg w_rq_reg;
reg w_wq_reg;
reg [X_ADDR_LEN-1:0] x_addr_reg;
reg [X_DATA_LEN-1:0] x_data_reg;
reg [X_SEL_LEN-1:0] x_sel_reg;
// reg [X_RW_LEN-1:0] x_rw_reg;
// reg x_rq_reg;
reg x_wq_reg;

reg load_compute_ctrl;

reg write_w_finish;
reg write_x1_finish;

mnist_nn mnist_nn_i
(
	.clk(clk),
	// .rst(rst),
	.load_compute_ctrl(load_compute_ctrl),
	.en_compute(en_compute),
	.w_wq_oc(w_wq_reg),
	.x_wq_oc(x_wq_reg),
	.w_addr_oc(w_addr_reg),
	.x_addr_oc(x_addr_reg),
	.wx_write_oc(wx_write_reg),
	.x_data_oc(x_data_reg),
	.w_data_oc(w_data_reg),
	.x_sel_oc(x_sel_reg),
	.w_sel_oc(w_sel_reg),
	.compute_finish(compute_finish)
	);


// mem_sys mem_sys_i
// (	
// 	.clk(clk),
// 	// .rst(rst_mem),
// 	// .read_rq_x(x_rq),
// 	// .read_rq_w(w_rq),
// 	// .write_rq_x(x_wq),
// 	// .write_rq_w(w_wq),
// 	.we_w(w_wq),
// 	.we_x(x_wq),
// 	.address_w(w_addr),
// 	.address_x(x_addr),
// 	.data_in(wx_write),
// 	.data_out_x(x_data),
// 	.data_out_w(w_data),
// 	.sel_x(x_sel),
// 	.sel_w(w_sel)
// 	// .w_data(w_data),
// 	// .w_sel(w_sel),
// 	// .w_rw(w_rw)
// 	);

// mem_sys mem_sys_x
// (	
// 	.clk(clk),
// 	.rst(rst),
// 	.x_addr(x_addr),
// 	.x_data(x_data),
// 	.x_sel(x_sel),
// 	.x_rw(x_rw)
// 	);

// compute_module compute_module_i
// (
// 	.clk(clk),
// 	.rst(rst),
// 	.en(en_compute),
// 	.compute_finish(compute_finish),

// 	.w_addr(w_addr_wire),
// 	.w_data(w_data_wire),
// 	.w_sel(w_sel_wire),
// 	.w_rw(w_rw_wire),
// 	.x_addr(x_addr_wire),
// 	.x_data(x_data_wire),
// 	.x_sel(x_sel_wire),
// 	.x_rw(x_rw_wire)
// 	)
// assign wx_write = load_compute_ctrl? wx_write_reg : wx_write_wire;

// assign w_addr = load_compute_ctrl? w_addr_reg : w_addr_wire;
// assign w_data = load_compute_ctrl? w_data_reg : w_data_wire;
// assign w_sel = load_compute_ctrl? w_sel_reg : w_sel_wire;
// // assign w_rw = load_compute_ctrl? w_rw_reg : w_rw_wire;
// // assign w_rq = load_compute_ctrl? w_rq_reg : w_rq_wire;
// assign w_wq = load_compute_ctrl? w_wq_reg : w_wq_wire;

// assign x_addr = load_compute_ctrl? x_addr_reg : x_addr_wire;
// assign x_data = load_compute_ctrl? x_data_reg : x_data_wire;
// assign x_sel = load_compute_ctrl? x_sel_reg : x_sel_wire;
// // assign x_rw = load_compute_ctrl? x_rw_reg : x_rw_wire;
// // assign x_rq = load_compute_ctrl? x_rq_reg : x_rq_wire;
// assign x_wq = load_compute_ctrl? x_wq_reg : x_wq_wire;

always begin
  `HALF_CLOCK_PERIOD;
  clk = ~clk;
end

initial begin
	clk = 0;
	rst = 0;
	rst_mem = 0;

	wx_write_reg = 0;

	w_addr_reg = 0;
	w_data_reg = 0;
	w_sel_reg = 0;
	// w_rw = 0;
	// w_rq_reg = 0;
	w_wq_reg = 0;

	x_addr_reg = 0;
	x_data_reg = 0;
	x_sel_reg = 0;
	// x_rw = 0;
	// x_rq_reg = 0;
	x_wq_reg = 0;

	// load mode: load data from external into memory
	load_compute_ctrl = 1;
	en_compute = 0;
	// start_compute = 0;

	weight1_file = $fopen(`WEIGHT1_FILE,"r");
	if (!weight1_file)
	begin
		$display("Couldn't open the weight file.");
		$finish;
	end
	else begin
		$display("Weight1 file opened.");
	end

	weight2_file = $fopen(`WEIGHT2_FILE,"r");
	if (!weight2_file)
	begin
		$display("Couldn't open the weight file.");
		$finish;
	end
	else begin
		$display("Weight2 file opened.");
	end

	weight3_file = $fopen(`WEIGHT3_FILE,"r");
	if (!weight3_file)
	begin
		$display("Couldn't open the weight file.");
		$finish;
	end
	else begin
		$display("Weight3 file opened.");
	end

	weight4_file = $fopen(`WEIGHT4_FILE,"r");
	if (!weight4_file)
	begin
		$display("Couldn't open the weight file.");
		$finish;
	end
	else begin
		$display("Weight4 file opened.");
	end

	input_file = $fopen(`INPUT_FILE,"r");
	if (!input_file)
	begin
		$display("Couldn't open the input file.");
		$finish;
	end
	else begin
		$display("Input file opened.");
	end

	// reset mem
	// #10 rst_mem = 1;

	// start read weight
	// start reading weight1
	// #10 w_sel_reg = 0;
	// w_addr_reg <=0;
	// // wx_write_reg <= 1;
	// ret_read = $fscanf(weight1_file, "%d", value_read);
	// wx_write_reg <= value_read;
	@(posedge clk);
	// w_rq_reg = 0;
	w_wq_reg <= 1;
	// x_rq_reg = 0;
	x_wq_reg <= 0;

	@(posedge clk);
	w_sel_reg <= 0;

	@(posedge clk);
	for (i=0; i<784*1024; i=i+1) begin
		ret_read = $fscanf(weight1_file, "%d", value_read);
		// value_read = 1;
		@(posedge clk);
		w_addr_reg <= i;
		wx_write_reg <= value_read;
		@(posedge clk);
	end
	$display("W1 finish loading.");

	// // read data from weight1
	// @(posedge clk);
	// w_wq_reg <= 0;
	// // #10 w_wq_reg = 0;

	// // set addr in this cycle.
	// // get data in next cycle.
	// // when i=1, wx_read_reg is the value that addr=0.
	// // TODO: fix this problem in compute module. 
	// @(posedge clk);
	// // value_read <= 1;
	// w_addr_reg <= 0;
	// @(posedge clk);
	// w_addr_reg <= 0;
	// // wx_read_reg <= w_data;
	// @(posedge clk);
	// for (i=1; i<11; i=i+1) begin
	// 	// ret_read = $fscanf(weight1_file, "%d", value_read);
	// 	// value_read = 1;
	// 	w_addr_reg <= i;
	// 	// wx_write_reg <= value_read;
	// 	wx_read_reg <= w_data;
	// 	@(posedge clk);
	// end
	// finishi read data from weight1

	// start reading weight2
	@(posedge clk); 
	w_sel_reg = 1;


	@(posedge clk);
	for (i=0; i<1024*1024; i=i+1) begin
		ret_read = $fscanf(weight2_file, "%d", value_read);
		// value_read = 1;
		@(posedge clk);
		w_addr_reg <= i;
		wx_write_reg <= value_read;
		@(posedge clk);
	end
	$display("W2 finish loading.");

	// start reading weight3
	@(posedge clk);
	w_sel_reg = 2;

	@(posedge clk);
	for (i=0; i<1024*1024; i=i+1) begin
		ret_read = $fscanf(weight3_file, "%d", value_read);
		// value_read = 1;
		@(posedge clk);
		w_addr_reg <= i;
		wx_write_reg <= value_read;
		@(posedge clk);
	end
	$display("W3 finish loading.");

	// start reading weight4
	@(posedge clk); 
	w_sel_reg = 3;

	@(posedge clk);
	for (i=0; i<10240; i=i+1) begin
		ret_read = $fscanf(weight4_file, "%d", value_read);
		// value_read = 1;
		@(posedge clk);
		w_addr_reg <= i;
		wx_write_reg <= value_read;
		@(posedge clk);
	end
	$display("W4 finish loading.");

	// start reading input
	@(posedge clk);
	// w_rq_reg = 0;
	w_wq_reg = 0;
	@(posedge clk);
	// x_rq_reg = 0;
	x_addr_reg <= 0;
	x_sel_reg = 0;

	@(posedge clk);
	x_wq_reg = 1;

	@(posedge clk);
	for (i=0; i<784; i=i+1) begin
		ret_read = $fscanf(input_file, "%d", value_read);
		// value_read = 1;
		@(posedge clk);
		x_addr_reg <= i;
		wx_write_reg <= value_read;
		@(posedge clk);
	end
	$display("Input finish loading");
	x_wq_reg <= 0;


	@(posedge clk);
	load_compute_ctrl <= 0;

	@(posedge clk);
	en_compute <= 1;
	if (compute_finish==1) begin
		$finish;
	end

	// @(posedge clk);
	// load_compute_ctrl <= 1;

	// input_file = $fopen(`INPUT_FILE,"r");
	// if (!input_file)
	// begin
	// 	$display("Couldn't open the input file.");
	// 	$finish;
	// end
	// else begin
	// 	$display("Input file opened.");
	// end
	// for testing load weight
	// @(posedge clk);
	// w_sel_reg <= 0;

	// for (i=0; i<6; i=i+1) begin
	// 	// ret_read = $fscanf(weight1_file, "%d", value_read);
	// 	// value_read = 1;
	// 	// @(posedge clk);
	// 	w_addr_reg <= i;
	// 	// wx_write_reg <= value_read;
	// 	@(posedge clk);
	// end

	// @(posedge clk);
	// w_sel_reg <= 1;

	// for (i=0; i<9; i=i+1) begin
	// 	// ret_read = $fscanf(weight1_file, "%d", value_read);
	// 	// value_read = 1;
	// 	// @(posedge clk);
	// 	w_addr_reg <= i;
	// 	// wx_write_reg <= value_read;
	// 	@(posedge clk);
	// end

	// @(posedge clk);
	// w_sel_reg <= 2;

	// for (i=0; i<9; i=i+1) begin
	// 	// ret_read = $fscanf(weight1_file, "%d", value_read);
	// 	// value_read = 1;
	// 	// @(posedge clk);
	// 	w_addr_reg <= i;
	// 	// wx_write_reg <= value_read;
	// 	@(posedge clk);
	// end

	// $finish;


end


endmodule
