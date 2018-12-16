`timescale 1ns/1ps
`include "./calc.v"

// define state
`define rest 0
`define layer_1 1
`define store_x2 2
`define layer_2 3
`define store_x3 4
`define layer_3 5
`define store_x4 6
`define layer_4 7
`define store_output 8
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
	parameter W1_LEN = 802816,
	parameter X1_LEN = 784,
	parameter W2_LEN = 1048576,
	parameter X2_LEN = 1024,
	parameter W3_LEN = 1048576,
	parameter X3_LEN = 1024,
	parameter W4_LEN = 10240,
	parameter X4_LEN = 1024,
	parameter OUTPUT_LEN = 10,
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
output wire wx_write;
output wire [W_ADDR_LEN-1:0] w_addr;
input wire [W_DATA_LEN-1:0] w_data;
output wire [W_SEL_LEN-1:0] w_sel;
// output [W_RW_LEN-1:0] w_rw;
output wire w_rq;
output wire w_wq;
output wire [X_ADDR_LEN-1:0] x_addr;
input wire [X_DATA_LEN-1:0] x_data;
output wire [X_SEL_LEN-1:0] x_sel;
// output [X_RW_LEN-1:0] x_rw;
output wire x_rq;
output wire x_wq;

// signal to calc
reg calc_rst=0;
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
reg [4-1:0] store_output_counter=0;
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
reg agg_out_reg=0;

// layer finish mark
reg layer1_finish=0;
reg layer2_finish=0;
reg layer3_finish=0;
reg layer4_finish=0;

// state
reg [3:0] state=`rest;

// rest state counter
reg [3:0] rest_counter=0;
wire rest_finish;

// activation result reg
reg output_reg=0;

// tmp regs: representing memory block
// reg 

// connect with mem
assign wx_write = wx_write_reg;
assign w_addr = load_weight_counter;
assign w_sel = sel_weight_counter;
// assign w_data = store_weight_reg;
// assign w_rw = rw_w_reg;
assign w_rq = w_rq_reg;
assign w_wq = w_wq_reg;

assign x_addr = r_or_w? load_x_counter : store_x_counter;
// assign x_data = store_x_reg;
assign x_sel = sel_x_counter;
// assign x_rw = rw_x_reg;
assign x_rq = x_rq_reg;
assign x_wq = x_wq_reg;

