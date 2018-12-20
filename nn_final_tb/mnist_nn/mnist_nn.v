`timescale 1ns / 1ps
`include "./compute_module_test.v"
`include "./mem_sys_new.v"

module mnist_nn
#(
	parameter W_ADDR_LEN = 20,
	parameter W_DATA_LEN = 1,
	parameter W_SEL_LEN = 2,
	// parameter W_RW_LEN = 2;
	parameter X_ADDR_LEN = 10,
	parameter X_DATA_LEN = 1,
	parameter X_SEL_LEN = 2)
	// parameter X_RW_LEN = 2;)
(
	clk,
	// rst,
	// rst_mem,
	load_compute_ctrl,
	en_compute,
	// oc means off chip
	w_wq_oc,
	x_wq_oc,
	w_addr_oc,
	x_addr_oc,
	wx_write_oc,
	x_data_oc,
	w_data_oc,
	x_sel_oc,
	w_sel_oc,
	compute_finish
	);
input clk, load_compute_ctrl, en_compute;
input w_wq_oc, x_wq_oc;
input [W_ADDR_LEN-1:0] w_addr_oc;
input [X_ADDR_LEN-1:0] x_addr_oc;
input wx_write_oc;
input [W_DATA_LEN-1:0] w_data_oc;
input [X_DATA_LEN-1:0] x_data_oc;
input [W_SEL_LEN-1:0] w_sel_oc;
input [X_SEL_LEN-1:0] x_sel_oc;
output wire compute_finish;

wire w_wq_wire, x_wq_wire;
wire [W_ADDR_LEN-1:0] w_addr_wire;
wire [X_ADDR_LEN-1:0] x_addr_wire;
wire wx_write_wire;
wire [W_DATA_LEN-1:0] w_data_wire;
wire [X_DATA_LEN-1:0] x_data_wire;
wire [W_SEL_LEN-1:0] w_sel_wire;
wire [X_SEL_LEN-1:0] x_sel_wire;

wire w_wq, x_wq;
wire [W_ADDR_LEN-1:0] w_addr;
wire [X_ADDR_LEN-1:0] x_addr;
wire wx_write;
wire [W_DATA_LEN-1:0] w_data;
wire [X_DATA_LEN-1:0] x_data;
wire [W_SEL_LEN-1:0] w_sel;
wire [X_SEL_LEN-1:0] x_sel;

assign wx_write = load_compute_ctrl? wx_write_oc : wx_write_wire;
assign w_addr = load_compute_ctrl? w_addr_oc : w_addr_wire;
// assign w_data = load_compute_ctrl? w_data_oc : w_data_wire;
assign w_data_wire = w_data;
assign w_sel = load_compute_ctrl? w_sel_oc : w_sel_wire;
assign w_wq = load_compute_ctrl? w_wq_oc : w_wq_wire;
assign x_addr = load_compute_ctrl? x_addr_oc : x_addr_wire;
// assign x_data = load_compute_ctrl? x_data_oc : x_data_wire;
assign x_data_wire = x_data;
assign x_sel = load_compute_ctrl? x_sel_oc : x_sel_wire;
assign x_wq = load_compute_ctrl? x_wq_oc : x_wq_wire;

mem_sys mem_sys_i
(
	// .clk(clk),
	.we_w(w_wq),
	.we_x(x_wq),
	.address_w(w_addr),
	.address_x(x_addr),
	.data_in(wx_write),
	.data_out_x(x_data),
	.data_out_w(w_data),
	.sel_x(x_sel),
	.sel_w(w_sel)
	);

compute_module compute_module_i
(
	.clk(clk),
	// .rst(rst),
	.en(en_compute),
	.compute_finish(compute_finish),
	.wx_write(wx_write_wire),
	.w_addr(w_addr_wire),
	.w_data(w_data_wire),
	.w_sel(w_sel_wire),
	.w_wq(w_wq_wire),
	.x_addr(x_addr_wire),
	.x_data(x_data_wire),
	.x_sel(x_sel_wire),
	.x_wq(x_wq_wire)
	);


endmodule