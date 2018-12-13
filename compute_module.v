`timescale 1ns/1ps
// define state
`define rest ;
`define load_x1 ;
`define load_w1 ;
`define compute_x2
`define load_x2 ;
`define load_w2 ;
`define compute_x3
`define load_x3 ;
`define load_w3 ;
`define comnpute_x4;
`define load_x4 ;
`define load_w4 ;
`define compute_output;
`define finish ;

module compute_module
#(
	parameter W_ADDR_LEN = 20;
	parameter W_DATA_LEN = 1;
	parameter W_SEL_LEN = 2;
	parameter W_RW_LEN = 2;
	parameter X_ADDR_LEN = 10;
	parameter X_DATA_LEN = 1;
	parameter X_SEL_LEN = 2;
	parameter X_RW_LEN = 2;
	)
(
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


// instantiate weight memory
weight_ram weight_ram_i
(
	.read_write(read_write_weight),
	.addr_weight(addr_weight),
	.data_weight(data_weight))
// instantiate input memory
input_ram input_ram_i
(
	.read_write(read_write_input),
	.addr_input(addr_input),
	.data_input(data_input))
// instantiate compute block

 alu_agg_i
(
	)

input rst;
input clk;

// control signal from tb
input wire start_compute;
output reg compute_finish;

// signal to mem
wire [W_ADDR_LEN-1:0] w_addr;
wire [W_DATA_LEN-1:0] w_data;
wire [W_SEL_LEN-1:0] w_sel;
wire [W_RW_LEN-1:0] w_rw;
wire [X_ADDR_LEN-1:0] x_addr;
wire [X_DATA_LEN-1:0] x_data;
wire [X_SEL_LEN-1:0] x_sel;
wire [X_RW_LEN-1:0] x_rw;

// weight counter
reg [W_ADDR_LEN-1:0] load_weight_counter;
reg [W_SEL_LEN-1:0] sel_weight_counter;

// input counter
reg [X_ADDR_LEN-1:0] load_x_counter;
reg [X_SEL_LEN-1:0] sel_x_counter

// reg store current value
reg [W_DATA_LEN-1:0] store_weight_reg;
reg [X_DATA_LEN-1:0] store_x_reg;
// reg store current rw status
reg []

// state
reg [2:0] state;

// rest state counter
reg [3:0] rest_counter;
reg rest_finish

// activation result reg
reg output_reg;

// connect with mem
assign w_addr = load_weight_counter;
assign w_sel = sel_weight_counter;
assign w_


// when rest 10 cycles, go to next state. 
assign rest_finish = rest_counter>10;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		// reset
    	state <= rest;
    	rest_counter <= 4'd0;
    	addr_weight <= W_ADDR_LEN'b0;
    	addr_input <= I_ADDR_LEN'b0;
		compute_finish <= 0;
	end
	else begin
		case (state)
		`rest:	begin
			if (rest_finish==1) begin
				state <= `load_input;
				rest_counter <= 0;
			end
			else begin
				rest_counter <= rest_counter + 1;
				state <= `rest;
			end
		end

		`load_input: begin
			data_input_reg <= data_input;
			result_reg <= 0;
			state <= `load_weight
		end

		`load_weight: begin
			data_weight_reg <= data_weight;
			load_weight_counter <= load_weight_counter + 1;
			state <= `compute;
		end

		`compute: begin
			if (data_weight_reg == 0) begin
				result_reg <= result_reg - 1;
			end
			else if (data_weight_reg == 1) begin
				result_reg <= result_reg + 1;
			end

			if (load_weight_counter == 1024) begin
				state <= `activation;
				load_weight_counter <= 0;
			end
			else begin
				state <= `load_weight;
				addr_weight <= addr_weight + 1;
			end

		end

		`activation: begin
			if (result_reg >= 0) begin
				output_reg = 1;
			end
			else begin
				output_reg = 0;
			end
			state <= `store_output;
		end

		`store_output: begin
			output_mem[addr_input] = output_reg;
			addr_input <= addr_input + 1;
		end

		`finish: begin
			compute_finish <= 1;

		end

	end
end

endmodule