// connect with calc
assign calc_1 = 1;
assign calc_in = store_weight_reg ^ store_x_reg;

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
	calc_rst <= 1;
    	state <= `rest;
    	rest_counter <= 0;
	end

	else begin
		case (state)
		`rest:	begin
			if (rest_finish==1) begin
				state <= `layer_1;
				rest_counter <= 0;
			end
			else begin
				rest_counter <= rest_counter + 1;
				state <= `rest;
			end
		end

		`layer_1: begin
			calc_rst <= 0;
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
			layer1_finish <= 0;

			store_weight_reg <= w_data;
			store_x_reg <= x_data;


			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;



			if (load_x_counter >= (X1_LEN-1) && load_weight_counter >= (W1_LEN-1)) begin
				state <= `store_x2;
				load_x_counter <= 0;
				layer1_finish <= 1;
				load_weight_counter <= 0;
			end
			else if (load_x_counter >= (X1_LEN-1) && load_weight_counter < (W1_LEN-1)) begin
				state <= `store_x2;
				load_x_counter <= 0;
				layer1_finish <= 0;
			end
			else begin
				state <= `layer_1;
			end

			// if (load_weight_counter >= 802816) begin
			// 	load_weight_counter <= 0;
			// end
		end

		`store_x2: begin
			sel_x_counter <= 1;
			w_rq_reg <= 0;
			w_wq_reg <= 0;
			x_rq_reg <= 0;
			x_wq_reg <= 1;
			
			calc_rst <= 1;
		
			r_or_w <= 0;
			store_x_counter <= store_x_counter + 1;
			// agg_out_reg is redundent. 
			agg_out_reg <= agg_out_acted;
			wx_write_reg <= agg_out_reg;
			if (layer1_finish==1) begin
				state <= `layer_2;
				store_x_counter <= 0;
				$display("layer1 finish");
			end
			else begin
				state <= `layer_1;
			end
		end

		`layer_2: begin
			// $display("finish!!!");
			// $finish;
			calc_rst <= 0;
			sel_weight_counter <= 1;
			sel_x_counter <= 1;
			rest_counter <= 0;
			// rw_w_reg <= 1;
			// rw_x_reg <= 1;
			w_rq_reg <= 1;
			w_wq_reg <= 0;
			x_rq_reg <= 1;
			x_wq_reg <= 0;

			r_or_w <= 1;
			layer2_finish <= 0;

			store_weight_reg <= w_data;
			store_x_reg <= x_data;


			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;



			if (load_x_counter >= (X2_LEN-1) && load_weight_counter >= (W2_LEN-1)) begin
				state <= `store_x3;
				load_x_counter <= 0;
				layer2_finish <= 1;
				load_weight_counter <= 0;
			end
			else if (load_x_counter >= (X2_LEN-1) && load_weight_counter < (W2_LEN-1)) begin
				state <= `store_x3;
				load_x_counter <= 0;
				layer2_finish <= 0;
			end
			else begin
				state <= `layer_2;
			end
		end

		`store_x3: begin
			sel_x_counter <= 2;
			w_rq_reg <= 0;
			w_wq_reg <= 0;
			x_rq_reg <= 0;
			x_wq_reg <= 1;
			
			calc_rst <= 1;
		
			r_or_w <= 0;
			store_x_counter <= store_x_counter + 1;
			// agg_out_reg is redundent. 
			agg_out_reg <= agg_out_acted;
			wx_write_reg <= agg_out_reg;
			if (layer2_finish==1) begin
				state <= `layer_3;
				store_x_counter <= 0;
				$display("layer2 finish");
			end
			else begin
				state <= `layer_2;
			end
		end

		`layer_3: begin
			// $display("finish!!!");
			// $finish;
			calc_rst <= 0;
			sel_weight_counter <= 2;
			sel_x_counter <= 2;
			rest_counter <= 0;
			// rw_w_reg <= 1;
			// rw_x_reg <= 1;
			w_rq_reg <= 1;
			w_wq_reg <= 0;
			x_rq_reg <= 1;
			x_wq_reg <= 0;

			r_or_w <= 1;
			layer3_finish <= 0;

			store_weight_reg <= w_data;
			store_x_reg <= x_data;


			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;



			if (load_x_counter >= (X3_LEN-1) && load_weight_counter >= (W3_LEN-1)) begin
				state <= `store_x4;
				load_x_counter <= 0;
				layer3_finish <= 1;
				load_weight_counter <= 0;
			end
			else if (load_x_counter >= (X3_LEN-1) && load_weight_counter < (W3_LEN-1)) begin
				state <= `store_x4;
				load_x_counter <= 0;
				layer3_finish <= 0;
			end
			else begin
				state <= `layer_3;
			end
		end

		`store_x4: begin
			sel_x_counter <= 3;
			w_rq_reg <= 0;
			w_wq_reg <= 0;
			x_rq_reg <= 0;
			x_wq_reg <= 1;
			
			calc_rst <= 1;
		
			r_or_w <= 0;
			store_x_counter <= store_x_counter + 1;
			// agg_out_reg is redundent. 
			agg_out_reg <= agg_out_acted;
			wx_write_reg <= agg_out_reg;
			if (layer3_finish==1) begin
				state <= `layer_4;
				store_x_counter <= 0;
				$display("layer3 finish");
			end
			else begin
				state <= `layer_3;
			end
		end

		`layer_4: begin
			// $display("finish!!!");
			// $finish;
			calc_rst <= 0;
			sel_weight_counter <= 3;
			sel_x_counter <= 3;
			rest_counter <= 0;
			// rw_w_reg <= 1;
			// rw_x_reg <= 1;
			w_rq_reg <= 1;
			w_wq_reg <= 0;
			x_rq_reg <= 1;
			x_wq_reg <= 0;

			r_or_w <= 1;
			layer4_finish <= 0;

			store_weight_reg <= w_data;
			store_x_reg <= x_data;


			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;



			if (load_x_counter >= (X4_LEN-1) && load_weight_counter >= (W4_LEN-1)) begin
				state <= `store_output;
				load_x_counter <= 0;
				layer4_finish <= 1;
				load_weight_counter <= 0;
			end
			else if (load_x_counter >= (X4_LEN-1) && load_weight_counter < (W4_LEN-1)) begin
				state <= `store_output;
				load_x_counter <= 0;
				layer4_finish <= 0;
			end
			else begin
				state <= `layer_4;
			end
		end

		`store_output: begin
			// sel_x_counter <= 3;
			// w_rq_reg <= 0;
			// w_wq_reg <= 0;
			// x_rq_reg <= 0;
			// x_wq_reg <= 1;
			store_output_counter <= store_output_counter + 1;
			calc_rst <= 1;
		
			// r_or_w <= 0;
			// store_x_counter <= store_x_counter + 1;
			// // agg_out_reg is redundent. 
			agg_out_reg <= agg_out_acted;
			wx_write_reg <= agg_out_reg;
			$display("%d", wx_write_reg);
			
			// if(wx_write_reg==1) begin
			// 	$display("The number is %d.", store_output_counter);
			// 	$finish;
			// end
			// else begin
			// 	$display("It is not %d.", store_output_counter)
			// end
			if (wx_write_reg==1)begin
			 	$display("The number is %d.", store_output_counter);
			 	$finish;
			 end
			else begin
			   	$display("It is not %d.", store_output_counter);
			end

			if (layer4_finish==1) begin
				// state <= `layer_4;
				//$finish;
			end
			else begin
				state <= `layer_4;
			end
		end

	endcase
	end
	
end

endmodule
