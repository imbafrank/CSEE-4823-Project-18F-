`timescale 1ns/1ps
`define rst 0
`define load_x1 1
// `define store_x 2
`define check_load_addr_x1 2
`define update_load_addr_x1 3
`define store_x2_preset 4
`define store_x2_write 5
`define store_x2_finish 6
`define check_store_addr_x2 7
`define update_store_addr_x2 8
`define load_x2 9
`define check_load_addr_x2 10
`define update_load_addr_x2 11
`define store_x3_preset 12
`define store_x3_write 13
`define store_x3_finish 14
`define check_store_addr_x3 15
`define update_store_addr_x3 16
`define load_x3 17
`define check_load_addr_x3 18
`define update_load_addr_x3 19
`define store_x4_preset 20
`define store_x4_write 21
`define store_x4_finish 22
`define check_store_addr_x4 23
`define update_store_addr_x4 24
`define load_x4 25
`define check_load_addr_x4 26
`define update_load_addr_x4 27
`define display_x5 28
`define check_store_addr_x5 29
`define update_store_addr_x5 30
// `define store_x 2
// `define update_load_addr_x2 8
// `define check_load_addr_x2 9
// `define store_x3 10
// `define update_store_addr_x3 11
// `define check_store_addr_x3 12

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
	// parameter W1_LEN = 802816,
	// parameter X1_LEN = 784,
	// parameter W2_LEN = 1048576,
	// parameter X2_LEN = 1024,
	// parameter W3_LEN = 1048576,
	// parameter X3_LEN = 1024,
	// parameter W4_LEN = 10240,
	// parameter X4_LEN = 1024,
	// small nn test
	parameter W1_LEN = 6,
	parameter X1_LEN = 2,
	parameter W2_LEN = 9,
	parameter X2_LEN = 3,
	parameter W3_LEN = 9,
	parameter X3_LEN = 3,
	parameter W4_LEN = 6,
	parameter X4_LEN = 3,
	parameter X5_LEN = 2,

	parameter OUTPUT_LEN = 10,
	parameter alu_width  = 12
	)
(
	clk,
	// rst,
	// control
	en,
	compute_finish,
	// connect to mem
	wx_write,
	w_addr,
	w_data,
	w_sel,
	// w_rq,
	w_wq,
	x_addr,
	x_data,
	x_sel,
	// x_rq,
	x_wq
	);

input clk, en;
input [W_DATA_LEN-1:0] w_data;
input [X_DATA_LEN-1:0] x_data;

output reg compute_finish;

output reg wx_write;

output wire [W_ADDR_LEN-1:0] w_addr;
output reg [W_SEL_LEN-1:0] w_sel;
output reg w_wq;

output wire [X_ADDR_LEN-1:0] x_addr;
output reg [X_SEL_LEN-1:0] x_sel;
output reg x_wq;

// reg calc_rst;
// wire calc_1;
wire calc_in;
// wire [alu_width-1:0] agg_out2alu;
// wire agg_out_acted;

reg r_or_w;
// reg agg_out_reg;

reg [5:0] state;

// integer display_output;

// reg layer1_finish;

reg [W_ADDR_LEN-1:0] load_weight_counter;
reg [X_ADDR_LEN-1:0] load_x_counter;
reg [X_ADDR_LEN-1:0] store_x_counter;

reg signed [alu_width-1:0] store_x;

assign w_addr = load_weight_counter;
assign x_addr = r_or_w? load_x_counter : store_x_counter;
// assign calc_1 = 1;
assign calc_in = w_data ^ x_data;

//  calc calc_i
// (
// 	.clk(clk),
// 	.rst(calc_rst),
// 	.calc_1(calc_1),
// 	.calc_in(calc_in),
// 	.agg_out2alu(agg_out2alu),
// 	.agg_out_acted(agg_out_acted));

