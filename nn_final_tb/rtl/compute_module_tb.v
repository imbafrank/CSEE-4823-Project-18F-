`timescale 1ns / 1ps
`define HALF_CLOCK_PERIOD  #5

module compute_module_tb;

parameter W_ADDR_LEN = 20;
parameter W_DATA_LEN = 1;
parameter W_SEL_LEN = 2;
parameter W_RW_LEN = 2;
parameter X_ADDR_LEN = 10;
parameter X_DATA_LEN = 1;
parameter X_SEL_LEN = 2;
parameter X_RW_LEN = 2;
parameter alu_width  = 12;

reg rst;
reg clk;
reg en;
// control signal from tb
reg start_compute;
// output reg compute_finish;

// signal to mem
wire wx_write;
wire [W_ADDR_LEN-1:0] w_addr;
reg [W_DATA_LEN-1:0] w_data;
wire [W_SEL_LEN-1:0] w_sel;
// output [W_RW_LEN-1:0] w_rw;
wire w_rq;
wire w_wq;
wire [X_ADDR_LEN-1:0] x_addr;
reg [X_DATA_LEN-1:0] x_data;
wire [X_SEL_LEN-1:0] x_sel;
// output [X_RW_LEN-1:0] x_rw;
wire x_rq;
wire x_wq;

compute_module compute_module_i
(
	.clk(clk),
	.rst(rst),
	.en(en),
	.compute_finish(compute_finish),
	.w_addr(w_addr),
	.w_data(w_data),
	.w_sel(w_sel),
	.w_rq(w_rq),
	.w_wq(w_wq),
	.x_addr(x_addr),
	.x_data(x_data),
	.x_sel(x_sel),
	.x_rq(x_rq),
	.x_wq(x_wq)
	);


always begin
  // `HALF_CLOCK_PERIOD;
  #5 clk = ~clk;
end

initial begin
	// #10 x_1 = 1;
	// ctrl = 1;

	#50 en = 1;

	// @(posedge clk);
	// for (i=0; i<8; i=i+1) begin
	// 	addr_counter = addr_counter + 1;
	// 	@(posedge clk);
	// end

	// #10 ctrl = 0;
	// $display("W1 finish loading.");
end

endmodule