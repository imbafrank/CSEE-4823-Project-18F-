`timescale 1ns/1ps
<<<<<<< HEAD
//try
=======
>>>>>>> cccd9235f57619beffc24fda994f97b57d81451f
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
	start_compute,
	compute_finish,
	// connect to mem
	w_addr,
	w_data,
	w_sel,
	w_rw,
	x_addr,
	x_data,
	x_sel,
	x_rw
	);
// instantiate compute block


input rst;
input clk;

// control signal from tb
input wire start_compute;
output reg compute_finish;

// signal to mem
inout wire [W_ADDR_LEN-1:0] w_addr;
inout wire [W_DATA_LEN-1:0] w_data;
inout wire [W_SEL_LEN-1:0] w_sel;
inout wire [W_RW_LEN-1:0] w_rw;
inout wire [X_ADDR_LEN-1:0] x_addr;
inout wire [X_DATA_LEN-1:0] x_data;
inout wire [X_SEL_LEN-1:0] x_sel;
inout wire [X_RW_LEN-1:0] x_rw;

// signal to calc
//wire calc_1;
// wire calc_in;
wire [alu_width-1:0] agg_out2alu;
wire agg_out_acted;

// weight counter
reg [W_ADDR_LEN-1:0] load_weight_counter;
reg [W_SEL_LEN-1:0] sel_weight_counter;

// input counter
reg [X_ADDR_LEN-1:0] load_x_counter;
reg [X_SEL_LEN-1:0] sel_x_counter;

// reg store current value
reg [W_DATA_LEN-1:0] store_weight_reg;
reg [X_DATA_LEN-1:0] store_x_reg;
// reg store current rw status
reg [W_RW_LEN-1:0] rw_w_reg;
reg [X_RW_LEN-1:0] rw_x_reg;

// state
reg [2:0] state;

// rest state counter
reg [3:0] rest_counter;
reg rest_finish;

// activation result reg
reg output_reg;

// connect with mem
assign w_addr = load_weight_counter;
assign w_sel = sel_weight_counter;
// assign w_data = store_weight_reg;
assign w_rw = rw_w_reg;
assign x_addr = load_x_counter;
// assign x_data = store_x_reg;
assign x_sel = sel_x_counter;
assign x_rw = rw_x_reg;

// connect with calc
wire calc_clk,calc_rst;
wire calc_1 = 1;

//simplified func **********remeber to change
wire calc_in = 0;//store_weight_reg xor store_x_reg;

//instantiate calc
 calc #(
    .alu_width ( alu_width ),
    .agg_width ( alu_width ))
	calc_i
(
	.clk(calc_clk),
	.rst(calc_rst),
	.calc_1(calc_1),
	.calc_in(calc_in),
	.agg_out2alu(agg_out2alu),
	.agg_out_acted(agg_out_acted));
// when rest 10 cycles, go to next state. 


//simplified func **********remeber to change
//assign rest_finish = rest_counter>10;

// always @(posedge clk or posedge rst) begin
// 	if (rst) begin
// 		// reset
//     	state <= rest;
//     	rest_counter <= 4'd0;
//     	addr_weight <= W_ADDR_LEN'b0;
//     	addr_input <= I_ADDR_LEN'b0;
// 		compute_finish <= 0;
// 	end
// 	else begin
// 		case (state)
// 		`rest:	begin
// 			if (rest_finish==1) begin
// 				state <= `load_x1;
// 				rest_counter <= 0;
// 			end
// 			else begin
// 				rest_counter <= rest_counter + 1;
// 				state <= `rest;
// 			end
// 		end

// 		`load_1: begin
// 			sel_weight_counter <= 0;
// 			sel_x_counter <= 0;

// 			store_weight_reg <= w_data;
// 			store_x_reg <= x_data;

// 			load_weight_counter <= load_weight_counter + 1;
// 			load_x_counter <= load_x_counter + 1;

// 			if (load_weight_counter >= 802816 and load_x_counter >= 784) begin
// 				state <= `compute_x2;
// 			end

// 			if (load_x_counter >= 784) begin
// 				load_x_counter <= 0;
// 			end

// 			if (load_weight_counter >= 802816) begin
// 				load_weight_counter <= 0;
// 			end
// 		end


// 		end

// 	end
// end

endmodule