always @(posedge clk) begin
	if (en==0) begin
		state <= `rst;
		wx_write <= 0;
		w_wq <= 0;
		x_wq <= 0;
		load_weight_counter <= 0;
		load_x_counter <= 0;
		store_x_counter <= 0;
		w_sel <= 0;
		x_sel <= 0;
		// agg_out_reg <= 0;
		// layer1_finish <= 0;
		// calc_rst <= 1;
		compute_finish <= 0;
		store_x <= 0;
		r_or_w <= 1;

	end
	else begin
		case (state)
		`rst: begin
			state <= `load_x1;
			// w_wq <= 0;
			// x_wq <= 0;
			// load_weight_counter <= 0;
			// load_x_counter <= 0;
			// store_x_counter <= 0;
			// w_sel <= 0;
			// x_sel <= 0;
			// agg_out_reg <= 0;
			// layer1_finish <= 0;
			// calc_rst <= 1;
			// compute_finish <= 0;
			// store_x <= 0;
			// r_or_w <= 1;

		end

		// layer1
// -----------------------------------------------
		`load_x1: begin
			if (calc_in==0) begin
				store_x <= store_x + 1;
			end
			else begin
				store_x <= store_x -1;
			end
			state <= `check_load_addr_x1;

		end


		`check_load_addr_x1: begin
			if (load_x_counter >= X1_LEN-1) begin
				state <= `store_x2_preset;
				load_x_counter <= 0;
				load_weight_counter <= load_weight_counter + 1;
			end
			else begin
				state<=`update_load_addr_x1;
			end
		end

		`update_load_addr_x1: begin
			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;
			state <= `load_x1;

		end

		`store_x2_preset: begin
			x_sel <= 1;
			r_or_w <= 0;
			// x_wq <= 1;
			state <= `store_x2_write;
			wx_write <= !store_x[alu_width-1];
		end

		`store_x2_write: begin
			x_wq <= 1;
			state <= `store_x2_finish;
		end

		`store_x2_finish: begin
			x_wq <= 0;
			state <= `check_store_addr_x2;
		end


		`check_store_addr_x2: begin
			// x_sel <= 0;
			r_or_w <= 1;
			if (store_x_counter>=X2_LEN-1) begin
				// $finish;
				state <= `load_x2;
				load_weight_counter <= 0;
				load_x_counter <= 0;
				store_x_counter <= 0;
				w_sel <= 1;
				x_sel <= 1;
				store_x <= 0;
			end
			else begin
				state <= `update_store_addr_x2;
				store_x <= 0;
				x_sel <= 0;
			end
		end

		`update_store_addr_x2: begin
		// synthesis probably goes wrong here!!!
			// x_sel <= 0;
			// x_wq <= 0;
			// r_or_w <= 1;
			store_x_counter <= store_x_counter + 1;
			state <= `load_x1;
		end


		// layer 2
// --------------------------------------------------------

		`load_x2: begin
			if (calc_in==0) begin
				store_x <= store_x + 1;
			end
			else begin
				store_x <= store_x -1;
			end
			state <= `check_load_addr_x2;

		end


		`check_load_addr_x2: begin
			if (load_x_counter >= X2_LEN-1) begin
				state <= `store_x3_preset;
				load_x_counter <= 0;
				load_weight_counter <= load_weight_counter + 1;
			end
			else begin
				state<=`update_load_addr_x2;
			end
		end

		`update_load_addr_x2: begin
			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;
			state <= `load_x2;

		end

		`store_x3_preset: begin
			x_sel <= 2;
			r_or_w <= 0;
			// x_wq <= 1;
			state <= `store_x3_write;
			wx_write <= !store_x[alu_width-1];
		end

		`store_x3_write: begin
			x_wq <= 1;
			state <= `store_x3_finish;
		end

		`store_x3_finish: begin
			x_wq <= 0;
			state <= `check_store_addr_x3;
		end


		`check_store_addr_x3: begin
			x_sel <= 1;
			r_or_w <= 1;
			if (store_x_counter>=X3_LEN-1) begin
				// $finish;
				state <= `load_x3;
				load_weight_counter <= 0;
				load_x_counter <= 0;
				store_x_counter <= 0;
				w_sel <= 2;
				x_sel <= 2;
				store_x <= 0;
			end
			else begin
				state <= `update_store_addr_x3;
				store_x <= 0;
			end
		end

		`update_store_addr_x3: begin
		// synthesis probably goes wrong here!!!
			// x_sel <= 0;
			// x_wq <= 0;
			// r_or_w <= 1;
			store_x_counter <= store_x_counter + 1;
			state <= `load_x2;
		end


		// layer 3
// --------------------------------------------------------

		`load_x3: begin
			if (calc_in==0) begin
				store_x <= store_x + 1;
			end
			else begin
				store_x <= store_x -1;
			end
			state <= `check_load_addr_x3;

		end


		`check_load_addr_x3: begin
			if (load_x_counter >= X3_LEN-1) begin
				state <= `store_x4_preset;
				load_x_counter <= 0;
				load_weight_counter <= load_weight_counter + 1;
			end
			else begin
				state<=`update_load_addr_x3;
			end
		end

		`update_load_addr_x3: begin
			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;
			state <= `load_x3;

		end

		`store_x4_preset: begin
			x_sel <= 3;
			r_or_w <= 0;
			// x_wq <= 1;
			state <= `store_x4_write;
			wx_write <= !store_x[alu_width-1];
		end

		`store_x4_write: begin
			x_wq <= 1;
			state <= `store_x4_finish;
		end

		`store_x4_finish: begin
			x_wq <= 0;
			state <= `check_store_addr_x4;
		end


		`check_store_addr_x4: begin
			x_sel <= 2;
			r_or_w <= 1;
			if (store_x_counter>=X4_LEN-1) begin
				// $finish;
				state <= `load_x4;
				load_weight_counter <= 0;
				load_x_counter <= 0;
				store_x_counter <= 0;
				w_sel <= 3;
				x_sel <= 3;
				store_x <= 0;
			end
			else begin
				state <= `update_store_addr_x4;
				store_x <= 0;
			end
		end

		`update_store_addr_x4: begin
		// synthesis probably goes wrong here!!!
			// x_sel <= 0;
			// x_wq <= 0;
			// r_or_w <= 1;
			store_x_counter <= store_x_counter + 1;
			state <= `load_x3;
		end


		// layer 4
// --------------------------------------------------------

		`load_x4: begin
			if (calc_in==0) begin
				store_x <= store_x + 1;
			end
			else begin
				store_x <= store_x -1;
			end
			state <= `check_load_addr_x4;

		end


		`check_load_addr_x4: begin
			if (load_x_counter >= X4_LEN-1) begin
				state <= `display_x5;
				load_x_counter <= 0;
				load_weight_counter <= load_weight_counter + 1;
			end
			else begin
				state<=`update_load_addr_x4;
			end
		end

		`update_load_addr_x4: begin
			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;
			state <= `load_x4;

		end

		`display_x5: begin
			// x_sel <= 3;
			// r_or_w <= 0;
			// x_wq <= 1;
			state <= `check_store_addr_x5;
			wx_write <= !store_x[alu_width-1];
			// display_output <= wx_wirte;
			#2 $display("%b",wx_write);
		end

		// `store_x4_write: begin
		// 	x_wq <= 1;
		// 	state <= `store_x4_finish;
		// end

		// `store_x4_finish: begin
		// 	x_wq <= 0;
		// 	state <= `check_store_addr_x4;
		// end


		`check_store_addr_x5: begin
			x_sel <= 3;
			r_or_w <= 1;
			if (store_x_counter>=X5_LEN-1) begin
				$finish;
				// state <= `load_x4;
				// load_weight_counter <= 0;
				// load_x_counter <= 0;
				// store_x_counter <= 0;
				// w_sel <= 3;
				// x_sel <= 3;
				// store_x <= 0;
			end
			else begin
				state <= `update_store_addr_x5;
				store_x <= 0;
			end
		end

		`update_store_addr_x5: begin
		// synthesis probably goes wrong here!!!
			// x_sel <= 0;
			// x_wq <= 0;
			// r_or_w <= 1;
			store_x_counter <= store_x_counter + 1;
			state <= `load_x4;
		end



		endcase
	end
end

endmodule