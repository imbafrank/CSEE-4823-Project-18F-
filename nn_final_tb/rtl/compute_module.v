`timescale 1ns/1ps
// `include "calc.v"
// define state
`define rest 0
`define load_1 1
`define compute_x2 2
`define load_2 3
`define compute_x3 4
`define load_3 5
`define comnpute_x4 6
`define load_4 7
`define compute_output 8
`define finish 9

module compute_module
#(
	parameter W_ADDR_LEN = 20,
	parameter W_DATA_LEN = 1,
	parameter W_SEL_LEN = 2,
	parameter W_RW_LEN = 2,
	parameter X_ADDR_LEN = 10,
	parameter X_DATA_LEN = 1,
	parameter X_SEL_LEN = 2,
	parameter X_RW_LEN = 2,

	parameter alu_width  = 12
	)
(
	clk,
	rst,
	// control
	en,
	compute_finish,
	// connect to mem
	wx_write,
	w_addr,
	w_data,
	w_sel,
	w_rq,
	w_wq,
	x_addr,
	x_data,
	x_sel,
	x_rq,
	x_wq
	);


input wire rst;
input wire clk;
input wire en;
// control signal from tb
// input wire start_compute;
output reg compute_finish;

// signal to mem
inout wire wx_write;
output wire [W_ADDR_LEN-1:0] w_addr;
inout wire [W_DATA_LEN-1:0] w_data;
output wire [W_SEL_LEN-1:0] w_sel;
// output [W_RW_LEN-1:0] w_rw;
output wire w_rq;
output wire w_wq;
output wire [X_ADDR_LEN-1:0] x_addr;
inout wire [X_DATA_LEN-1:0] x_data;
output wire [X_SEL_LEN-1:0] x_sel;
// output [X_RW_LEN-1:0] x_rw;
output wire x_rq;
output wire x_wq;

// signal to calc
wire calc_rst;
wire calc_1;
wire calc_in;
wire [alu_width-1:0] agg_out2alu;
wire agg_out_acted;

// write data reg
reg wx_write_reg=0;
// weight counter
reg [W_ADDR_LEN-1:0] load_weight_counter=0;
reg [W_SEL_LEN-1:0] sel_weight_counter=0;
// reg w_data_reg;
reg w_rq_reg=0;
reg w_wq_reg=0;

// input counter
reg r_or_w=0;
reg [X_ADDR_LEN-1:0] store_x_counter=0;
reg [X_ADDR_LEN-1:0] load_x_counter=0;
reg [X_SEL_LEN-1:0] sel_x_counter=0;
// reg x_data_reg;
reg x_rq_reg=0;
reg x_wq_reg=0;

// reg store current value
reg [W_DATA_LEN-1:0] store_weight_reg=0;
reg [X_DATA_LEN-1:0] store_x_reg=0;
// reg store current rw status
// reg [W_RW_LEN-1:0] rw_w_reg;
// reg [X_RW_LEN-1:0] rw_x_reg;

// reg store calc output
reg agg_out_reg;

// layer finish mark
reg layer1_finish;

// state
reg [2:0] state;

// rest state counter
reg [3:0] rest_counter;
wire rest_finish;

// activation result reg
reg output_reg;

// tmp regs: representing memory block
// reg 

// connect with mem
assign wx_write = wx_write_reg;
assign w_addr = load_weight_counter;
assign w_sel = sel_weight_counter;
assign w_data = store_weight_reg;
// assign w_rw = rw_w_reg;
assign w_rq = w_rq_reg;
assign w_wq = w_wq_reg;

assign x_addr = r_or_w? load_x_counter : store_x_counter;
assign x_data = store_x_reg;
assign x_sel = sel_x_counter;
// assign x_rw = rw_x_reg;
assign x_rq = x_rq_reg;
assign x_wq = x_wq_reg;

// connect with calc
assign calc_1 = 1;
assign calc_in = store_weight_reg ^ store_x_reg;
assign calc_rst = 1;

// instantiate compute block
 calc calc_i
(
	.clk(clk),
	.rst(calc_rst),
	.calc_1(calc_1),
	.calc_in(calc_in),
	.agg_out2alu(agg_out2alu),
	.agg_out_acted(agg_out_acted));


// when rest 10 cycles, go to next state. 
assign rest_finish = rest_counter>10;

always @(posedge clk) begin
	if (en==0) begin
		// reset
    	state <= `rest;
    	rest_counter <= 0;
	end

	else begin
		case (state)
		`rest:	begin
			if (rest_finish==1) begin
				state <= `load_1;
				rest_counter <= 0;
			end
			else begin
				rest_counter <= rest_counter + 1;
				state <= `rest;
			end
		end

		`load_1: begin
			sel_weight_counter <= 0;
			sel_x_counter <= 0;
			rest_counter <= 0;
			// rw_w_reg <= 1;
			// rw_x_reg <= 1;
			w_rq_reg <= 1;
			w_wq_reg <= 0;
			x_rq_reg <= 1;
			x_wq_reg <= 0;

			r_or_w <= 1;

			store_weight_reg <= w_data;
			store_x_reg <= x_data;


			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;



			if (load_weight_counter >= 802816 && load_x_counter >= 784) begin
				state <= `compute_x2;
				load_x_counter <= 0;
				layer1_finish <= 0;
				load_weight_counter <= 0;
			end

			if (load_x_counter >= 784 && load_weight_counter < 802816) begin
				state <= `compute_x2;
				load_x_counter <= 0;
			end

			// if (load_weight_counter >= 802816) begin
			// 	load_weight_counter <= 0;
			// end
		end

		`compute_x2: begin
			sel_x_counter <= 1;
			w_rq_reg <= 0;
			w_wq_reg <= 0;
			x_rq_reg <= 0;
			x_wq_reg <= 1;

			r_or_w <= 0;
			store_x_counter <= store_x_counter + 1;
			// agg_out_reg is redundent. 
			agg_out_reg <= agg_out_acted;
			store_x_reg <= agg_out_reg;
		end
	endcase
	end
	
end

endmodule
