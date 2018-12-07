`timescale 1ns/1ps

// define state
`define rest ;
`define load_input ;
`define load_weight ;
`define compute ;
`define activation ;
`define store_output ;
`define finish ;

module compute_module
#(
	parameter W_ADDR_LEN = 17;
	parameter W_DATA_LEN = 8;
	parameter I_ADDR_LEN = 10;
	parameter I_DATA_LEN = 8;
	)
(
	// control
	start_compute,
	compute_finish
	// ram
	// addr_weight,
	// data_weight,
	// addr_input,
	// data_input
	);


weight_ram weight_ram_i
(
	.read_write(read_write_weight),
	.addr_weight(addr_weight),
	.data_weight(data_weight))

input_ram input_ram_i
(
	.read_write(read_write_input),
	.addr_input(addr_input),
	.data_input(data_input))


input rst;
input clk;

// control
input start_compute;
reg compute_finish;

// weight ram
reg read_write_weight;
reg [W_ADDR_LEN-1:0] addr_weight;
wire [W_DATA_LEN-1:0] data_weight;
reg [W_DATA_LEN-1:0] data_weight_reg;
reg [15:0] load_weight_counter;
// input ram
reg read_write_input;
reg [I_ADDR_LEN-1:0] addr_input;
wire [I_DATA_LEN-1:0] data_input;
reg [I_DATA_LEN-1:0] data_input_reg;
reg [15:0] load_input_counter;

// state
reg [2:0] state;
// weight ram control
reg [W_ADDR_LEN-1:0] addr_weight

// rest state counter
reg [3:0] rest_counter;

// compute result reg
reg signed [15:0] result_reg;
// activation result reg
reg output_reg;
reg [1023:0] output_mem;

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
